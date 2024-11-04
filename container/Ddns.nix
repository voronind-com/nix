{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.ddns;
in {
	options.container.module.ddns = {
		enable = lib.mkEnableOption "the dynamic dns client.";
		address = lib.mkOption {
			default = "10.1.0.31";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/ddns";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.ddns = container.mkContainer cfg {
			bindMounts = {
				"/data" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = true;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				services.cloudflare-dyndns = {
					enable        = true;
					apiTokenFile  = "/data/token";
					deleteMissing = false;
					ipv4          = true;
					ipv6          = false;
					proxied       = false;
					domains = let
						domain = config.container.domain;
					in [
						domain
					] ++ map (sub: "${sub}.${domain}") [
						"cloud"
						"git"
						"mail"
						"office"
						"paste"
						"play"
						"vpn"
					];
				};
			};
		};
	};
}
