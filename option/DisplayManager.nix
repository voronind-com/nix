{
	lib,
	...
}: {
	options.module.dm.enable = lib.mkEnableOption "the display manager.";
}
