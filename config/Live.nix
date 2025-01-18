{ lib, config, inputs, ... }:
let
  cfg = config.module.live;
in
{
  config = lib.mkIf cfg.enable {
    imports = [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
    ];
  };
}

