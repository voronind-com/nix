{ ... }: {
	# REF: https://nixos.wiki/wiki/Systemd-networkd
	# SEE: man 5 systemd.network
	systemd.network = {
		enable = true;
		wait-online.enable = false; # HACK: So we can use both NM and networkd.
	};

	networking = {
		dhcpcd.enable = false;
		networkmanager = {
			enable = true;
			unmanaged = [
				"bridge"
				"ethernet"
				"loopback"
				"wireguard"
			];
		};
	};
}
