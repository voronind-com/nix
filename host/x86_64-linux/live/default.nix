{ inputs, ... }:
{
  imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix" ];

  module = {
    wallpaper.video = false;
    purpose = {
      desktop = true;
      live = true;
    };
  };
}
