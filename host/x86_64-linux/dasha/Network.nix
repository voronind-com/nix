{ ... }: {
	systemd.network = {
		networks = {
			"10-lan" = {
				matchConfig.Name = "enp5s0";
				linkConfig.RequiredForOnline = "routable";
				networkConfig = {
					DHCP = "yes";
					IPv6AcceptRA = true;
				};
				address = [
					"10.0.0.7/24"
				];
				routes = [
					{ routeConfig.Gateway = "10.0.0.1"; }
				];
			};
		};
	};
}
