{ ... }: {
	systemd.network = {
		networks = {
			"10-lan" = {
				matchConfig.Name = "enp4s0";
				linkConfig.RequiredForOnline = "routable";
				networkConfig = {
					DHCP = "yes";
					DNS = "10.0.0.1";
					IPv6AcceptRA = true;
				};
				address = [
					"10.0.0.3/24"
				];
				routes = [
					{ routeConfig.Gateway = "10.0.0.1"; }
				];
			};
		};
	};
}
