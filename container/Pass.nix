{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.pass;
in {
	options.container.module.pass = {
		enable = lib.mkEnableOption "the password manager.";
		address = lib.mkOption {
			default = "10.1.0.9";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 8000;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "pass.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/pass";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.pass = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/bitwarden_rs" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				services.vaultwarden = {
					enable = true;
					dbBackend       = "sqlite";
					environmentFile = "/var/lib/bitwarden_rs/Env";
					config = {
						DATA_FOLDER       = "/var/lib/bitwarden_rs";
						DOMAIN            = "http://${cfg.domain}";
						ROCKET_ADDRESS    = cfg.address;
						ROCKET_PORT       = cfg.port;
						SIGNUPS_ALLOWED   = false;
						WEB_VAULT_ENABLED = true;
					};
				};
			};
		};
	};
}
