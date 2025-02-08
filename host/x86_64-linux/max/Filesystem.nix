{ ... }:
{
  fileSystems = {
    "/" = {
      device = "system/root";
      fsType = "zfs";
    };
    "/nix" = {
      device = "system/nix";
      fsType = "zfs";
    };
    "/var" = {
      device = "system/var";
      fsType = "zfs";
    };
    "/home" = {
      device = "system/home";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/NIXBOOT";
      fsType = "vfat";
    };
  };
}
