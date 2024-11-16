# Screen configuration.
{
	lib,
	...
}: {
	options.module.display.dpiAware = lib.mkOption {
		default = false;
		type    = lib.types.bool;
	};
}
