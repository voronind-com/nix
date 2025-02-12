{ ... }:
{
  user = {
    dasha = true;
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
    amd = {
      compute.enable = true;
      gpu.enable = true;
      cpu = {
        enable = true;
        powersave = true;
      };
    };
  };
}
