{
	lib,
	config,
	...
}: {
	"org/gnome/desktop/input-sources" = with lib.gvariant; let
		sources = [
			(mkTuple [ "xkb" "us" ])
			(mkTuple [ "xkb" "ru" ])
		];
	in {
		inherit sources;
		current          = mkUint32 0;
		mru-sources      = sources;
		per-window       = false;
		show-all-sources = true;
		xkb-options = [
			config.module.keyboard.options
		];
	};

	"org/gnome/desktop/peripherals/mouse" = {
		accel-profile  = "flat";
		natural-scroll = true;
		speed          = "0.0";
	};

	"org/gnome/desktop/peripherals/touchpad" = {
		tap-to-click = true;
		two-finger-scrolling-enabled = true;
	};
}
