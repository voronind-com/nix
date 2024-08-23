{ ... }: {
	fileSystems = {
		"/storage/hot" = {
			device  = "/dev/storage/hot";
			fsType  = "ext4";
			options = [ "noatime" "nofail" ];
		};

		"/storage/cold_1" = {
			device  = "/dev/storage/cold_1";
			fsType  = "ext4";
			options = [ "noatime" "noauto" "nofail" ];
		};

		"/storage/cold_2" = {
			device  = "/dev/storage/cold_2";
			fsType  = "ext4";
			options = [ "noatime" "noauto" "nofail" ];
		};
	};
}
