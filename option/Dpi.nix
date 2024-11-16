# Screen density configuration.
{
	lib,
	...
}: {
	options.module.dpi.aware = lib.mkOption {
		default = false;
		type    = lib.types.bool;
	};
}
