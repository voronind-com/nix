{
	config,
	lib,
	...
}: let
	cfg = config.module.hwmon;
in {
	options.module.hwmon = {
		path = lib.mkOption {
			default = "";
			type    = lib.types.str;
		};
		file = lib.mkOption {
			default = "";
			type    = lib.types.str;
		};
	};
}
