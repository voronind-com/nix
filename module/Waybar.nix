{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.desktop.waybar;
in {
	options.module.desktop.waybar.enable = lib.mkEnableOption "the Waybar.";

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			waybar
		];
	};
}
