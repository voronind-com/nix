# Improve DE performance.
{ lib, config, ... }: with lib; let
	cfg = config.module.realtime;
in {
	options = {
		module.realtime.enable = mkEnableOption "Realtime access.";
	};

	config = mkIf cfg.enable {
		security.pam.loginLimits = [
			{ domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
		];
	};
}
