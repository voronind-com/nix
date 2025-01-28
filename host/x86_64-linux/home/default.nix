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
    dpi.bypass = {
      enable = true;
      udpSupport = true;
      params = [
        "--dpi-desync=multisplit"
        "--dpi-desync-split-pos=10,midsld"
        "--dpi-desync-split-seqovl=1"

        "--dpi-desync-any-protocol"
      ];
      whitelist = [
        "youtube.com"
        "googlevideo.com"
        "google.com"
        "ytimg.com"
        "youtu.be"
        "m.youtube.com"
        "rutracker.org"
        "rutracker.cc"
        "rutrk.org"
        "t-ru.org"
        "medium.com"
      ];
      udpPorts = [ "443" ];
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
