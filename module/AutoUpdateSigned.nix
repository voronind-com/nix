# System automatic updates.
# This is a systemd service that pulls updates every hour.
# Unlike system.autoUpgrade, this script also verifies my git signature
# to prevent unathorized changes to hosts.
{ const, pkgs, lib, util, config, ... }: with lib; let
	cfg = config.module.autoupdate;
in {
	options = {
		module.autoupdate = {
			enable = mkEnableOption "System auto-updates." // { default = true; };
		};
	};

	config = mkIf cfg.enable {
		systemd.services.autoupdate = util.mkStaticSystemdService {
			enable      = true;
			description = "Signed system auto-update.";
			serviceConfig.Type = "oneshot";
			path = with pkgs; [
				bash
				git
				gnumake
				nixos-rebuild
				openssh
			];
			script = ''
				pushd /tmp
				rm -rf ./nixos
				${getExe pkgs.git} clone --depth=1 --single-branch --branch=main ${const.url} ./nixos
				pushd ./nixos
				${getExe pkgs.git} verify-commit HEAD || {
					echo "Verification failed."
					exit 1
				};
				${getExe pkgs.gnumake} switch
			'';
			after = [ "network-online.target" ];
			wants = [ "network-online.target" ];
		};

		systemd.timers.autoupdate = {
			enable = true;
			timerConfig = {
				OnCalendar = "hourly";
				Persistent = true;
				Unit       = "autoupdate.service";
				# RandomizedDelaySec = 60;
			};
			wantedBy = [ "timers.target" ];
		};
	};
}
