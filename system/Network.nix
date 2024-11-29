{ ... }: {
	# REF: https://nixos.wiki/wiki/Systemd-networkd
	# SEE: man 5 systemd.network
	systemd.network = {
		enable = true;
		wait-online.enable = false; # HACK: So we can use both NM and networkd.
	};

	networking = {
		dhcpcd.enable = false;
		useDHCP       = false;
		useNetworkd   = true;
		networkmanager = {
			enable = true;
			unmanaged = [
				"type:bridge"
				"type:ethernet"
				"type:loopback"
				# "type:wireguard"
			];
		};
	};

	# NOTE: Debugging.
	# systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
}
