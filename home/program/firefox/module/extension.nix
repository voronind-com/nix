{
  __findFile,
  config,
  pkgs,
  util,
  ...
}@args:
let
  extensions = [
    # TODO: Use this after https://github.com/darkreader/darkreader/pull/12920 gets merged.
    # (mkExtension "addon@darkreader.org" "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi")
    (mkExtension "addon@darkreader.org" "file://${pkgs.callPackage <package/darkreader> args}/latest.xpi")
    (mkExtension "cliget@zaidabdulla.com" "https://addons.mozilla.org/firefox/downloads/latest/cliget/latest.xpi")
    (mkExtension "firefox@tampermonkey.net" "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi")
    (mkExtension "foxyproxy@eric.h.jung" "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi")
    (mkExtension "queryamoid@kaply.com" "https://github.com/mkaply/queryamoid/releases/download/v0.1/query_amo_addon_id-0.1-fx.xpi") # Or find them yourself inside the `about:support`.
    (mkExtension "uBlock0@raymondhill.net" "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi")
    (mkExtension "{446900e4-71c2-419f-a6a7-df9c091e268b}" "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi")
    (mkExtension "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi")
    (mkExtension "{d7742d87-e61d-4b78-b8a1-b469842139fa}" "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi")
    (mkExtension "{e7625f06-e252-479d-ac7a-db68aeaff2cb}" "https://addons.mozilla.org/firefox/downloads/latest/togglefonts/latest.xpi")
  ];

  extensionConfigs = util.catSet (util.ls ./extension) args;

  mkExtension = id: install_url: {
    ${id} = {
      inherit install_url;
      installation_mode = "force_installed";
    };
  };
in
{
  policies = {
    "3rdparty".Extensions = extensionConfigs;

    ExtensionSettings = {
      # Block extension installation outside of this config.
      "*" = {
        install_sources = [ "*" ];
        installation_mode = "blocked";
      };
    } // builtins.foldl' (acc: ext: acc // ext) { } extensions;
  };
}
