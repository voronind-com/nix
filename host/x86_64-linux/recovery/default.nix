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
  };
}

