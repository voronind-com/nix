{
  config,
  pkgs,
  util,
  ...
}@args:
{
  init = ./module/init.lua;
  keymap = (import ./module/keymap.nix args).file;
  theme = (import ./module/theme.nix args).file;
  yazi = (import ./module/yazi.nix args).file;
}
