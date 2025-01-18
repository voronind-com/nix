{ ... }:
{
  # Root user setup.
  home.nixos.enable = true;
  user.root = true;

  module = {
    keyd.enable = true;
    purpose = {
      live = true;
    };
    package = {
      common = true;
      core = true;
      creative = true;
      desktop = true;
      dev = true;
      extra = true;
      gaming = true;
    };
  };
}
