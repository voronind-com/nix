{
	__findFile,
	pkgs,
	...
} @args: let
	package = (pkgs.callPackage <package/privatebin> args);
in {
	environment.systemPackages = [ package ];
	systemd.packages = [ package ];

	users.users.paste = {
		group        = "nginx";
		isSystemUser = true;
	};

	services = {
		phpfpm.pools.paste = {
			group = "nginx";
			user  = "paste";
			phpPackage = pkgs.php;
			settings = {
				"catch_workers_output"       = true;
				"listen.owner"               = "nginx";
				"php_admin_flag[log_errors]" = true;
				"php_admin_value[error_log]" = "stderr";
				"pm"                         = "dynamic";
				"pm.max_children"            = "32";
				"pm.max_requests"            = "500";
				"pm.max_spare_servers"       = "4";
				"pm.min_spare_servers"       = "2";
				"pm.start_servers"           = "2";
			};
			phpEnv = {
				# CONFIG_PATH = "${package}/cfg"; # NOTE: Not working?
			};
		};

		nginx = {
			enable = true;
			virtualHosts."paste.voronind.com" = {
				root = "${package}";
			};
		};
	};
}
