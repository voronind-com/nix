{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.download;
in {
	options.container.module.download = {
		enable = lib.mkEnableOption "the bit-torrent downloader.";
		address = lib.mkOption {
			default = "10.1.0.12";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 8112;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "download.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/download";
			type    = lib.types.str;
		};
		memLimit = lib.mkOption {
			default = "4G";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.download = container.mkContainer cfg {
			enableTun = true;
			bindMounts = {
				"/var/lib/deluge/.config/deluge" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			}
			// container.attachMedia "download" false
			;

			config = { ... }: container.mkContainerConfig cfg {
					services.deluge = {
						enable     = true;
						dataDir    = "/var/lib/deluge";
						web.enable = true;
					};
					systemd.services.deluged.serviceConfig = {
						MemoryLimit   = cfg.memLimit;
						Restart       = lib.mkForce "always";
						RuntimeMaxSec = "3h";
					};
				};
		};
	};
}
