{
	lib,
	...
}: {
	options.module.bluetooth.enable = lib.mkEnableOption "the bluetooth support.";
}
