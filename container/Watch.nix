{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.watch;
in {
	options.container.module.watch = {
		enable = lib.mkEnableOption "the media server.";
		address = lib.mkOption {
			default = "10.1.0.11";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 8096;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "watch.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/watch";
			type    = lib.types.str;
		};
		memLimit = lib.mkOption {
			default = "8G";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"cache"
			"data"
		];

		containers.watch = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/jellyfin" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
				"/var/cache/jellyfin" = {
					hostPath   = "${cfg.storage}/cache";
					isReadOnly = false;
				};
				"/dev/dri" = {
					hostPath   = "/dev/dri";
					isReadOnly = false;
				};
			}
			// container.attachMedia "anime"    true
			// container.attachMedia "download" true
			// container.attachMedia "movie"    true
			// container.attachMedia "music"    true
			// container.attachMedia "photo"    true
			// container.attachMedia "porn"     true
			// container.attachMedia "show"     true
			// container.attachMedia "study"    true
			// container.attachMedia "work"     true
			// container.attachMedia "youtube"  true
			;

			allowedDevices = [
				{
					modifier = "rwm";
					node     = "/dev/dri/renderD128";
				}
			];

			config = { ... }: container.mkContainerConfig cfg {
				systemd.services.jellyfin.serviceConfig.MemoryLimit = cfg.memLimit;
				services.jellyfin = {
					enable   = true;
					cacheDir = "/var/cache/jellyfin";
					dataDir  = "/var/lib/jellyfin";
				};
				# users.users.jellyfin.extraGroups = [
				#   "video"
				#   "render"
				# ];
			};
		};
	};
}
