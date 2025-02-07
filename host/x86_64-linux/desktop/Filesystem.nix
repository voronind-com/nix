{ ... }:
{
  # TODO: Move to <system>.
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

    # "/" = {
    #   device = "/dev/disk/by-partlabel/NIXROOT";
    #   fsType = "ext4";
    #   options = [ "noatime" ];
    # };
    # "/storage/cold_1" = {
    #   device = "/dev/storage/cold_1";
    #   fsType = "ext4";
    #   options = [
    #     "noatime"
    #     "noauto"
    #     "nofail"
    #   ];
    # };
    #
    # "/storage/cold_2" = {
    #   device = "/dev/storage/cold_2";
    #   fsType = "ext4";
    #   options = [
    #     "noatime"
    #     "noauto"
    #     "nofail"
    #   ];
    # };
  };
}
