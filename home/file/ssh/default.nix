{ secret, pkgs, ... }:
let
  inherit (secret.network) host;
in
{
  config = pkgs.replaceVars ./config {
    dashaIp = host.dasha.ip;
    desktopIp = host.desktop.ip;
    homeIp = host.home.ip;
    maxIp = host.max.ip;
  };
}
