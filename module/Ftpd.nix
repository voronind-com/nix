{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.ftpd;
in
{
  options = {
    module.ftpd = {
      enable = mkEnableOption "Enable FTP server";
      storage = mkOption {
        default = null;
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    services.vsftpd = {
      enable = true;
      anonymousUser = true;
      anonymousUserNoPassword = true;
      anonymousUploadEnable = true;
      anonymousMkdirEnable = true;
      anonymousUmask = "000";
      anonymousUserHome = cfg.storage;
      allowWriteableChroot = true;
      writeEnable = true;
      localUsers = false;
      extraConfig = ''
        anon_other_write_enable=YES
      '';
    };
  };
}
