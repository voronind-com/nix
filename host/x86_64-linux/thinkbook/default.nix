{ ... }:
{
  home.nixos.enable = true;
  user = {
    root = true;
    voronind = true;
  };

  module = {
    builder.client.enable = true;
    display.primary = "eDP-1";
    intel.cpu.enable = true;
    print.enable = true;
    wallpaper.video = false;
    purpose = {
      desktop = true;
    };
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/platform/coretemp.0/hwmon";
    };
  };
}
