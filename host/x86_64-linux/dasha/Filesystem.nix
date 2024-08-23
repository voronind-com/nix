{ ... }: {
	fileSystems = {
		"/storage/hot" = {
			device  = "/dev/storage/hot";
			fsType  = "ext4";
			options = [ "nofail" "noatime" ];
		};

		"/storage/cold" = {
			device  = "/dev/storage/cold";
			fsType  = "ext4";
			options = [ "nofail" "noatime" ];
		};
	};
}
