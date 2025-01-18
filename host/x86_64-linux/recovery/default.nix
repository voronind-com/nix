{ inputs, ... }:
{
  imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix" ];

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
