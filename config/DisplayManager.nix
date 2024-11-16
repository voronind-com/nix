{
	config,
	lib,
	...
}: let
	cfg = config.module.dm;
in {
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
