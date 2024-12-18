{ ... }:
{
  fileSystems = {
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

    "/storage/hot" = {
      device = "/dev/storage/hot";
      fsType = "ext4";
      options = [
        "noatime"
        "nofail"
      ];
    };
  };

  # swapDevices = [{
  #   device  = "/storage/hot/.swapfile";
  #   size    = 128 * 1024;
  #   options = [ "nofail" ];
  # }];
}
