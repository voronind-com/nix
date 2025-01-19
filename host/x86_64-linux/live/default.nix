{ inputs, ... }:
{
  imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix" ];

  module = {
    purpose = {
      live = true;
    };
    package = {
      common = true;
      desktop = true;
    };
  };
}
