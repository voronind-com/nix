{
	__findFile,
	config,
	container,
	lib,
	pkgs,
	util,
	...
} @args: let
	cfg     = config.container.module.home;
	package = (pkgs.callPackage <package/homer> args);
in {
	options.container.module.home = {
		enable = lib.mkEnableOption "the dashboard.";
		address = lib.mkOption {
			default = "10.1.0.18";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 80;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "home.${config.container.domain}";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		containers.home = container.mkContainer cfg {
			config = { ... }: container.mkContainerConfig cfg {
				environment.systemPackages = [
					package
				];
				systemd.packages = [
					package
				];

				services.nginx = {
					enable = true;
					virtualHosts.${cfg.domain} = container.mkServer {
						default = true;
						root    = "${package}";
						locations = {
							"/".extraConfig = util.trimTabs ''
								try_files $uri $uri/index.html;
							'';
						};
					};
				};
			};
		};
	};
}
