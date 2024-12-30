{ ... }:
{
  home.nixos.enable = true;
  user = {
    root = true;
    voronind = true;
  };

  module = {
    builder.server.enable = true;
    display.primary = "HDMI-A-1";
    purpose = {
      desktop = true;
      router = true;
      server = true;
    };
    syncthing = {
      enable = true;
      dataDir = "/storage/hot/sync";
      user = "root";
      group = "root";
    };
    dpi.bypass = {
      enable = true;
      udpSupport = true;
      params = [
        "--dpi-desync=fake,disorder2"

        "--dpi-desync-ttl=1"
        "--dpi-desync-autottl=2"

        "--dpi-desync-ttl6=1"
        "--dpi-desync-autottl6=2"

        "--dpi-desync-any-protocol"
      ];
      whitelist = [
        "youtube.com"
        "googlevideo.com"
        "ytimg.com"
        "youtu.be"
        "rutracker.org"
        "rutracker.cc"
        "rutrk.org"
        "t-ru.org"
        "medium.com"
      ];
      udpPorts = [
        "443"
      ];
    };
    amd = {
      cpu.enable = true;
      gpu.enable = true;
    };
    ftpd = {
      enable = true;
      storage = "/storage/hot/ftp";
    };
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
    };
  };
}
