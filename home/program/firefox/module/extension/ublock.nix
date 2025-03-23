{ config, ... }:
{
  "uBlock0@raymondhill.net".adminSettings = {
    userSettings = {
      uiTheme = "dark";
      cloudStorageEnabled = false;
    };
    # NOTE: Check in `Support` -> `Troubleshooting Information` tab.
    selectedFilterLists = [
      "user-filters"
      "ublock-badware"
      "ublock-privacy"
      "ublock-quick-fixes"
      "ublock-filters"
      "easyprivacy"
      "ublock-unbreak"
      "urlhaus-1"
      "easylist"
      "plowe-0"
      "adguard-cookies"
      "fanboy-cookiemonster"
      "ublock-cookies-easylist"
      "adguard-other-annoyances"
      "ublock-cookies-adguard"
      "adguard-widgets"
      "fanboy-social"
      "ublock-annoyances"
      "adguard-social"
      "fanboy-thirdparty_social"
      "easylist-chat"
      "easylist-newsletters"
      "easylist-notifications"
      "easylist-annoyances"
      "adguard-mobile-app-banners"
      "adguard-popup-overlays"
      "RUS-0"
    ];
  };
}
