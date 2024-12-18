{
  config,
  pkgs,
  util,
  ...
}@args:
{
  init = (import ./module/Init.nix args).file;
  keymap = (import ./module/Keymap.nix args).file;
  theme = (import ./module/Theme.nix args).file;
  yazi = (import ./module/Yazi.nix args).file;
}
