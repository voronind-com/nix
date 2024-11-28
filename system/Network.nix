{ ... }: {
	# REF: https://nixos.wiki/wiki/Systemd-networkd
	# SEE: man 5 systemd.network
	systemd.network = {
		enable = true;
		wait-online.enable = false; # HACK: So we can use both NM and networkd.
	};

	networking = {
		networkmanager.enable = true;
		dhcpcd.enable = false;
	};
}
