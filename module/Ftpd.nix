{
	config,
	lib,
	pkgs,
	util,
	...
}: let
	cfg = config.module.ftpd;
in
	{
	options.module.ftpd = {
		enable = lib.mkEnableOption "the FTP server";
		storage = lib.mkOption {
			default = null;
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		services.vsftpd = {
			enable = true;
			allowWriteableChroot    = true;
			anonymousMkdirEnable    = true;
			anonymousUmask          = "000";
			anonymousUploadEnable   = true;
			anonymousUser           = true;
			anonymousUserHome       = cfg.storage;
			anonymousUserNoPassword = true;
			localUsers              = false;
			writeEnable             = true;
			extraConfig = util.trimTabs ''
				anon_other_write_enable=YES
			'';
		};
	};
}
