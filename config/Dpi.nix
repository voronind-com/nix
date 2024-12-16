{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.dpi.bypass;

	whitelist = lib.optionalString (
		(builtins.length cfg.whitelist) != 0
	) "--hostlist ${pkgs.writeText "zapret-whitelist" (lib.concatStringsSep "\n" cfg.whitelist)}";

	blacklist = lib.optionalString (
		(builtins.length cfg.blacklist) != 0
	) "--hostlist-exclude ${pkgs.writeText "zapret-blacklist" (lib.concatStringsSep "\n" cfg.blacklist)}";

	params = lib.concatStringsSep " " cfg.params;

	qnum = toString cfg.qnum;
in {
	disabledModules = [ "services/networking/zapret.nix" ];
	# imports = [ "${inputs.nixpkgsMaster}/nixos/modules/services/networking/zapret.nix" ];

	config = lib.mkIf cfg.enable (lib.mkMerge [
		{
			systemd.services.zapret = {
				description = "DPI bypass service";
				wantedBy = [ "multi-user.target" ];
				after = [ "network.target" ];
				serviceConfig = {
					ExecStart = "${cfg.package}/bin/nfqws --pidfile=/run/nfqws.pid ${params} ${whitelist} ${blacklist} --qnum=${qnum}";
					Type = "simple";
					PIDFile = "/run/nfqws.pid";
					Restart = "always";
					RuntimeMaxSec = "1h"; # This service loves to crash silently or cause network slowdowns. It also restarts instantly. Restarting it at least hourly provided the best experience.

					# Hardening.
					DevicePolicy = "closed";
					KeyringMode = "private";
					PrivateTmp = true;
					PrivateMounts = true;
					ProtectHome = true;
					ProtectHostname = true;
					ProtectKernelModules = true;
					ProtectKernelTunables = true;
					ProtectSystem = "strict";
					ProtectProc = "invisible";
					RemoveIPC = true;
					RestrictNamespaces = true;
					RestrictRealtime = true;
					RestrictSUIDSGID = true;
					SystemCallArchitectures = "native";
				};
			};
		}
		# Route system traffic via service for specified ports.
		(lib.mkIf cfg.configureFirewall {
			networking.firewall.extraCommands =
				let
					httpParams = lib.optionalString (
						cfg.httpMode == "first"
					) "-m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6";

					udpPorts = lib.concatStringsSep "," cfg.udpPorts;
				in
					''
					iptables -t mangle -I POSTROUTING -p tcp --dport 443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num ${qnum} --queue-bypass
					''
				+ lib.optionalString (cfg.httpSupport) ''
					iptables -t mangle -I POSTROUTING -p tcp --dport 80 ${httpParams} -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num ${qnum} --queue-bypass
				''
				+ lib.optionalString (cfg.udpSupport) ''
					iptables -t mangle -A POSTROUTING -p udp -m multiport --dports ${udpPorts} -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num ${qnum} --queue-bypass
				'';
		})
	]);
}
