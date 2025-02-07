# NOTE: Login to contaier, run passwd and use that root/pw combo for administration. `AllowFrom = all` doesn't seem to work.
# ipp://10.0.0.10
# Pantum M6500W-Series
{ __findFile, pkgs, ... }@args:
let
  # package = pkgs.callPackage <package/print> args;
  package = pkgs.pantum-driver;
in
{
  services.printing = {
    enable = true;
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    drivers = [ package ];
    listenAddresses = [ "[::]:631" ];
    startWhenNeeded = true;
    stateless = false;
    webInterface = true;
  };
}
