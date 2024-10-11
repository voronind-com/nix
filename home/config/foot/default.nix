{ config, pkgs, ... }:
let
  dpiAware = if config.setting.dpiAware then "yes" else "no";
  borderSize = toString config.style.window.border;
  fontStep = 1;
in
{
  file = (pkgs.formats.iniWithGlobalSection { }).generate "FootConfig" {
    globalSection = {
      font = "${config.style.font.monospace.name}:size=${toString config.style.font.size.terminal}";
      # font-bold            = "${config.style.font.monospace.name}:size=${toString config.style.font.size.terminal}";
      font-italic = "${config.style.font.monospace.name}:size=${toString config.style.font.size.terminal}";
      font-bold-italic = "${config.style.font.monospace.name}:size=${toString config.style.font.size.terminal}";
      dpi-aware = dpiAware;
      font-size-adjustment = fontStep;
      pad = "${borderSize}x${borderSize} center";
    };

    sections = {
      colors = {
        alpha = config.style.opacity.terminal;
        background = config.style.color.bg.dark;
        foreground = config.style.color.fg.light;
      };
      key-bindings = {
        show-urls-launch = "Mod1+o";
      };
    };
  };
}
