{ config, ... }:
let
  darkModeIgnore = [
    "cloud.fsight.ru"
    "codeberg.org"
    "dav.voronind.com"
    "fsmm.fsight.ru"
    "git.voronind.com"
    "github.com"
    "home.voronind.com"
    "iot.voronind.com"
    "nixhub.io"
    "portal.fsight.ru"
  ];
in
{
  "addon@darkreader.org" = {
    enabled = true;
    enabledByDefault = true;
    changeBrowserTheme = false;
    detectDarkTheme = false;
    enableContextMenus = false;
    enableForPDF = false;
    enableForProtectedPages = false;
    fetchNews = false;
    previewNewDesign = true;
    syncSettings = true;
    syncSitesFixes = false;
    disabledFor = darkModeIgnore;
    theme = {
      brightness = 100;
      contrast = 100;
      darkColorScheme = "Default";
      darkSchemeBackgroundColor = "#${config.module.style.color.bg.dark}";
      darkSchemeTextColor = "#${config.module.style.color.fg.light}";
      engine = "dynamicTheme"; # dynamicTheme, cssFilter or svgFilter.
      fontFamily = config.module.style.font.sansSerif.name;
      grayscale = 0;
      immediateModify = true;
      lightColorScheme = "Default";
      lightSchemeBackgroundColor = "#${config.module.style.color.bg.light}";
      lightSchemeTextColor = "#${config.module.style.color.fg.dark}";
      mode = 1;
      scrollbarColor = "#${config.module.style.color.neutral}";
      selectionColor = "#${config.module.style.color.selection}";
      sepia = 0;
      styleSystemControls = true;
      stylesheet = "";
      textStroke = 0;
      useFont = false;
    };
    automation = {
      enabled = false;
      behavior = "OnOff";
      mode = "";
    };
    time = {
      activation = "18:00";
      deactivation = "9:00";
    };
    location = {
      latitude = null;
      longitude = null;
    };
  };
}
