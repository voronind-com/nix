{
  config,
  lib,
  util,
  ...
}@args:
let
  swayRc = util.catText [
    ./module/Mod.nix
    ./module/Style.nix
    ./module/Display.nix
    ./module/Input.nix
    ./module/Font.nix
    ./module/Launcher.nix
    ./module/Terminal.nix
    ./module/TitleBar.nix
    ./module/Navigation.nix
    ./module/Notification.nix
    ./module/Resize.nix
    ./module/ScratchPad.nix
    ./module/Screenshot.nix
    ./module/Sound.nix
    ./module/Tiling.nix
    ./module/Workspace.nix
    ./module/Session.nix
    ./module/Keyd.nix
    ./module/Waybar.nix
    ./module/System.nix
    ./module/Mouse.nix
  ] args;
in
{
  text =
    ''
      # Read `man 5 sway` for a complete reference.
      include /etc/sway/config.d/*
    ''
    + swayRc
    + lib.concatStringsSep "\n" config.module.sway.extraConfig;
}
