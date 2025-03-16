# FTP server for legacy applications like my wireless scanner.
{ config, lib, ... }:
let
  cfg = config.module.ftpd;
in
{
  config = lib.mkIf cfg.enable {
    services.vsftpd = {
      enable = true;
      allowWriteableChroot = true;
      anonymousMkdirEnable = true;
      anonymousUmask = "000";
      anonymousUploadEnable = true;
      anonymousUser = true;
      anonymousUserHome = cfg.storage;
      anonymousUserNoPassword = true;
      localUsers = false;
      writeEnable = true;
      extraConfig = ''
        anon_other_write_enable=YES
      '';
    };
  };
}
