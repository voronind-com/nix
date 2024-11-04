# NOTE: Login to contaier, run passwd and use that root/pw combo for administration. `AllowFrom = all` doesn't seem to work.
# ipp://192.168.2.237
# Pantum M6500W-Series
{
	__findFile,
	config,
	container,
	lib,
	pkgs,
	...
} @args: let
	cfg     = config.container.module.print;
	host    = config.container.host;
	package = pkgs.callPackage <package/print> args;
in {
	options.container.module.print = {
		enable = lib.mkEnableOption "the printing server.";
		address = lib.mkOption {
			default = "10.1.0.46";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 631;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "print.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/print";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.print = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/cups" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				networking.interfaces."eth0".ipv4.routes = [
					{
						address = "192.168.2.237"; # NOTE: Printer's IP address.
						prefixLength = 32;
						via = host;
					}
				];

				services.printing = {
					enable          = true;
					allowFrom       = [ "all" ];
					browsing        = true;
					defaultShared   = true;
					drivers         = [ package ];
					listenAddresses = [ "${cfg.address}:${toString cfg.port}" ];
					startWhenNeeded = true;
					stateless       = false;
					webInterface    = true;
				};
			};
		};
	};
}
