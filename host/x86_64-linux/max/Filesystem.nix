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
}
