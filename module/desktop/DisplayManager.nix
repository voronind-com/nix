{ ... }: {
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable   = true;
	services.xserver.desktopManager.gnome.enable = true;
	services.xserver.xkb = {
		layout  = "us,ru";
		options = "grp:caps_toggle,lv3:ralt_switch";
	};
}