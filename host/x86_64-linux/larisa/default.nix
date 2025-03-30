{ ... }:
{
  user.larisa = true;

  module = {
    amd.gpu.enable = true;
    purpose = {
      desktop = true;
      disown = true;
      parents = true;
    };
    display = {
      logo = "󱌔";
      primary = "HDMI-A-1";
    };
    amd.cpu = {
      enable = true;
      powersave = true;
    };
  };
}
