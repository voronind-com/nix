{ pkgs, lib, config, ... }: with lib; let
	cfg = config.module.distrobox;
in {
	options = {
		module.distrobox = {
			enable = mkEnableOption "Distrobox.";
		};
	};

	config = mkIf cfg.enable {
		# Distrobox works best with Podman, so enable it here.
		module.podman.enable = true;

		environment.systemPackages = with pkgs; [ distrobox ];
	};
}
