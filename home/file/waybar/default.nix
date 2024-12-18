# ISSUE: https://github.com/Alexays/Waybar/issues/3303
# This way I am forced to apply the padding to children of each group
# instead of the whole group.
{
  util,
  pkgs,
  config,
  ...
}@args:
let
  accent = "#${config.module.style.color.accent}";
  fontSerif = config.module.style.font.serif.name;
  fontPropo = "Terminess Nerd Font Propo";
  fontSize = "${toString config.module.style.font.size.desktop}px";
  foreground = "#${config.module.style.color.fg.light}";
  paddingH = "12px";
  paddingV = "0";
  backgroundColor = "rgba(${config.module.style.color.bgR},${config.module.style.color.bgG},${config.module.style.color.bgB},${toString config.module.style.opacity.desktop})";
  borderColor = "rgba(${config.module.style.color.borderR},${config.module.style.color.borderG},${config.module.style.color.borderB},${toString config.module.style.opacity.desktop})";
  border = "${toString config.module.style.window.border}px solid ${borderColor}";
  borderSize = "${toString config.module.style.window.border}px";

  styleRaw = pkgs.writeText "waybar-style-raw" (util.readFiles (util.ls ./style));
  style = pkgs.replaceVars styleRaw {
    inherit
      accent
      fontSerif
      fontPropo
      fontSize
      foreground
      paddingH
      paddingV
      backgroundColor
      borderColor
      border
      borderSize
      ;
  };
in
{
  inherit style;
  config = (import ./config args).file;
}
