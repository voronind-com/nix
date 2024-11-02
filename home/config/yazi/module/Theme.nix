{ pkgs, config, ... }:
let
  color = config.style.color;
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
  # REF: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/theme.toml
  file = (pkgs.formats.toml { }).generate "YaziThemeConfig" {
    manager =
      let
        mkMarker = color: {
          bg = "#${color}";
          fg = "#${color}";
        };
      in
      {
        border_style = border;
        border_symbol = " ";
        count_copied = hover;
        count_cut = hover;
        count_selected = hover;
        cwd = text;
        hovered = hover;
        marker_copied = mkMarker color.accent;
        marker_cut = mkMarker color.accent;
        marker_marked = mkMarker color.hl;
        marker_selected = mkMarker color.selection;
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
      separator = " - ";
      separator_style = text;
    };
    confirm = {
      border = borderLight;
      title = borderLight;
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
