{ pkgs, config, ... }:
{
  config = (pkgs.formats.ini { }).generate "SwappyConfig" {
    Default = {
      early_exit = true;
      fill_shape = false;
      line_size = 4;
      paint_mode = "arrow";
      show_panel = false;
      text_font = config.style.font.serif.name;
      text_size = config.style.font.size.popup;
    };
  };
}
