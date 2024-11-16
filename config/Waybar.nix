{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.waybar;
in {
	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			waybar
		];
	};
}
