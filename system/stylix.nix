{ config, lib, ... }:
let
  inherit (config.module) style wallpaper purpose;
in
{
  stylix = lib.mkMerge [
    {
      inherit (config.module.style) cursor;
      enable = !purpose.parents;
      autoEnable = true;
      image = wallpaper.path;
      polarity = "dark";
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
