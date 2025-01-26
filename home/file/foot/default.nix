{ config, pkgs, ... }:
let
  borderSize = toString config.module.style.window.border;
  dpiAware = if config.module.display.dpiAware then "yes" else "no";
  fontStep = 1;
in
{
  file = (pkgs.formats.iniWithGlobalSection { }).generate "FootConfig" {
    globalSection = {
      dpi-aware = dpiAware;
      font = "${config.module.style.font.monospace.name}:size=${toString config.module.style.font.size.terminal}";
      # font-bold        = "${config.module.style.font.monospace.name}:size=${toString config.module.style.font.size.terminal}";
      font-bold-italic = "${config.module.style.font.monospace.name}:size=${toString config.module.style.font.size.terminal}";
      font-italic = "${config.module.style.font.monospace.name}:size=${toString config.module.style.font.size.terminal}";
      font-size-adjustment = fontStep;
      pad = "${borderSize}x${borderSize} center";
    };
    sections = {
      colors = {
        alpha = config.module.style.opacity.terminal;
        background = config.module.style.color.bg.dark;
        foreground = config.module.style.color.fg.light;
      };
      key-bindings =
        let
          mod = "Mod1";
        in
        {
          show-urls-launch = "${mod}+o";
          clipboard-paste = "Control+Shift+v XF86Paste ${mod}+P";
          clipboard-copy = "Control+Shift+v XF86Paste ${mod}+Y";
        };
    };
  };
}
