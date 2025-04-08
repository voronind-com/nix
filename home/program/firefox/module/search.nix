_:
let
  searchEngines = [
    (mkSearchEngine "2g" "2gis" "https://2gis.ru/spb/search/{searchTerms}")
    (mkSearchEngine "4p" "4pda"
      "https://4pda.to/forum/index.php?act=search&forums[]=all&source=all&query={searchTerms}"
    )
    (mkSearchEngine "4l" "4lapy" "https://4lapy.ru/search/filter/?query={searchTerms}")
    (mkSearchEngine "ap" "Apteka" "https://apteka.ru/search/?q={searchTerms}")
    (mkSearchEngine "aw" "Arch Wiki" "https://wiki.archlinux.org/index.php?search={searchTerms}")
    (mkSearchEngine "dn" "DNS" "https://www.dns-shop.ru/search/?q={searchTerms}")
    (mkSearchEngine "fa" "Font Awesome" "https://fontawesome.com/search?q={searchTerms}&o=r&m=free")
    (mkSearchEngine "gh" "GitHub" "https://github.com/search?q={searchTerms}")
    (mkSearchEngine "gc" "GitHub Code" "https://github.com/search?q={searchTerms}&type=code")
    (mkSearchEngine "gn" "GitHub Notif" "https://github.com/notifications?query={searchTerms}")
    (mkSearchEngine "hm" "Home Manager"
      "https://home-manager-options.extranix.com/?query={searchTerms}"
    )
    (mkSearchEngine "im" "IMDB" "https://www.imdb.com/find/?q={searchTerms}")
    (mkSearchEngine "na" "Nix API" "https://noogle.dev/q?term={searchTerms}")
    (mkSearchEngine "nf" "Nerd Font" "https://www.nerdfonts.com/cheat-sheet?q={searchTerms}")
    (mkSearchEngine "nh" "NixHub" "https://www.nixhub.io/search?q={searchTerms}")
    (mkSearchEngine "ni" "Nixpkgs Issue"
      "https://github.com/NixOS/nixpkgs/issues?q=is%3Aissue%20{searchTerms}"
    )
    (mkSearchEngine "no" "NixOS Options" "https://search.nixos.org/options?query={searchTerms}")
    (mkSearchEngine "np" "NixOS Packages" "https://search.nixos.org/packages?query={searchTerms}")
    (mkSearchEngine "nt" "NixOS PR Tracker" "https://nixpk.gs/pr-tracker.html?pr={searchTerms}")
    (mkSearchEngine "oz" "Ozon" "https://www.ozon.ru/search?text={searchTerms}")
    (mkSearchEngine "pd" "ProtonDB" "https://www.protondb.com/search?q={searchTerms}")
    (mkSearchEngine "pe" "Perekrestok" "https://www.perekrestok.ru/cat/search?search={searchTerms}")
    (mkSearchEngine "re" "Reddit" "https://www.reddit.com/search/?q={searchTerms}")
    (mkSearchEngine "rt" "RuTracker" "https://rutracker.org/forum/tracker.php?nm={searchTerms}")
    (mkSearchEngine "sa" "Samokat" "https://samokat.ru/search?value={searchTerms}")
    (mkSearchEngine "so" "Stack Overflow" "https://stackoverflow.com/search?tab=votes&q={searchTerms}")
    (mkSearchEngine "st" "Steam" "https://store.steampowered.com/search/?term={searchTerms}")
    (mkSearchEngine "sx" "SearX" "https://search.voronind.com/search?q={searchTerms}")
    (mkSearchEngine "wa" "Watch" "https://watch.voronind.com/web/#/search.html?query={searchTerms}")
    (mkSearchEngine "wb" "Wildberries"
      "https://www.wildberries.ru/catalog/0/search.aspx?search={searchTerms}"
    )
    (mkSearchEngine "yt" "YouTube" "https://yt.voronind.com/search?q={searchTerms}")
  ];

  mkSearchEngine = Alias: Description: URLTemplate: {
    inherit Alias Description URLTemplate;
    Method = "GET";
    Name = Description;
  };
in
{
  policies = {
    SearchEngines = {
      Add = searchEngines;
      Default = "SearX";
      PreventInstalls = true;
      Remove = [
        "Bing"
        "DuckDuckGo"
        "Google"
        "Wikipedia (en)"
      ];
    };
  };
}
