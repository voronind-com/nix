{
	config,
	lib,
	...
}: let
	cfg = config.module.sound;
in {
	options.module.sound.enable = lib.mkEnableOption "the sound.";

	config = lib.mkIf cfg.enable {
		hardware.pulseaudio.enable = false;
		security.rtkit.enable      = true;
		services.pipewire = {
			enable = true;
			pulse.enable = true;
			alsa = {
				enable = true;
				support32Bit = true;
			};
		};
	};
}
