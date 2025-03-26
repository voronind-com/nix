{ config, pkgs, ... }:
let
  cfg = config.module.style;

  color = cfg.color;
  bg = color.bg.dark;
  fg = color.fg.light;
  bgStatus = color.bg.regular;
  fgStatus = color.fg.regular;
  bgInput = color.bg.light;
  fgInput = color.fg.dark;
  bgError = color.negative;
  fgError = color.fg.dark;
  bgWarn = color.neutral;
  fgWarn = color.fg.dark;
  hl = color.highlight;
  hlActive = color.accent;
  bgHlComp = color.positive;
  fgHlComp = color.fg.dark;
  bgComp = color.selection;
  fgComp = color.fg.dark;
  bgNotif = color.bg.light;
  fgNotif = color.fg.dark;
  recLight = color.fg.light;
  recDark = color.bg.dark;

  font = with cfg.font; "${sansSerif.name} ${toString size.application}";

  zathurarc = pkgs.replaceVars ./zathurarc {
    inherit
      bg
      bgComp
      bgError
      bgHlComp
      bgInput
      bgNotif
      bgStatus
      bgWarn
      fg
      fgComp
      fgError
      fgHlComp
      fgInput
      fgNotif
      fgStatus
      fgWarn
      font
      hl
      hlActive
      recDark
      recLight
      ;
  };
in
{
  file = zathurarc;
}
