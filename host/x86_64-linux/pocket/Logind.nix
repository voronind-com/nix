{ ... }: {
	services.logind = {
		powerKey  = "ignore";
		lidSwitch = "ignore";
	};
}
