{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  util,
  ...
}@args:
{
  enable = true;
  package = pkgs-unstable.firefox-esr;
  # languagePacks = [ "en-US" "ru" ];
}
// util.catSet (util.ls ./module) args
