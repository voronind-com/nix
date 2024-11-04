# System automatic updates.
# This is a systemd service that pulls updates every hour.
# Unlike system.autoUpgrade, this script also verifies my git signature
# to prevent unathorized changes to hosts.
{
	config,
	const,
	lib,
	pkgs,
	secret,
	util,
	...
}: let
	cfg = config.module.autoupdate;
in {
	options.module.autoupdate = {
		enable = lib.mkEnableOption "the system auto-updates.";
	};

	config = lib.mkIf cfg.enable {
		programs.git = {
			enable = true;
			config = {
				gpg.ssh.allowedSignersFile = toString secret.crypto.sign.git.allowed;
			};
		};

		systemd.services.autoupdate = util.mkStaticSystemdService {
			enable = true;
			description = "Signed system auto-update.";
			serviceConfig = {
				Type = "oneshot";
			};
			path = with pkgs; [
				bash
				coreutils
				git
				gnumake
				nixos-rebuild
				openssh
			];
			script = ''
				pushd /tmp
				rm -rf ./nixos
				git clone --depth=1 --single-branch --branch=main ${const.url} ./nixos
				pushd ./nixos
				git verify-commit HEAD && git fsck || {
					echo "Verification failed."
					exit 1
				};
				timeout 55m make switch
			'';
			after = [
				"network-online.target"
			];
			wants = [
				"network-online.target"
			];
		};

		systemd.timers.autoupdate = {
			enable = true;
			timerConfig = {
				OnCalendar = "hourly";
				Persistent = true;
				RandomizedDelaySec = 60;
				Unit = "autoupdate.service";
			};
			wantedBy = [
				"timers.target"
			];
		};
	};
}
