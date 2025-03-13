{ lib, ... }:
{
  options.module.secrets = lib.mkOption {
    default = [ ];
    type = with lib.types; listOf str;
  };
}
