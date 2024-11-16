{
	lib,
	...
}: {
	options.module.realtime.enable = lib.mkEnableOption "the realtime access.";
}
