{ config, ... }:
let
  host = config.module.const.host;
in
{
  user.voronind = true;

  module = {
    builder.server.enable = true;
    display.primary = "HDMI-A-1";
    package.all = true;
    wallpaper.video = false;
    purpose = {
      desktop = true;
      router = true;
      server = true;
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
}
