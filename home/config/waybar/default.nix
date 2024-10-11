{ util, pkgs, ... }@args:
{
  config = (import ./config args).file;
  style = pkgs.writeText "WaybarStyle" (util.catText (util.ls ./style) args);
}
