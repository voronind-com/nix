{ config, pkgs, ... }:
let
  inherit (config.module.style) color;
  inherit (color) accent;
  bg = color.bg.regular;
  fg = color.fg.light;
  selectionBg = color.selection;
  selectionFg = color.fg.dark;
in
{
  config = pkgs.replaceVars ./tmux.conf {
    inherit
      accent
      bg
      fg
      selectionBg
      selectionFg
      ;
  };
}
