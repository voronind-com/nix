{ lib, config, ... }:
with lib;
let
  cfg = config.module.podman;
in
{
  options = {
    module.podman = {
      enable = mkEnableOption "OCI Podman.";
    };
  };

  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;

        # Free the 53 port ffs.
        defaultNetwork.settings.dns_enabled = false;

        # Do not interfere with Docker so we can have both installed at the same time.
        # Podman can't replace Docker anyway.
        dockerCompat = false;
      };
    };
  };
}
