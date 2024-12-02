{
	lib,
	pkgs,
	...
}: {
	services.paperless = {
		enable = true;
		address      = "0.0.0.0";
		dataDir      = "/var/lib/paperless";
		# port         = cfg.port;
		passwordFile = pkgs.writeText "PaperlessPassword" "root"; # NOTE: Only for initial setup, change later.
		settings = {
			PAPERLESS_ADMIN_USER   = "root";
			PAPERLESS_DBHOST       = "/run/postgresql";
			PAPERLESS_DBENGINE     = "postgresql";
			PAPERLESS_DBNAME       = "paperless";
			PAPERLESS_DBPASS       = "paperless";
			PAPERLESS_DBUSER       = "paperless";
			PAPERLESS_OCR_LANGUAGE = "rus";
			# PAPERLESS_REDIS        = "redis://${config.container.module.redis.address}:${toString config.container.module.redis.port}";
			PAPERLESS_URL          = "https://paper.voronind.com";
		};
	};
}
