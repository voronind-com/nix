{ config, pkgs, ... }:
let
  host = config.networking.hostName;
  sender = config.module.const.host.noreply;
  replyTo = "hi@voronind.com";

  reply-mail = pkgs.writeShellScriptBin "reply-mail" ''
    SUBJECT=$1
    TO=$2
    shift
    (
      echo "From: Dmitry Voronin <${sender}>";
      echo "To: $TO";
      echo "Subject: $SUBJECT";
      echo "Reply-To: Dmitry <${replyTo}>"
      ${pkgs.coreutils}/bin/cat -;
    ) | /run/wrappers/bin/sendmail $@
  '';
  noreply-mail = pkgs.writeShellScriptBin "noreply-mail" ''
    SUBJECT=$1
    TO=$2
    shift
    (
      echo "From: System at ${host} <${sender}>";
      echo "To: $TO";
      echo "Subject: $SUBJECT";
      ${pkgs.coreutils}/bin/cat -;
    ) | /run/wrappers/bin/sendmail $@
  '';
in
{
  environment.systemPackages = [
    noreply-mail
    reply-mail
  ];
}
