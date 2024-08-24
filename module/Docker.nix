{ lib, config, ... }: with lib; let
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

	config = mkIf cfg.enable (mkMerge [
		{
			virtualisation.docker.enable = true;

			systemd = {
				services = {
					docker-prune.enable = mkForce cfg.autostart;
					docker.enable       = mkForce cfg.autostart;
				};
				sockets.docker.enable = mkForce cfg.autostart;
			};
		}

		(mkIf cfg.rootless {
			virtualisation.docker.rootless = {
				enable            = true;
				setSocketVariable = true;
			};
		})
	]);
}
