{
	lib,
	config,
	...
}: let
	cfg = config.module.desktop.brightness;
in {
	options.module.desktop.brightness.enable = lib.mkEnableOption "the brightness control.";

	config = lib.mkIf cfg.enable {
		programs.light.enable = true;
	};
}
