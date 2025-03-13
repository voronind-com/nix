{ ... }:
{
  user.dasha = true;

  module = {
    builder.client.enable = true;
    display.primary = "eDP-1";
    network.setup.wifi = true;
    package.all = true;
    powerlimit.thinkpad.enable = true;
    print.enable = true;
    purpose = {
      creative = true;
      disown = true;
      gaming = true;
      laptop = true;
      work = true;
    };
    secrets = [ "wifi" ];
    syncthing = {
      enable = true;
      user = "dasha";
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
