{
	lib,
	...
}: {
	# REF: https://nixos.wiki/wiki/Systemd-networkd
	systemd.network = {
		enable = true;
		wait-online.enable = false; # So we can use both NM and networkd.
	};

	networking = {
		networkmanager.enable = true;
		dhcpcd.enable = false;
	};
}
