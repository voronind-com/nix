{
	lib,
	...
}: {
	options.module.portal.enable = lib.mkEnableOption "the portals.";
}
