{ inputs, ... }:
{
  imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix" ];

  module = {
    purpose = {
      desktop = true;
      live = true;
    };
  };
}
