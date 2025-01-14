{ pkgs, config, ... }:
let
  iconTheme = "fa-solid";
  links = [ (mkLink "Status" "fa-heartbeat" "https://status.voronind.com") ];
  services = [
    (mkGroup "App" "fa-server" [
      (mkLink "Change" "fa-user-secret" "https://change.voronind.com")
      (mkLink "Craft" "fa-pen-ruler" "https://craft.voronind.com")
      (mkLink "Dav" "fa-calendar" "https://dav.voronind.com")
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
      (mkLink "Share" "fa-share-nodes" "https://share.voronind.com")
      (mkLink "Watch" "fa-film" "https://watch.voronind.com")
      (mkLink "YouTube" "fab fa-youtube" "https://yt.voronind.com")
    ])
    (mkGroup "System" "fa-shield" [
      (mkLink "Camera" "fa-camera" "https://camera.voronind.com")
      (mkLink "Printer" "fa-print" "https://printer.voronind.com")
      (mkLink "Router" "fa-route" "https://router.voronind.com")
      (mkLink "Sync" "fa-sync" "https://sync.voronind.com")
    ])
    (mkGroup "Work" "fa-briefcase" [
      (mkLink "Board" "fa-list-check" "https://support.fsight.ru/agiles")
      (mkLink "Chat" "fa-comments" "https://fsmm.fsight.ru/fmp")
      (mkLink "Cloud" "fa-cloud" "https://cloud.fsight.ru")
      (mkLink "Git" "fab fa-git-alt" "https://git.fmp.fsight.world")
      (mkLink "Mail" "fa-envelope" "https://mail.fsight.ru")
    ])
    (mkGroup "Bookmark" "fa-bookmark" [
      (mkLink "2gis" "fa-map-location-dot" "https://2gis.ru")
      (mkLink "GitHub" "fab fa-github" "https://github.com/notifications")
      (mkLink "MonkeyType" "fa-keyboard" "https://monkeytype.com")
      (mkLink "Reddit" "fab fa-reddit" "https://reddit.com")
      (mkLink "Switch Releases" "fa-gamepad" "https://www.switchscores.com/games/by-date")
      (mkLink "Telegram" "fab fa-telegram" "https://web.telegram.org/a")
      (mkLink "Toolbox" "fa-toolbox" "https://it-tools.tech")
      (mkLink "Zigbee" "fa-satellite-dish" "https://zigbee.blakadder.com")
    ])
    (mkGroup "Wallpaper" "fa-panorama" (
      let
        mkVideoLink = name: url: mkLink name "fa-video" url;
        mkImageLink = name: url: mkLink name "fa-image" url;
      in
      [
        (mkVideoLink "DesktopHut" "https://www.desktophut.com")
        (mkVideoLink "LiveWallpaperPc" "https://livewallpaperpc.com")
        (mkVideoLink "MoeWalls" "https://moewalls.com")
        (mkVideoLink "Motion Backgrounds" "https://motionbgs.com")
      ] ++ [
        (mkImageLink "Unsplash" "https://unsplash.com")
        (mkImageLink "Wallhaven" "https://wallhaven.cc")
      ]
    ))
    (mkGroup "Pirate" "fa-skull-crossbones" [
      (mkLink "1337x" "fa-link" "https://1337x.to")
      (mkLink "Cs.rin.ru" "fa-link" "https://cs.rin.ru/forum/index.php")
      (mkLink "DigitalCore" "fa-link" "https://digitalcore.club")
      (mkLink "FitGirl" "fa-link" "https://fitgirl-repacks.site")
      (mkLink "Hf" "fa-link" "https://happyfappy.org")
      (mkLink "Lst" "fa-link" "https://lst.gg")
      (mkLink "NnmClub" "fa-link" "https://nnmclub.to")
      (mkLink "Rutor" "fa-link" "https://rutor.info")
      (mkLink "Rutracker" "fa-link" "https://rutracker.org")
      (mkLink "Switch Upd" "fa-link" "https://sigmapatches.su")
      (mkLink "Tapochek.net" "fa-link" "https://tapochek.net/index.php")
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
