{
	lib,
	config,
	...
}: let
	cfg = config.module.docker;
in {
	options.module.docker = {
		enable = lib.mkEnableOption "the docker.";
		rootless = lib.mkOption {
			default = false;
			type    = lib.types.bool;
		};
		autostart = lib.mkOption {
			default = false;
			type    = lib.types.bool;
		};
	};

	config = lib.mkIf cfg.enable (lib.mkMerge [
		{
			virtualisation.docker.enable = true;

			systemd = if cfg.autostart then { } else {
				sockets.docker.wantedBy = lib.mkForce [ ];
				services = {
					docker-prune.wantedBy = lib.mkForce [ ];
					docker.wantedBy       = lib.mkForce [ ];
				};
			};
		}

		(lib.mkIf cfg.rootless {
			virtualisation.docker.rootless = {
				enable = true;
				setSocketVariable = true;
			};
		})
	]);
}
