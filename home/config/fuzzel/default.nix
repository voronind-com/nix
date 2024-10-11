{ pkgs, config, ... }:
let
  dpiAware = if config.setting.dpiAware then "yes" else "no";
in
{
  file = (pkgs.formats.ini { }).generate "FuzzelConfig" {
    main = {
      dpi-aware = dpiAware;
      # font         = "${style.font.serif.name}:size=${toString style.font.size.popup}";
      font = "Minecraftia:size=${toString config.style.font.size.popup}";
      lines = 20;
      prompt = "\"\"";
      show-actions = "yes";
      terminal = "foot";
      width = 40;
      # list-executables-in-path = "no";
    };
    border = {
      radius = 0;
      width = 1;
    };
    colors =
      let
        defaultOpacity = "ff";
      in
      {
        background = config.style.color.bg.dark + config.style.opacity.hex;
        border = config.style.color.border + config.style.opacity.hex;
        counter = config.style.color.bg.regular + defaultOpacity;
        input = config.style.color.fg.light + defaultOpacity;
        match = config.style.color.fg.light + defaultOpacity;
        placeholder = config.style.color.bg.regular + defaultOpacity;
        prompt = config.style.color.fg.light + defaultOpacity;
        selection = config.style.color.bg.regular + defaultOpacity;
        selection-match = config.style.color.accent + defaultOpacity;
        selection-text = config.style.color.fg.light + defaultOpacity;
        text = config.style.color.fg.light + defaultOpacity;
      };
  };
}
