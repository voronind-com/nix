{ pkgs, lib, config, ... }: with lib; let
	cfg = config.module.docker;
in {
	options = {
		module.docker = {
			enable = mkEnableOption "Enable Cocker";
			rootless = mkOption {
				default = false;
				type    = types.bool;
			};
			autostart = mkOption {
				default = false;
				type    = types.bool;
			};
		};
	};

	config = mkIf cfg.enable {
		virtualisation.docker.enable = true;

		virtualisation.docker.rootless = mkIf cfg.rootless {
			enable = true;
			setSocketVariable = true;
		};

		systemd.services.docker-prune.enable = mkForce cfg.autostart;
		systemd.services.docker.enable       = mkForce cfg.autostart;
		systemd.sockets.docker.enable        = mkForce cfg.autostart;
	};

	# NOTE: mkMerge example.
	# config = mkIf cfg.enable (mkMerge [
	# 	{ virtualisation.docker.enable = true; }
	# 	(mkIf cfg.rootless {
	# 		virtualisation.docker.rootless = {
	# 			enable = true;
	# 			setSocketVariable = true;
	# 		};
	# 	})
	# ]);
}
