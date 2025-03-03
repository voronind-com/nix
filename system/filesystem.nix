{ ... }:
{
  fileSystems = {
    "/" = {
      device = "system";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/NIXBOOT";
      fsType = "vfat";
    };
  };
}
