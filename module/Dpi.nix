{
	config,
	lib,
	...
}: let
	cfg = config.module.dpi;
in {
	options.module.dpi = {
		aware = lib.mkOption {
			default = false;
			type    = lib.types.bool;
		};
	};
}
