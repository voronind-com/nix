{
	config,
	container,
	lib,
	pkgs,
	...
}: let
	cfg = config.container.module.read;
in {
	options.container.module.read = {
		enable = lib.mkEnableOption "the reading server.";
		address = lib.mkOption {
			default = "10.1.0.39";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 5000;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "read.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/read";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.read = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/kavita" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			}
			// container.attachMedia "book"  true
			// container.attachMedia "manga" true
			;

			config = { ... }: container.mkContainerConfig cfg {
				services.kavita = {
					enable = true;
					dataDir      = "/var/lib/kavita";
					tokenKeyFile = pkgs.writeText "KavitaToken" "xY19aQOa939/Ie6GCRGbubVK8zRwrgBY/20AuyMpYshUjwK1Uyl7bw1yknVh6jJIFIfwq2vAjeotOUq7NEsf9Q==";
					settings = {
						IpAddresses = cfg.address;
						Port        = cfg.port;
					};
				};
			};
		};
	};
}
