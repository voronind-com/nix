{ lib, config, ... }: with lib; let
	cfg = config.module.desktop.waybar;
in {
	options = {
		module.desktop.waybar = {
			enable = mkEnableOption "Use Waybar.";
		};
	};

	config = mkIf cfg.enable {
		programs.waybar.enable = true;

		# Do not start automatically ffs.
		systemd.user.services.waybar.enable = lib.mkForce false;
	};
}

