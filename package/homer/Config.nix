{ pkgs, config, ... }:
let
  iconTheme = "fa-solid";
  links = [ (mkLink "Status" "fa-heartbeat" "https://status.voronind.com") ];
  services = [
    (mkGroup "App" "fa-server" [
      (mkLink "Change" "fa-user-secret" "https://change.voronind.com")
      (mkLink "Cloud" "fa-cloud" "https://cloud.voronind.com")
      (mkLink "Download" "fa-download" "https://download.voronind.com")
      (mkLink "Git" "fab fa-git-alt" "https://git.voronind.com")
      (mkLink "Iot" "fa-home" "https://iot.voronind.com")
      (mkLink "Mail" "fa-envelope" "https://mail.voronind.com")
      (mkLink "Paper" "fa-paperclip" "https://paper.voronind.com")
      (mkLink "Pass" "fa-key" "https://pass.voronind.com")
      (mkLink "Paste" "fa-paste" "https://paste.voronind.com")
      (mkLink "Print" "fa-print" "https://print.voronind.com")
      (mkLink "Read" "fa-book" "https://read.voronind.com")
      (mkLink "Search" "fa-search" "https://search.voronind.com")
      (mkLink "Stock" "fa-boxes-stacked" "https://stock.voronind.com")
      (mkLink "Watch" "fa-film" "https://watch.voronind.com")
      (mkLink "YouTube" "fab fa-youtube" "https://yt.voronind.com")
    ])
    (mkGroup "System" "fa-shield" [
      (mkLink "Camera" "fa-camera" "https://camera.voronind.com")
      (mkLink "Printer" "fa-print" "https://printer.voronind.com")
      (mkLink "Router" "fa-route" "https://router.voronind.com")
      (mkLink "Sync" "fa-sync" "https://sync.voronind.com")
    ])
    (mkGroup "Bookmark" "fa-bookmark" [
      (mkLink "2gis" "fa-map-location-dot" "https://2gis.ru")
      (mkLink "MonkeyType" "fa-keyboard" "https://monkeytype.com")
      (mkLink "Reddit" "fab fa-reddit" "https://reddit.com")
      (mkLink "Toolbox" "fa-toolbox" "https://it-tools.tech")
      (mkLink "Zigbee" "fa-satellite-dish" "https://zigbee.blakadder.com")
    ])
    (mkGroup "Pirate" "fa-skull-crossbones" [
      (mkLink "1337x" "fa-skull-crossbones" "https://1337x.to")
      (mkLink "Cs.rin.ru" "fa-skull-crossbones" "https://cs.rin.ru/forum/index.php")
      (mkLink "DigitalCore" "fa-skull-crossbones" "https://digitalcore.club")
      (mkLink "FitGirl" "fa-skull-crossbones" "https://fitgirl-repacks.site")
      (mkLink "Hf" "fa-skull-crossbones" "https://happyfappy.org")
      (mkLink "Lst" "fa-skull-crossbones" "https://lst.gg")
      (mkLink "NnmClub" "fa-skull-crossbones" "https://nnmclub.to")
      (mkLink "Rutor" "fa-skull-crossbones" "https://rutor.info")
      (mkLink "Rutracker" "fa-skull-crossbones" "https://rutracker.org")
      (mkLink "Switch Upd" "fa-skull-crossbones" "https://sigmapatches.su")
      (mkLink "Tapochek.net" "fa-skull-crossbones" "https://tapochek.net/index.php")
    ])
  ];

  mkGroup = name: icon: items: {
    inherit name items;
    icon = "${iconTheme} ${icon}";
  };

  mkLink = name: icon: url: {
    inherit name url;
    icon = "${iconTheme} ${icon}";
    target = "_blank";
  };

  cfg = {
    inherit services links;
    connectivityCheck = false;
    footer = false;
    header = false;
    subtitle = "Home";
    theme = "default";
    title = "Dashboard";
    colors =
      let
        style = with config.module.style.color; {
          background = "#${bg.dark}";
          card-background = "#${bg.regular}";
          card-shadow = "#${bg.regular}";
          highlight-hover = "#${accent}";
          highlight-primary = "#${fg.regular}";
          highlight-secondary = "#${bg.dark}";
          link = "#${fg.regular}";
          link-hover = "#${accent}";
          text = "#${fg.regular}";
          text-header = "#${fg.regular}";
          text-subtitle = "#${fg.light}";
          text-title = "#${fg.light}";
        };
      in
      {
        dark = style;
        light = style;
      };
  };
in
{
  file = (pkgs.formats.yaml { }).generate "HomerConfig" cfg;
}
