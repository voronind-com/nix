{ ... }:
{
  user.voronind = true;

  module = {
    builder.client.enable = true;
    display.primary = "eDP-1";
    print.enable = true;
    purpose = {
      desktop = true;
    };
    intel.cpu = {
      enable = true;
      powersave = true;
    };
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/platform/coretemp.0/hwmon";
    };
  };
}
