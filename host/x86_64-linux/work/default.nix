{ ... }:
{
  # Keyd Print to Macro remap.
  services.keyd.keyboards.default.settings.main.print = "layer(layer_number)";

  home.nixos.enable = true;
  user = {
    root.enable = true;
    dasha.enable = true;
    voronind.enable = true;
  };

  module = {
    autoupdate.enable = true;
    builder.client.enable = true;
    desktop.sway.enable = true;
    kernel.enable = true;
    keyd.enable = true;
    powerlimit.thinkpad.enable = true;
    print.enable = true;
    intel.cpu = {
      enable = true;
      powersave = true;
    };
    package = {
      common.enable = true;
      core.enable = true;
      desktop.enable = true;
      dev.enable = true;
      extra.enable = true;
      gaming.enable = true;
    };
  };

  setting = {
    cpu.hwmon = {
      path = "/sys/devices/platform/coretemp.0/hwmon";
      file = "temp1_input";
    };
  };
}
