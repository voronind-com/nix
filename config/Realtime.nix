# Improve DE performance.
{
	lib,
	config,
	...
}: let
	cfg = config.module.realtime;
in {
	config = lib.mkIf cfg.enable {
		security.pam.loginLimits = [{
			domain = "@users";
			item   = "rtprio";
			type   = "-";
			value  = 1;
		}];
	};
}
