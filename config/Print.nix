{
	config,
	lib,
	util,
	...
}: let
	cfg = config.module.print;
in {
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
