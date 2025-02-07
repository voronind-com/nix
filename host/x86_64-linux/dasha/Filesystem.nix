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
    "/storage/hot" = {
      device = "/dev/storage/hot";
      fsType = "ext4";
      options = [
        "noatime"
        "nofail"
      ];
    };
    "/storage/cold" = {
      device = "/dev/storage/cold";
      fsType = "ext4";
      options = [
        "noatime"
        "nofail"
      ];
    };
  };
}
