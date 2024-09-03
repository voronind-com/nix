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

			systemd = if cfg.autostart then {} else {
				services = {
					docker-prune.wantedBy = mkForce [];
					docker.wantedBy       = mkForce [];
				};
				sockets.docker.wantedBy = mkForce [];
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
