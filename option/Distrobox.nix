{
	lib,
	...
}: {
	options.module.distrobox.enable = lib.mkEnableOption "the distrobox.";
}
