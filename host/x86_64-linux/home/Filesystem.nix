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
    "/storage/cold_1" = {
      device = "/dev/storage/cold_1";
      fsType = "ext4";
      options = [
        "noatime"
        "nofail"
      ];
    };

    "/storage/cold_2" = {
      device = "/dev/storage/cold_2";
      fsType = "ext4";
      options = [
        "noatime"
        "nofail"
      ];
    };

    "/storage/hot_1" = {
      device = "/dev/storage/hot_1";
      fsType = "ext4";
      options = [
        "noatime"
        "nofail"
      ];
    };

    "/storage/hot_2" = {
      device = "/dev/storage/hot_2";
      fsType = "ext4";
      options = [
        "noatime"
        "nofail"
      ];
    };
  };

  # swapDevices = [{
  #   device  = "/storage/hot_1/.swapfile";
  #   randomEncryption.enable = true;
  #   size    = 128 * 1024;
  #   options = [ "nofail" ];
  # }];
}
