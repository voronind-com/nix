{
	config,
	lib,
	pkgs,
	util,
	...
}: let
	cfg = config.module.print;
in {
	options.module.print.enable = lib.mkEnableOption "the support for printers.";

	config = lib.mkIf cfg.enable {
		services.printing = {
			enable = true;
			clientConf = util.trimTabs ''
				DigestOptions DenyMD5
				ServerName 10.0.0.1
			'';
		};
	};
}
