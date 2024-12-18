{ ... }:
{
  # Keyd Print to Macro remap.
  services.keyd.keyboards.default.settings.main.print = "layer(layer_number)";

  home.nixos.enable = true;
  user = {
    dasha = true;
    root = true;
    voronind = true;
  };

  module = {
    display.primary = "eDP-1";
    package.extra = true;
    print.enable = true;
    syncthing.enable = true;
    builder.client.enable = true;
    powerlimit.thinkpad.enable = true;
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
