{ ... }: {
	fileSystems."/storage/hot" = {
		device  = "/dev/storage/hot";
		fsType  = "ext4";
		options = [ "noatime" "nofail" ];
	};
}
