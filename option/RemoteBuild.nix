{ lib, ... }:
{
  options.module.builder = {
    server.enable = lib.mkEnableOption "the builder server.";
    client.enable = lib.mkEnableOption "the builder client.";
  };
}
