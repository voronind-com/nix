{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.distrobox;
in {
	config = lib.mkIf cfg.enable {
		# Distrobox works best with Podman, so enable it here.
		module.podman.enable = true;
		environment.systemPackages = with pkgs; [
			distrobox
		];
	};
}