{
	lib,
	...
}: {
	options.module.amd.compute.enable = lib.mkEnableOption "the AMD Rocm support i.e. for Blender.";
}
