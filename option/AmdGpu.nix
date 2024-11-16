{
	lib,
	...
}: {
	options.module.amd.gpu.enable = lib.mkEnableOption "the AMD Gpu support.";
}
