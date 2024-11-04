{ ... }: {
	# Enable non-free firmware.
	hardware.enableRedistributableFirmware = true;

	# Configure bootloader.
	boot = {
		tmp.useTmpfs = true;
		loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot = {
				enable = true;
				configurationLimit = 10;
			};
		};
		initrd = {
			kernelModules = [
				"dm-snapshot"
			];
			availableKernelModules = [
				"ahci"
				"ata_piix"
				"mptspi"
				"nvme"
				"sd_mod"
				"sr_mod"
				"usb_storage"
				"usbhid"
				"xhci_pci"
			];
		};
	};
}
