{
  __findFile,
  pkgs,
  util,
  ...
}@args:
let
  package = (pkgs.callPackage <package/homer> args);
in
{
  services.nginx = {
    enable = true;
    virtualHosts."home.voronind.com" = {
      root = "${package}";
    };
  };
}
