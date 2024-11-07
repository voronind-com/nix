{
	lib,
	config,
	...
}: let
	cfg = config.module.brightness;
in {
	options.module.brightness.enable = lib.mkEnableOption "the brightness control.";

	config = lib.mkIf cfg.enable {
		programs.light.enable = true;
	};
}
