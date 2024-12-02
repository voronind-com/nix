{ ... }: {
	services.grocy = {
		enable   = true;
		# dataDir  = "/var/lib/grocy";
		hostName = "stock.voronind.com";
		nginx.enableSSL = false;
		settings = {
			calendar = {
				firstDayOfWeek = 1;
				showWeekNumber = true;
			};
			culture  = "en";
			currency = "RUB";
		};
	};
}
