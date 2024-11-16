{
	lib,
	config,
	...
}: let
	cfg = config.module.tablet;
in {
	config = lib.mkIf cfg.enable {
		hardware.opentabletdriver.enable = true;
		systemd.user.services.opentabletdriver.wantedBy = [
			"default.target"
		];
	};
}
