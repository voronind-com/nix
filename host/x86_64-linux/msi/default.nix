{ ... }:
{
  home.nixos.enable = true;
  user = {
    dasha = true;
    root = true;
    voronind = true;
  };

  module = {
    builder.client.enable = true;
    display.primary = "eDP-1";
    print.enable = true;
    purpose = {
      creative = true;
      disown = true;
      gaming = true;
      laptop = true;
      work = true;
    };
    syncthing = {
      enable = true;
      user = "dasha";
    };
    amd = {
      compute.enable = true;
      cpu = {
        enable = true;
        powersave = true;
      };
      gpu.enable = true;
    };
  };
}
