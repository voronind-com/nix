{ ... }: {
	networking = {
		networkmanager = {
			enable = true;
			# unmanaged = [
			# 	"type:bridge"
			# 	"type:ethernet"
			# 	"type:loopback"
			# 	# "type:wireguard"
			# ];
		};
	};

	# NOTE: Debugging.
	# systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
}
