{
  __findFile,
  config,
  pkgs,
  ...
}@args:
let
  git = import ./git args;
  mangohud = import ./mangohud args;
  waybar = import ./waybar args;
  yazi = import ./yazi args;
in
{
  ".config/MangoHud/MangoHud.conf".source = mangohud.config;
  ".config/MangoHud/presets.conf".source = mangohud.presets;
  ".config/btop/btop.conf".source = (import ./btop args).file;
  ".config/foot/foot.ini".source = (import ./foot args).file;
  ".config/fuzzel/fuzzel.ini".source = (import ./fuzzel args).file;
  ".config/keyd/app.conf".text = (import ./keyd args).text;
  ".config/mako/config".source = (import ./mako args).file;
  ".config/nvim/init.vim".source = (import ./nvim args).init;
  ".config/swappy/config".source = (import ./swappy args).config;
  ".config/sway/config".text = (import ./sway args).text;
  ".config/tmux/tmux.conf".source = (import ./tmux args).config;
  ".config/waybar/config".source = waybar.config;
  ".config/waybar/style.css".source = waybar.style;
  ".config/yazi/init.lua".source = yazi.init;
  ".config/yazi/keymap.toml".source = yazi.keymap;
  ".config/yazi/theme.toml".source = yazi.theme;
  ".config/yazi/yazi.toml".source = yazi.yazi;
  ".config/zathura/zathurarc".source = (import ./zathura args).file;
  ".editorconfig".source = (import ./editorconfig args).file;
  ".gitconfig".source = git.config;
  ".gitignore".source = git.ignore;
  ".ideavimrc".source = ./jetbrains/ideavimrc;
  ".local/share/applications".text = "";
  ".local/share/jellyfinmediaplayer/scripts/mpris.so".source =
    "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";
  ".ssh/config".source = (import ./ssh args).config;
  ".ssh/identity".source = <secret/ssh>;
  ".template".source = ./template;
  ".wallpaper".source = config.module.wallpaper.path;
  # ".config/autostart".text = ""; # ISSUE: They broke it ;(
}
