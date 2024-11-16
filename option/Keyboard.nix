# Keyboard configuration.
{
	lib,
	...
}: {
	options.module.keyboard = {
		layouts = lib.mkOption {
			default = "us,ru";
			type    = lib.types.str;
		};
		options = lib.mkOption {
			default = "grp:toggle";
			type    = lib.types.str;
		};
	};
}
