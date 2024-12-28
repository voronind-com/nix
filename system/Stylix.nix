{ config, lib, ... }:
let
  style = config.module.style;
  wallpaper = config.module.wallpaper;
in
{
  stylix =
    {
      inherit (config.module.style) cursor;
      enable = true;
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
        popups = popups;
      };
    }
    // (lib.optionalAttrs wallpaper.forceContrastText {
      override = {
        base04 = lib.mkForce "000000";
        base05 = lib.mkForce "ffffff";
        base06 = lib.mkForce "ffffff";
      };
    })
    // (lib.optionalAttrs (wallpaper.style != null) { base16Scheme = wallpaper.style; });
}
