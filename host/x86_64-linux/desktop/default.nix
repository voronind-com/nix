{ ... }:
{
  user.voronind = true;

  module = {
    builder.client.enable = true;
    package.all = true;
    print.enable = true;
    syncthing.enable = true;
    purpose = {
      creative = true;
      desktop = true;
      gaming = true;
      work = true;
    };
    zfs = {
      notify = true;
      pools = [
        "atlas"
        "game"
        "sun"
      ];
      scrub = [
        "atlas"
        "sun"
      ];
    };
    secrets = [
      "noreply-password"
      "vpn/fsight/ca"
      "vpn/fsight/cert"
      "vpn/fsight/key"
      "vpn/fsight/pw"
    ];
    network.setup = {
      vpn = {
        fsight = true;
      };
    };
    display = {
      primary = "HDMI-A-1";
      rotate.HDMI-A-1 = 180;
      logo = "";
    };
    amd = {
      compute.enable = true;
      gpu.enable = true;
      cpu = {
        enable = true;
        powersave = true;
      };
    };
    sway.extraConfig = [
      "output DP-3 pos 0 1080"
      "output HDMI-A-1 mode 1920x1080@74.986Hz pos 780 0"
      "workspace 1 output HDMI-A-1"
    ];
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
    };
  };
}
