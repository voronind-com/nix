{
	lib,
	...
}: {
	options.module.dpi.bypass = {
		enable = lib.mkEnableOption "the DPI bypass.";
		params = lib.mkOption {
			default = [ ];
			type    = with lib.types; listOf str;
		};
	};
}
