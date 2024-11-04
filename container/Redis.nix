{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.redis;
in {
	options.container.module.redis = {
		enable = lib.mkEnableOption "the Redis server.";
		address = lib.mkOption {
			default = "10.1.0.38";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 6379;
			type    = lib.types.int;
		};
	};

	config = lib.mkIf cfg.enable {
		containers.redis = container.mkContainer cfg {
			config = { ... }: container.mkContainerConfig cfg {
				services.redis.servers.main = {
					enable = true;
					port   = cfg.port;
					bind   = cfg.address;
					extraParams = [
						"--protected-mode no"
					];
				};
			};
		};
	};
}
