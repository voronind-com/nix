{
  config,
  lib,
  pkgs,
  ...
}:
let
  host = config.networking.hostName;
  sender = config.module.const.host.noreply;
  recipient = config.module.const.host.admin;
  zfsMail = pkgs.writeShellScriptBin "zfs-mail" ''
    SUBJECT=$1
    TO=$2
    shift
    (
      echo "From: ZFS on ${host} <${sender}>";
      echo "To: $TO";
      echo "Subject: $SUBJECT";
      ${pkgs.coreutils}/bin/cat -;
    ) | /run/wrappers/bin/sendmail $@
  '';
in
{
  services.zfs.zed = {
    enableMail = true;
    settings = {
      ZED_DEBUG_LOG = "/tmp/zed-debug.log";

      ZED_EMAIL_ADDR = [ recipient ];
      ZED_EMAIL_PROG = lib.getExe zfsMail;
      ZED_EMAIL_OPTS = "'@SUBJECT@' @ADDRESS@";

      ZED_NOTIFY_INTERVAL_SECS = 3600;
      ZED_NOTIFY_DATA = true;
      ZED_NOTIFY_VERBOSE = true;
    };
  };
}
