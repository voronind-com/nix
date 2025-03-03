{
  config,
  pkgs,
  util,
  ...
}@args:
{
  keymap = (import ./module/keymap.nix args).file;
  theme = (import ./module/theme.nix args).file;
  yazi = (import ./module/yazi.nix args).file;
}
