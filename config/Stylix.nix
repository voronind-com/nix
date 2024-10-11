{
  pkgs,
  config,
  __findFile,
  ...
}:
{
  stylix = {
    enable = true;
    image = config.module.wallpaper.path;
    autoEnable = true;
    polarity = "dark";
    fonts = {
      inherit (config.style.font)
        serif
        sansSerif
        monospace
        emoji
        ;
      sizes = {
        inherit (config.style.font.size) terminal desktop;
        applications = config.style.font.size.application;
        popups = config.style.font.size.popup;
      };
    };
    opacity = {
      inherit (config.style.opacity) desktop terminal;
      applications = config.style.opacity.application;
      popups = config.style.opacity.popups;
    };
    inherit (config.style) cursor;
    override =
      if config.module.wallpaper.forceContrastText then
        {
          base04 = "000000";
          base05 = "ffffff";
          base06 = "ffffff";
        }
      else
        { };
  };
}
