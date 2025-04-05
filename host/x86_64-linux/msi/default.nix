{ ... }:
{
  user.user = {
    dasha = {
      enable = true;
      primary = true;
    };
    voronind.enable = true;
  };

  module = {
    # builder.client.enable = true; # ISSUE: Needs network info.
    print.enable = true;
    purpose = {
      creative = true;
      disown = true;
      gaming = true;
      laptop = true;
      work = true;
    };
    display = {
      logo = "󰡈";
      primary = "eDP-1";
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
