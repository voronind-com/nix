{ config, lib, ... }:
let
  filters = [
    "telemost.yandex.ru##.Modal-Overlay:upward(div)" # Popups.

    "www.wildberries.ru##a:matches-attr(href=/^\\/promo/):upward(div)"
    "www.wildberries.ru##a:matches-attr(href=/^\\/subscription/)"
    "www.wildberries.ru##div:matches-attr(class=/advertisement/)"
  ];

  # NOTE: Check in `Support` -> `Troubleshooting Information` tab.
  filterLists = [
    "RUS-0"
    "RUS-1"
    "adguard-cookies"
    "adguard-mobile-app-banners"
    "adguard-other-annoyances"
    "adguard-popup-overlays"
    "adguard-social"
    "adguard-widgets"
    "easylist"
    "easylist-annoyances"
    "easylist-chat"
    "easylist-newsletters"
    "easylist-notifications"
    "easyprivacy"
    "fanboy-cookiemonster"
    "fanboy-social"
    "fanboy-thirdparty_social"
    "plowe-0"
    "ublock-annoyances"
    "ublock-badware"
    "ublock-cookies-adguard"
    "ublock-cookies-easylist"
    "ublock-filters"
    "ublock-privacy"
    "ublock-quick-fixes"
    "ublock-unbreak"
    "urlhaus-1"
    "user-filters"
  ];

  userSettings = {
    advancedUserEnabled = true;
    autoUpdate = true;
    cloudStorageEnabled = false;
    contextMenuEnabled = true;
    dynamicFilteringEnabled = true;
    uiTheme = "dark";
  }
  |> lib.mapAttrsToList (n: v: [ "${toString n}" "${toString v}" ]);
in
{
  "uBlock0@raymondhill.net" = {
    inherit userSettings;
    toOverwrite = {
      inherit filters filterLists;
    };
  };
}
