{ ... }:
{
  user = {
    dasha = true;
    voronind = true;
  };

  module = {
    builder.client.enable = true;
    display.primary = "eDP-1";
    package.all = true;
    powerlimit.thinkpad.enable = true;
    print.enable = true;
    syncthing.enable = true;
    purpose = {
      creative = true;
      disown = true;
      gaming = true;
      laptop = true;
      work = true;
    };
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/platform/coretemp.0/hwmon";
    };
    intel.cpu = {
      enable = true;
      powersave = true;
    };
  };
}
