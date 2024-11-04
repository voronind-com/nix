{
	config,
	lib,
	...
}: let
	cfg = config.module.desktop.bluetooth;
in {
	options.module.desktop.bluetooth.enable = lib.mkEnableOption "the bluetooth support.";

	config = lib.mkIf cfg.enable {
		services.blueman.enable = true;
		hardware.bluetooth = {
			enable      = true;
			powerOnBoot = true;
		};
	};
}
