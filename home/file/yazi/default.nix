{
  config,
  pkgs,
  util,
  ...
}@args:
{
  keymap = (import ./module/Keymap.nix args).file;
  theme = (import ./module/Theme.nix args).file;
  yazi = (import ./module/Yazi.nix args).file;
}
