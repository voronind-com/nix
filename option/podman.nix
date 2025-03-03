{ lib, ... }:
{
  options.module.podman.enable = lib.mkEnableOption "the OCI Podman.";
}
