{ config, lib, ... }:
{
  options.module.parents.enable = lib.mkEnableOption "parents configs." // {
    default = config.module.purpose.parents;
  };
}
