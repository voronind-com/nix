{
  config,
  inputs,
  pkgs,
  self,
  ...
}@args:
let
  btop = import ./btop args;
  chromium = import ./chromium args;
  editor = import ./editorconfig args;
  foot = import ./foot args;
  fuzzel = import ./fuzzel args;
  git = import ./git args;
  keyd = import ./keyd args;
  mako = import ./mako args;
  mangohud = import ./mangohud args;
  nvim = import ./nvim args;
  ssh = import ./ssh args;
  swappy = import ./swappy args;
  sway = import ./sway args;
  tmux = import ./tmux args;
  waybar = import ./waybar args;
  yazi = import ./yazi args;
in
{
  ".Wallpaper".source = config.module.wallpaper.path;
  ".config/MangoHud/MangoHud.conf".source = mangohud.config;
  ".config/MangoHud/presets.conf".source = mangohud.presets;
  ".config/autostart".text = "";
  ".config/btop/btop.conf".source = btop.file;
  ".config/chromium/Default/Preferences".source = chromium.preferences;
  ".config/chromium/Local State".source = chromium.localState;
  ".config/foot/foot.ini".source = foot.file;
  ".config/fuzzel/fuzzel.ini".source = fuzzel.file;
  ".config/keyd/app.conf".text = keyd.text;
  ".config/mako/config".source = mako.file;
  ".config/nvim/init.vim".source = nvim.init;
  ".config/swappy/config".source = swappy.config;
  ".config/sway/config".text = sway.text;
  ".config/tmux/tmux.conf".source = tmux.config;
  ".config/waybar/config".source = waybar.config;
  ".config/waybar/style.css".source = waybar.style;
  ".config/yazi/keymap.toml".source = yazi.keymap;
  ".config/yazi/theme.toml".source = yazi.theme;
  ".config/yazi/yazi.toml".source = yazi.yazi;
  ".editorconfig".source = editor.file;
  ".gitconfig".source = git.config;
  ".gitignore".source = git.ignore;
  ".ideavimrc".source = ./jetbrains/ideavimrc;
  ".local/share/applications".text = "";
  ".local/share/jellyfinmediaplayer/scripts/mpris.so".source =
    "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";
  ".nix".source = self;
  ".nixpkgs".source = inputs.nixpkgs;
  ".nixpkgs_master".source = inputs.nixpkgsMaster;
  ".nixpkgs_unstable".source = inputs.nixpkgsUnstable;
  ".parallel/will-cite".text = "";
  ".ssh/config".source = ssh.config;
  ".template".source = ./template;
}
