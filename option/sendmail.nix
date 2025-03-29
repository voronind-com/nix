{ lib, ... }:
{
  options.module.sendmail = {
    enable = lib.mkEnableOption "the email sending.";
    public = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };
}
