{
	lib,
	...
}: {
	options.module.autoupdate.enable = lib.mkEnableOption "the system auto-updates.";
}
