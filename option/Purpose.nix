{
	lib,
	...
}: {
	options.module.purpose = {
		creativity = lib.mkEnableOption "creativity modules";
		desktop    = lib.mkEnableOption "desktop modules.";
		disown     = lib.mkEnableOption "modules for machines not used by me.";
		gaming     = lib.mkEnableOption "gaming modules.";
		laptop     = lib.mkEnableOption "laptop modules.";
		phone      = lib.mkEnableOption "phone modules.";
		router     = lib.mkEnableOption "router modules.";
		server     = lib.mkEnableOption "server modules.";
		work       = lib.mkEnableOption "work modules.";
	};
}
