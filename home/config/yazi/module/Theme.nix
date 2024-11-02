{ pkgs, config, ... }:
let
  border = {
    fg = "#${config.style.color.border}";
  };
  borderLight = {
    fg = "#${config.style.color.accent}";
  };
  hover = {
    bg = "#${config.style.color.bg.regular}";
    fg = "#${config.style.color.fg.light}";
  };
  select = {
    bg = "#${config.style.color.selection}";
    fg = "#${config.style.color.fg.dark}";
  };
  text = {
    fg = "#${config.style.color.fg.light}";
  };
in
{
  file = (pkgs.formats.toml { }).generate "YaziThemeConfig" {
    manager = {
      border_style = border;
      border_symbol = " ";
      cwd = text;
      hovered = hover;
      preview_hovered = hover;
      tab_active = hover;
    };
    select = {
      border = borderLight;
    };
    input = {
      border = borderLight;
    };
    completion = {
      border = borderLight;
      active = hover;
      inactive = text;
    };
    tasks = {
      border = borderLight;
    };
    which = {
      cand = text;
      cols = 3;
      desc = text;
      mask = hover;
      rest = text;
      separator = "=>";
      separator_style = text;
    };

    status = {
      mode_normal = hover;
      mode_select = select;
      permissions_r = text;
      permissions_s = text;
      permissions_t = text;
      permissions_w = text;
      permissions_x = text;
      progress_label = hover;
      progress_normal = hover;
      separator_close = "";
      separator_open = "";
      # NOTE: Inversed because yazi dev is fckin weird. Also add manpages ffs.
      separator_style = {
        bg = "#${config.style.color.fg.light}";
        fg = "#${config.style.color.bg.regular}";
      };
      mode_unset = {
        fg = "#${config.style.color.fg.light}";
        bg = "#${config.style.color.neutral}";
      };
      progress_error = {
        fg = "#${config.style.color.fg.light}";
        bg = "#${config.style.color.negative}";
      };
    };
  };
}
