{ ... }: {
	systemd.network = {
		networks = {
			"10-lan" = {
				matchConfig.Name = "enp5s0";
				linkConfig.RequiredForOnline = "routable";
				networkConfig = {
					DHCP = "yes";
					DNS = "10.0.0.1";
					IPv6AcceptRA = true;
				};
				address = [
					"10.0.0.7/24"
				];
				routes = [
					{ Gateway = "10.0.0.1"; }
				];
			};
		};
	};
}
