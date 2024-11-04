{
	lib,
	config,
	...
}: let
	cfg = config.module.tablet;
in {
	options.module.tablet.enable = lib.mkEnableOption "the support for tables.";

	config = lib.mkIf cfg.enable {
		hardware.opentabletdriver.enable = true;
		systemd.user.services.opentabletdriver.wantedBy = [
			"default.target"
		];
	};
}
