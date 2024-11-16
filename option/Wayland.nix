{
	lib,
	...
}: {
	options.module.wayland.enable = lib.mkEnableOption "the wayland.";
}
