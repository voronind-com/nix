{
	lib,
	...
}: {
	options.module.gnome.enable = lib.mkEnableOption "the Gnome DE.";
}
