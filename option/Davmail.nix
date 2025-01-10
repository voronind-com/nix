{ config, lib, ... }: {
  options.module.davmail.enable = lib.mkEnableOption "the Davmail Exchange proxy." // { default = config.module.purpose.work; };
}
