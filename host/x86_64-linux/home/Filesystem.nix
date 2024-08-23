{ ... }: {
	fileSystems = {
		"/storage/cold_1" = {
			device  = "/dev/storage/cold_1";
			fsType  = "ext4";
			options = [ "nofail" "noatime" ];
		};

		"/storage/cold_2" = {
			device  = "/dev/storage/cold_2";
			fsType  = "ext4";
			options = [ "nofail" "noatime" ];
		};

		"/storage/hot" = {
			device  = "/dev/storage/hot";
			fsType  = "ext4";
			options = [ "nofail" "noatime" ];
		};
	};

	# swapDevices = [{
	# 	device  = "/storage/hot/.swapfile";
	# 	size    = 128 * 1024;
	# 	options = [ "nofail" ];
	# }];
}
