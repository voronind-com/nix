{ ... }:
{
  user.larisa = true;

  module = {
    amd.gpu.enable = true;
    purpose = {
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

  services.displayManager.autoLogin = {
    enable = true;
    user = "larisa";
  };
}
