# SEE: https://github.com/Sabrina-Fox/WM2-Help
{ __findFile, pkgs, ... }:
{
  user.voronind = true;

  module = {
    builder.client.enable = true;
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
    secrets = [
      "vpn/fsight/ca"
      "vpn/fsight/cert"
      "vpn/fsight/key"
      "vpn/fsight/pw"
      "vpn/home/ca"
      "vpn/home/cert"
      "vpn/home/key"
      "wifi"
    ];
    display = {
      logo = "󰫢";
      primary = "eDP-1";
    };
    network.setup = {
      wifi = true;
      vpn = {
        fsight = true;
        home = true;
      };
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
