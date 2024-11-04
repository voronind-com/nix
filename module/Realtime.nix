# Improve DE performance.
{
	lib,
	config,
	...
}: let
	cfg = config.module.realtime;
in {
	options.module.realtime.enable = lib.mkEnableOption "the realtime access.";

	config = lib.mkIf cfg.enable {
		security.pam.loginLimits = [{
			domain = "@users";
			item   = "rtprio";
			type   = "-";
			value  = 1;
		}];
	};
}
