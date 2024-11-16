{
	lib,
	...
}: {
	options.module.package = {
		common.enable   = lib.mkEnableOption "Common Apps.";
		core.enable     = lib.mkEnableOption "Core apps.";
		creative.enable = lib.mkEnableOption "Creative Apps.";
		desktop.enable  = lib.mkEnableOption "Desktop Apps.";
		dev.enable      = lib.mkEnableOption "Dev Apps.";
		extra.enable    = lib.mkEnableOption "Extra Apps.";
		gaming.enable   = lib.mkEnableOption "Gaming Apps.";
	};
}
