{ pkgs, config, ... }:
{
  preferences = (pkgs.formats.json { }).generate "chromium-config" {
    name = "Work";
    bookmark_bar.show_on_all_tabs = false;
    browser.show_home_button = false;
    default_apps_install_state = 2;
    download.prompt_for_download = false;
    download_bubble.partial_view_enabled = false;
    intl.selected_languages = "en-US,en";
    session.restore_on_startup = 1;
    side_panel.is_right_aligned = false;
    default_search_provider = {
      guid = "5761b040-db50-4f8e-9d00-c9ad985779a4";
      synced_guid = "5761b040-db50-4f8e-9d00-c9ad985779a4";
    };
    default_search_provider_data = {
      template_url_data = {
        id = 11;
        is_active = 1;
        keyword = "s";
        short_name = "SearX";
        synced_guid = "5761b040-db50-4f8e-9d00-c9ad985779a4";
        url = "https://search.voronind.com/search?q={searchTerms}";
      };
    };
    extensions = {
      alerts.initialized = false;
      commands = {
        "linux:Alt+Shift+L" = {
          command_name = "addSite";
          extension = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
          global = false;
        };
        "linux:Alt+Shift+B" = {
          command_name = "_execute_browser_action";
          extension = "cgbcahbpdhpcegmbfconppldiemgcoii";
          global = false;
        };
        "linux:Alt+Shift+K" = {
          command_name = "launch-element-zapper";
          extension = "cgbcahbpdhpcegmbfconppldiemgcoii";
          global = false;
        };
        "linux:Alt+Shift+J" = {
          command_name = "toggle-javascript";
          extension = "cgbcahbpdhpcegmbfconppldiemgcoii";
          global = false;
        };
        "linux:Alt+Shift+P" = {
          command_name = "_execute_action";
          extension = "gcknhkkoolaabfmlnjonogaaifnjlfnp";
          global = false;
        };
      };
    };
    password_manager = {
      autofillable_credentials_account_store_login_database = false;
      autofillable_credentials_profile_store_login_database = false;
    };
    webkit = {
      webprefs = {
        default_fixed_font_size = 14;
        default_font_size = 17;
        minimum_font_size = 16;
        fonts =
          let
            mono = config.module.style.font.monospace.name;
            sans = config.module.style.font.sansSerif.name;
          in
          {
            fixed.Zyyy = mono;
            sansserif.Zyyy = sans;
            serif.Zyyy = sans;
            standard.Zyyy = sans;
          };
      };
    };
  };

  localState = (pkgs.formats.json { }).generate "chromium-local-state" {
    browser = {
      first_run_finished = true;
      enabled_labs_experiments = [ "smooth-scrolling@2" ];
    };
  };

  # REF: https://chromeenterprise.google/intl/en_us/policies/
  policy = (pkgs.formats.json { }).generate "chromium-policy" {
    DefaultBrowserSettingEnabled = false;
    URLBlocklist = [ "darkreader.org" ];
  };
}
