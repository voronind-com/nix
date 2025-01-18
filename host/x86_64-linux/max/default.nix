# SEE: https://github.com/Sabrina-Fox/WM2-Help
{ __findFile, pkgs, ... }:
{
  home.nixos.enable = true;
  user = {
    root = true;
    voronind = true;
  };

  module = {
    builder.client.enable = true;
    package.all = true;
    print.enable = true;
    syncthing.enable = true;
    purpose = {
      creative = true;
      gaming = true;
      laptop = true;
      work = true;
    };
    display = {
      primary = "eDP-1";
    };
    sway.extraConfig = [ "output eDP-1 scale 1.75" ];
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
    };
    amd = {
      gpu.enable = true;
      cpu = {
        enable = true;
        powersave = true;
      };
    };
  };
}
