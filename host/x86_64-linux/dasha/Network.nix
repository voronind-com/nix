{ ... }: {
	systemd.network.networks = {
		"10-lan" = {
			matchConfig.Name = "enp5s0";
			linkConfig.RequiredForOnline = "routable";
			networkConfig = {
				DHCP = false;
				DNS = "10.0.0.1";
			};
			address = [
				"10.0.0.7/24"
			];
			routes = [
				{ Gateway = "10.0.0.1"; }
			];
		};
	};
}
