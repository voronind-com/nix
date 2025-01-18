{ ... }:
{
  home.nixos.enable = true;
  user = {
    root = true;
    voronind = true;
  };

  module = {
    display.primary = "eDP-1";
    print.enable = true;
    builder.client.enable = true;
    intel.cpu.enable = true;
    purpose = {
      desktop = true;
    };
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/platform/coretemp.0/hwmon";
    };
  };
}
