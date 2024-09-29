{ lib, config, pkgs, ... }: with lib; let
	cfg = config.module.desktop.waybar;
in {
	options = {
		module.desktop.waybar = {
			enable = mkEnableOption "Use Waybar.";
		};
	};

	config = mkIf cfg.enable {
		environment.systemPackages = with pkgs; [ waybar ];
	};
}

