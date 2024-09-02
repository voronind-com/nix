# SOURCE: https://github.com/bol-van/zapret
{ lib, config, pkgs, util, ... }: with lib; let
	cfg = config.module.zapret;

	whitelist = if cfg.whitelist != null then
		"--hostlist ${pkgs.writeText "ZapretWhitelist" (util.trimTabs cfg.whitelist)}"
	else "";

	blacklist = if cfg.blacklist != null then
		"--hostlist-exclude ${pkgs.writeText "ZapretBlacklist" (util.trimTabs cfg.blacklist)}"
	else "";

	# ISSUE: Seems broken. Adds nothing automatically.
	autolist = if cfg.autolist != null then
		"--hostlist-auto ${cfg.autolist}"
	else "";
in {
	options = {
		module.zapret = mkOption {
			default = {};
			type = types.submodule {
				options = {
					enable = mkEnableOption "Enable Zapret service.";
					params = mkOption {
						default = null;
						type    = types.str;
					};
					whitelist = mkOption {
						default = null;
						type    = types.nullOr types.str;
					};
					blacklist = mkOption {
						default = null;
						type    = types.nullOr types.str;
					};
					autolist = mkOption {
						default = null;
						type    = types.nullOr types.str;
					};
					qnum = mkOption {
						default = 200;
						type    = types.int;
					};
				};
			};
		};
	};

	config = mkIf cfg.enable {
		networking.firewall.extraCommands = ''
			iptables -t mangle -I POSTROUTING -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num ${toString cfg.qnum} --queue-bypass
		'';

		systemd = {
			services.zapret = {
				description = "FRKN";
				wantedBy = [ ];
				requires = [ "network.target" ];
				path = with pkgs; [ zapret ];
				serviceConfig = {
					ExecStart  = "${pkgs.zapret}/bin/nfqws --pidfile=/run/nfqws.pid ${cfg.params} ${whitelist} ${blacklist} ${autolist} --qnum=${toString cfg.qnum}";
					Type       = "simple";
					PIDFile    = "/run/nfqws.pid";
					ExecReload = "/bin/kill -HUP $MAINPID";
					Restart    = "always";
					RestartSec = "5s";
				};
			};

			timers.zapret = {
				timerConfig = {
					OnBootSec = 5;
					Unit      = "zapret.service";
				};
				wantedBy = [ "timers.target" ];
			};
		};
	};
}
