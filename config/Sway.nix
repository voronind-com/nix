{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.sway;
in {
	config = lib.mkIf cfg.enable {
		services.gnome.gnome-keyring.enable = lib.mkForce false;
		environment.variables.XDG_CURRENT_DESKTOP = "sway";
		module = {
			bluetooth.enable  = true;
			brightness.enable = true;
			portal.enable     = true;
			realtime.enable   = true;
			sound.enable      = true;
			waybar.enable     = true;
			wayland.enable    = true;
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