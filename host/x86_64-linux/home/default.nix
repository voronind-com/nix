{ config, lib, ... }:
let
  host = config.module.const.host;
in
{
  user.voronind = true;

  module = {
    builder.server.enable = true;
    package.all = true;
    wallpaper.video = false;
    purpose = {
      desktop = true;
      router = true;
      server = true;
    };
    display = {
      logo = "";
      primary = "HDMI-A-1";
    };
    zfs = {
      pools = [
        "alpha"
        "data"
        "hot"
        "omega"
      ];
      scrub = [
        "alpha"
        "data"
        "omega"
      ];
    };
    syncthing = {
      enable = true;
      dataDir = host.sync;
      user = "root";
      group = "root";
    };
    amd = {
      cpu.enable = true;
      gpu.enable = true;
    };
    ftpd = {
      enable = true;
      storage = host.ftp;
    };
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
    };
  };

  # NOTE: Manual gc as it is a sub.
  nix.gc.automatic = lib.mkForce false;
}
