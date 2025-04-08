# REF: https://mozilla.github.io/policy-templates/
_: {
  policies = {
    AppAutoUpdate = false;
    AutofillAddressEnabled = true;
    AutofillCreditCardEnabled = false;
    BackgroundAppUpdate = false;
    CaptivePortal = true;
    DisablePocket = true;
    DisableSetDesktopBackground = true;
    DontCheckDefaultBrowser = false;
    ExtensionUpdate = true;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    PasswordManagerEnabled = false;
    PromptForDownloadLocation = false;
    SearchSuggestEnabled = false;
    ShowHomeButton = false;
    StartDownloadsInTempDirectory = false;
    TranslateEnabled = false;
    UseSystemPrintDialog = true;
    # WebsiteFilter = [ ]; # NOTE: Should be in sep module.
    # Containers = {}; # TODO: Use containers? https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/
    PopupBlocking = {
      Allow = [ ];
      Default = true;
      Locked = true;
    };
    Homepage = {
      Locked = true;
      StartPage = "previous-session";
      URL = "https://home.voronind.com";
    };
    DNSOverHTTPS = {
      Enabled = false;
      # Fallback = false;
      Locked = false;
      ProviderURL = "https://dns.quad9.net/dns-query";
    };
    FirefoxHome = {
      Highlights = false;
      Locked = true;
      Pocket = false;
      Search = false;
      Snippets = false;
      SponsoredTopSites = false;
      TopSites = false;
    };
    FirefoxSuggest = {
      ImproveSuggest = false;
      Locked = true;
      SponsoredSuggestions = false;
      WebSuggestions = false;
    };
    PictureInPicture = {
      Enabled = false;
      Locked = false;
    };
    UserMessaging = {
      ExtensionRecommendations = false;
      FeatureRecommendations = false;
      Locked = true;
      MoreFromMozilla = false;
      SkipOnboarding = true;
      UrlbarInterventions = false;
      WhatsNew = false;
    };
  };
}
