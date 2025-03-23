{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  util,
  ...
}@args:
{
  enable = true;
  package = pkgsUnstable.firefox-esr;
  # languagePacks = [ "en-US" "ru" ];
}
// util.catSet (util.ls ./module) args
