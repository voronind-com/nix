{ lib, config, pkgs, ... }: with lib; let
	cfg = config.module.desktop.sway;
in {
	options = {
		module.desktop.sway = {
			enable = mkEnableOption "Use Sway WM.";
			extraConfig = mkOption {
				default = "";
				type    = types.str;
			};
		};
	};

	config = mkIf cfg.enable {
		module = {
			desktop = {
				bluetooth.enable  = true;
				brightness.enable = true;
				portal.enable     = true;
				sound.enable      = true;
				waybar.enable     = true;
				wayland.enable    = true;
			};
			realtime.enable = true;
		};

		services.gnome.gnome-keyring.enable       = mkForce false;
		environment.variables.XDG_CURRENT_DESKTOP = "sway";

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
