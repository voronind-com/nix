# SEE: https://github.com/Sabrina-Fox/WM2-Help
{ __findFile, pkgs, ... }:
{
  user.voronind = true;

  module = {
    builder.client.enable = true;
    display.primary = "eDP-1";
    package.all = true;
    powersave.enable = true;
    print.enable = true;
    sway.extraConfig = [ "output eDP-1 scale 1.75" ];
    syncthing.enable = true;
    purpose = {
      creative = true;
      gaming = true;
      laptop = true;
      work = true;
    };
    hwmon = {
      file = "temp1_input";
      path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
    };
    amd = {
      gpu.enable = true;
      cpu = {
        enable = true;
        # powersave = true; # ISSUE: No boost control file for some reason, disabled in UEFI.
      };
    };
  };
}
