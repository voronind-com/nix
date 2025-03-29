{ config, pkgs, ... }:
let
  host = config.networking.hostName;
  sender = config.module.const.host.noreply;
  noreply-mail = pkgs.writeShellScriptBin "noreply-mail" ''
    SUBJECT=$1
    TO=$2
    shift
    (
      echo "From: System on ${host} <${sender}>";
      echo "To: $TO";
      echo "Subject: $SUBJECT";
      ${pkgs.coreutils}/bin/cat -;
    ) | /run/wrappers/bin/sendmail $@
  '';
in
{
  environment.systemPackages = [ noreply-mail ];
}
