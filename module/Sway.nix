{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.desktop.sway;
in {
	options.module.desktop.sway = {
		enable = lib.mkEnableOption "the Sway WM.";
		extraConfig = lib.mkOption {
			default = "";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		services.gnome.gnome-keyring.enable = lib.mkForce false;
		environment.variables.XDG_CURRENT_DESKTOP = "sway";
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
