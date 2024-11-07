{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.waybar;
in {
	options.module.waybar.enable = lib.mkEnableOption "the Waybar.";

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			waybar
		];
	};
}
