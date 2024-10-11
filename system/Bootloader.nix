{ ... }:
{
  # Enable non-free firmware.
  hardware.enableRedistributableFirmware = true;

  # Configure bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;

      # Use systemd to boot.
      systemd-boot = {
        enable = true;

        # Limit the amound of generations availabe for rollback.
        # This helps to save storage space.
        configurationLimit = 10;
      };
    };

    # Mount /tmp on tmpfs.
    tmp.useTmpfs = true;

    initrd = {
      # Don't really know if I need it. Kept from hardware-configuration.
      kernelModules = [ "dm-snapshot" ];

      # Kernel modules available for all the hosts.
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
