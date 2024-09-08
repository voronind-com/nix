{ ... }: {
	virtualisation.vmVariant = {
		virtualisation = {
			memorySize = 4 * 1024;
			diskSize   = 20 * 1024;
			cores      = 4;
			restrictNetwork = false;
			resolution = {
				x = 1280;
				y = 720;
			};
		};
	};
}
