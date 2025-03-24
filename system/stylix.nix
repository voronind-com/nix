{ config, lib, ... }:
let
  style = config.module.style;
  wallpaper = config.module.wallpaper;
in
{
  stylix = lib.mkMerge [
    {
      inherit (config.module.style) cursor;
      enable = true;
      autoEnable = false;
      image = wallpaper.path;
      polarity = "dark";
      targets = {
        gtk.enable = true;
      };
      fonts = with style.font; {
        inherit
          emoji
          monospace
          sansSerif
          serif
          ;
        sizes = with size; {
          inherit desktop terminal;
          applications = application;
          popups = popup;
        };
      };
      opacity = with style.opacity; {
        inherit desktop terminal;
        applications = application;
        popups = popup;
      };
    }
    (lib.mkIf wallpaper.forceContrastText {
      override = {
        base04 = "000000";
        base05 = "ffffff";
        base06 = "ffffff";
      };
    })
    (lib.mkIf (wallpaper.scheme != null) { base16Scheme = wallpaper.scheme; })
  ];
}
