# Polkit agent is used by apps to ask for Root password with a popup.
{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.desktop.polkit;
in {
	options.module.desktop.polkit.enable = lib.mkEnableOption "the polkit.";

	config = lib.mkIf cfg.enable {
		security.polkit.enable = true;
		systemd = {
			packages = with pkgs; [
				polkit-kde-agent
			];
			user = {
				services.plasma-polkit-agent = {
					environment.PATH = lib.mkForce null;
					serviceConfig = {
						Restart    = "always";
						RestartSec = 2;
						Slice      = "session.slice";
					};
					wantedBy = [
						"gui-session.target"
					];
				};
			};
		};
	};
}
