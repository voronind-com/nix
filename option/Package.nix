{
	lib,
	...
}: {
	options.module.package = {
		common     = lib.mkEnableOption "Common Apps.";
		core       = lib.mkEnableOption "Core apps.";
		creativity = lib.mkEnableOption "Creative Apps.";
		desktop    = lib.mkEnableOption "Desktop Apps.";
		dev        = lib.mkEnableOption "Dev Apps.";
		extra      = lib.mkEnableOption "Extra Apps.";
		gaming     = lib.mkEnableOption "Gaming Apps.";
	};
}
