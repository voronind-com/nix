{ ... }:
{
  user.dasha = true;

  module = {
    builder.client.enable = true;
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
    secrets = [
      "vpn/home/ca"
      "vpn/home/cert"
      "vpn/home/key"
      "wifi"
    ];
    display = {
      logo = "󰋑";
      primary = "eDP-1";
    };
    network.setup = {
      wifi = true;
      vpn = {
        home = true;
      };
    };
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
