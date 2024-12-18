{ config, pkgs, ... }:
let
  accent = config.module.style.color.accent;
  bg = config.module.style.color.bg.regular;
  fg = config.module.style.color.fg.light;
  selectionBg = config.module.style.color.selection;
  selectionFg = config.module.style.color.fg.dark;
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
