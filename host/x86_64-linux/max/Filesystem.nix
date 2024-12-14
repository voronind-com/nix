{ ... }: {
	fileSystems = {
		"/home" = {
			device = "/dev/storage/home";
			fsType = "ext4";
			options = [
				"noatime"
			];
		};
	};

	swapDevices = [{
		device = "/dev/storage/swap";
		randomEncryption.enable = true;
		options = [
			"nofail"
		];
	}];
}
