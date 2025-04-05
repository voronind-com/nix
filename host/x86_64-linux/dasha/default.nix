{ ... }:
{
  user.user.dasha = {
    enable = true;
    primary = true;
  };

  module = {
    amd.gpu.enable = true;
    builder.client.enable = true;
    package.all = true;
    print.enable = true;
    purpose = {
      creative = true;
      desktop = true;
      disown = true;
      gaming = true;
      work = true;
    };
    secrets = [ "noreply-password" ];
    display = {
      logo = "";
      primary = "DP-1";
    };
    zfs = {
      notify = true;
      pools = [
        "cold"
        "hot"
      ];
    };
    syncthing = {
      enable = true;
      user = "dasha";
    };
    sway.extraConfig = [
      "output DP-1 pos 0 0"
      "output DP-2 pos 1920 0"
      "workspace 1 output DP-1"
    ];
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
