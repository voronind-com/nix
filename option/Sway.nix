{
	lib,
	...
}: {
	options.module.sway = {
		enable = lib.mkEnableOption "the Sway WM.";
		extraConfig = lib.mkOption {
			default = "";
			type    = lib.types.str;
		};
	};
}
