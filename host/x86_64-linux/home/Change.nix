{ ... }: {
	services.changedetection-io = {
		enable        = true;
		baseURL       = "change.voronind.com";
		behindProxy   = true;
		listenAddress = "0.0.0.0";
		port          = 5001;
	};
}
