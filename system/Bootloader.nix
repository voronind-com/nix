{ ... }:
{
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
      kernelModules = [ "dm-snapshot" ];
      availableKernelModules = [
        "ahci"
        "ata_piix"
        "mptspi"
        "nvme"
        "sd_mod"
        "sdhci_pci"
        "sr_mod"
        "thunderbolt"
        "usb_storage"
        "usbhid"
        "vmd"
        "xhci_pci"
      ];
    };
  };
}
