{ ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/NIXROOT";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/NIXBOOT";
      fsType = "vfat";
    };
  };
}
