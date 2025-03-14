{ ... }:
{
  user.voronind = true;

  module = {
    # builder.client.enable = true; # ISSUE: Needs network info.
    print.enable = true;
    purpose = {
      desktop = true;
    };
    display = {
      logo = "󱡮";
      primary = "eDP-1";
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
