{
	lib,
	...
}: {
	options.module.ftpd = {
		enable = lib.mkEnableOption "the FTP server";
		storage = lib.mkOption {
			default = null;
			type    = lib.types.str;
		};
	};
}
