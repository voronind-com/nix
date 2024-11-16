{
	lib,
	...
}: {
	options.module.brightness.enable = lib.mkEnableOption "the brightness control.";
}
