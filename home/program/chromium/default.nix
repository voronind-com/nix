{ pkgs, lib, ... }:
let
  package = pkgs.ungoogled-chromium;
  browserVersion = lib.versions.major package.version;
  extensions =
    let
      fetchFromStore =
        {
          id,
          sha256,
          version,
        }:
        {
          inherit id version;
          crxPath = pkgs.fetchurl {
            inherit sha256;
            url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
            name = "${id}.crx";
          };
        };
      fetchFromUrl =
        {
          id,
          url,
          sha256,
          version,
        }:
        {
          inherit id version;
          crxPath = pkgs.fetchurl {
            inherit sha256 url;
            name = "${id}.crx";
          };
        };
    in
    [
      (fetchFromStore {
        # uBlock Origin dev.
        id = "cgbcahbpdhpcegmbfconppldiemgcoii";
        sha256 = "sha256-sTE96l7/B3n4rJHYC0p4hCVmXUMYj/6O6+596DFIK58=";
        version = "1.60.1.16";
      })
      (fetchFromStore {
        # Dark reader.
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        sha256 = "sha256-98sGCo2dG+XYMzBeLR+10Ic5DLjDXhSh1DzatLOCyQQ=";
        version = "4.9.95";
      })
      (fetchFromStore {
        # Foxy Proxy.
        id = "gcknhkkoolaabfmlnjonogaaifnjlfnp";
        sha256 = "sha256-Zm7x/467CaGcEN+cYwf8XowpaZRJQIzIEY/F6NhJ3pA=";
        version = "8.9";
      })
      (fetchFromStore {
        # Vimium.
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
        sha256 = "sha256-DaEM1NyMX8RMBvWoIVOhmfY/ae66HCNfRFnwAuLUHVU=";
        version = "2.1.2";
      })
      # (fetchFromUrl rec {
      #   # Ext updater.
      #   id = "ocaahdebbfolfmndjeplogmgcagdmblk";
      #   url = "https://github.com/NeverDecaf/chromium-web-store/releases/download/v${version}/Chromium.Web.Store.crx";
      #   sha256 = "sha256-gKAcrvnxLh9gMraTFX4zRsUua4OI+lak51gpII29d8g=";
      #   version = "1.5.4.3";
      # })
    ];
in
{
  enable = true;
  inherit extensions package;
  dictionaries = with pkgs.hunspellDictsChromium; [ en_US ];
  commandLineArgs = [
    # Disable animations.
    "--wm-window-animations-disabled"
    "--animation-duration-scale=0"
  ];
}
