{ config, ... }:
let
  prefs = [
    # WARN: Remove when Dark Reader policies gets merged.
    (mkLockedPref "xpinstall.signatures.required" false)

    # Bookmarks.
    (mkLockedPref "browser.microsummary.enabled" true)
    (mkLockedPref "browser.places.importBookmarksHTML" true)
    (mkLockedPref "browser.toolbars.bookmarks.visibility" "never")

    # Fonts.
    (mkUserPref "browser.display.use_document_fonts" 0)
    (mkLockedPref "font.minimum-size.x-cyrillic" (toString config.module.style.font.size.application))
    (mkLockedPref "font.minimum-size.x-unicode" (toString config.module.style.font.size.application))
    (mkLockedPref "font.minimum-size.x-western" (toString config.module.style.font.size.application))
    (mkLockedPref "font.name.monospace.x-cyrillic" config.module.style.font.monospace.name)
    (mkLockedPref "font.name.monospace.x-unicode" config.module.style.font.monospace.name)
    (mkLockedPref "font.name.monospace.x-western" config.module.style.font.monospace.name)
    (mkLockedPref "font.name.sans-serif.x-cyrillic" config.module.style.font.sansSerif.name)
    (mkLockedPref "font.name.sans-serif.x-unicode" config.module.style.font.sansSerif.name)
    (mkLockedPref "font.name.sans-serif.x-western" config.module.style.font.sansSerif.name)
    (mkLockedPref "font.name.serif.x-cyrillic" config.module.style.font.serif.name)
    (mkLockedPref "font.name.serif.x-unicode" config.module.style.font.serif.name)
    (mkLockedPref "font.name.serif.x-western" config.module.style.font.serif.name)

    # Animations.
    (mkLockedPref "browser.fullscreen.animateUp" 0)
    (mkLockedPref "browser.fullscreen.autohide" true)

    # Formats.
    (mkLockedPref "image.jxl.enabled" true)

    # Disable HTTP3.
    # (mkLockedPref "network.http.http3.enable" false)

    # Style.
    (mkLockedPref "toolkit.legacyUserProfileCustomizations.stylesheets" true)

    # Prefer IPv6.
    (mkLockedPref "network.dns.preferIPv6" true)
  ];

  mkPref = Name: Value: Status: { ${Name} = { inherit Value Status; }; };
  mkLockedPref = Name: Value: mkPref Name Value "locked";
  mkUserPref = Name: Value: mkPref Name Value "user";
in
{
  policies.Preferences = builtins.foldl' (acc: pref: acc // pref) { } prefs;
}
