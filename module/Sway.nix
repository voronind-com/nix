{ lib, config, pkgs, ... } @args: with lib; let
	cfg = config.module.desktop.sway;
in {
	options = {
		module.desktop.sway = {
			enable = mkEnableOption "Use Sway WM.";
		};
	};

	config = mkIf cfg.enable {
		module = {
			desktop = {
				bluetooth.enable  = true;
				brightness.enable = true;
				portal.enable     = true;
				sound.enable      = true;
				wayland.enable    = true;
			};
			realtime.enable = true;
		};

		services.gnome.gnome-keyring.enable       = mkForce false;
		environment.variables.XDG_CURRENT_DESKTOP = "sway";

		programs.waybar.enable = true;
		programs.sway = {
			enable = true;
			wrapperFeatures = {
				base = true;
				gtk  = true;
			};
			extraPackages = with pkgs; [
				swaykbdd
			];
		};
	};
}
