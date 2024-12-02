{
	lib,
	...
}: {
	services.uptime-kuma = {
		enable = true;
		settings = {
			DATA_DIR = "/var/lib/uptime-kuma/";
			PORT     = "64901";
			# HOST = cfg.address;
		};
	};

	systemd.services.uptime-kuma = {
		serviceConfig = {
			DynamicUser = lib.mkForce false;
		};
	};
}
