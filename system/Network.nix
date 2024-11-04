{
	lib,
	...
}: {
	networking = {
		useDHCP = lib.mkDefault true;
		networkmanager.enable = true;
	};
}
