{ config, lib, ... }:
let
  cfg = config.module.live;
in
{
  # ISSUE: Can't find a way to import this conditionally.
  # imports = [ "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix" ];

  config = lib.mkIf cfg.enable {
    # services.rogue.enable = true; # NOTE: Not available smh.
    fileSystems = lib.mkForce config.lib.isoFileSystems;
    services.mingetty = {
      autologinUser = "live";
      helpLine = ''
        Welcome! Both live and root users have password "live". Enjoy!
      '';
    };
  };
}
