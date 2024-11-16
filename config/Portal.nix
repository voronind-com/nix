# Portals are needed for Wayland apps to select files, screen shares etc.
{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.portal;
in {
	config = lib.mkIf cfg.enable {
		xdg.portal = {
			enable = true;
			wlr.enable       = true;
			xdgOpenUsePortal = false;
			extraPortals = with pkgs; [
				xdg-desktop-portal-gtk
			];
			config.common.default = [
				"gtk"
				"wlr"
			];
		};
	};
}
