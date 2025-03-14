{ inputs, ... }:
{
  imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix" ];

  module = {
    display.logo = "";
    purpose = {
      live = true;
    };
  };
}
