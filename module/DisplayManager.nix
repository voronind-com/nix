{
	config,
	lib,
	...
}: let
	cfg = config.module.desktop.dm;
in {
	options.module.desktop.dm.enable = lib.mkEnableOption "the display manager.";

	config = lib.mkIf cfg.enable {
		services.xserver = {
			enable = true;
			xkb = {
				layout  = config.module.keyboard.layouts;
				options = config.module.keyboard.options;
			};
		};
	};
}
