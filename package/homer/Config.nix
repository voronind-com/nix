{ pkgs, config, ... }: let
	iconTheme = "fa-solid";

	mkGroup = name: icon: items: {
		inherit name items;
		icon = "${iconTheme} ${icon}";
	};

	mkLink = name: icon: url: {
		inherit name url;
		icon   = "${iconTheme} ${icon}";
		target = "_blank";
	};

	cfg = {
		title    = "Dashboard";
		subtitle = "Home";
		header = false;
		footer = false;
		connectivityCheck = false;

		theme = "default";
		colors = let
			colors = let
				cfg = config.style.color;
			in {
				background          = "#${cfg.bg.dark}";
				card-background     = "#${cfg.bg.regular}";
				card-shadow         = "#${cfg.bg.regular}";
				highlight-hover     = "#${cfg.accent}";
				highlight-primary   = "#${cfg.fg.regular}";
				highlight-secondary = "#${cfg.bg.dark}";
				link                = "#${cfg.fg.regular}";
				link-hover          = "#${cfg.accent}";
				text                = "#${cfg.fg.regular}";
				text-header         = "#${cfg.fg.regular}";
				text-subtitle       = "#${cfg.fg.light}";
				text-title          = "#${cfg.fg.light}";
			};
		in {
			light = colors;
			dark  = colors;
		};

		links = [
			(mkLink "Status" "fa-heartbeat" "https://${config.container.module.status.domain}")
		];

		services = [
			(mkGroup "App" "fa-server" [
				(mkLink "Change"   "fa-user-secret"   "https://${config.container.module.change.domain}")
				(mkLink "Cloud"    "fa-cloud"         "https://${config.container.module.cloud.domain}")
				(mkLink "Download" "fa-download"      "https://${config.container.module.download.domain}")
				(mkLink "Git"      "fab fa-git-alt"   "https://${config.container.module.git.domain}")
				(mkLink "Iot"      "fa-home"          "https://${config.container.module.iot.domain}")
				(mkLink "Mail"     "fa-envelope"      "https://${config.container.module.mail.domain}")
				(mkLink "Paper"    "fa-paperclip"     "https://${config.container.module.paper.domain}")
				(mkLink "Pass"     "fa-key"           "https://${config.container.module.pass.domain}")
				(mkLink "Paste"    "fa-paste"         "https://${config.container.module.paste.domain}/s")
				(mkLink "Print"    "fa-print"         "https://${config.container.module.print.domain}")
				(mkLink "Read"     "fa-book"          "https://${config.container.module.read.domain}")
				(mkLink "Search"   "fa-search"        "https://${config.container.module.search.domain}")
				(mkLink "Stock"    "fa-boxes-stacked" "https://${config.container.module.stock.domain}")
				(mkLink "Watch"    "fa-film"          "https://${config.container.module.watch.domain}")
				(mkLink "YouTube"  "fab fa-youtube"   "https://${config.container.module.yt.domain}")
			])
			(mkGroup "System" "fa-shield" [
				(mkLink "Camera"       "fa-camera"     "https://camera.${config.container.domain}")
				(mkLink "NixOS Search" "fa-snowflake"  "https://search.nixos.org")
				(mkLink "Printer"      "fa-print"      "https://printer.${config.container.domain}")
				(mkLink "Router"       "fa-route"      "https://router.${config.container.domain}")
			])
			(mkGroup "Bookmark" "fa-bookmark" [
				(mkLink "2gis"        "fa-map-location-dot" "https://2gis.ru")
				(mkLink "FontAwesome" "fa-font-awesome"     "https://fontawesome.com/search?o=r&m=free")
				(mkLink "MonkeyType"  "fa-keyboard"         "https://monkeytype.com")
				(mkLink "NerdFonts"   "fa-font"             "https://www.nerdfonts.com/cheat-sheet")
				(mkLink "Reddit"      "fab fa-reddit"       "https://reddit.com")
				(mkLink "Toolbox"     "fa-toolbox"          "https://it-tools.tech")
				(mkLink "Zigbee"      "fa-satellite-dish"   "https://zigbee.blakadder.com")
			])
			(mkGroup "Work" "fa-briefcase" [
				(mkLink "Vm Manager" "fa-server" "https://fs-vcsa.fs.fsight.world/ui")
			])
			(mkGroup "Pirate" "fa-skull-crossbones" [
				(mkLink "1337x"        "fa-skull-crossbones" "https://1337x.to")
				(mkLink "Cs.rin.ru"    "fa-skull-crossbones" "https://cs.rin.ru/forum/index.php")
				(mkLink "DigitalCore"  "fa-skull-crossbones" "https://digitalcore.club")
				(mkLink "FitGirl"      "fa-skull-crossbones" "https://fitgirl-repacks.site")
				(mkLink "Hf"           "fa-skull-crossbones" "https://happyfappy.org")
				(mkLink "Lst"          "fa-skull-crossbones" "https://lst.gg")
				(mkLink "NnmClub"      "fa-skull-crossbones" "https://nnmclub.to")
				(mkLink "Rutor"        "fa-skull-crossbones" "https://rutor.info")
				(mkLink "Rutracker"    "fa-skull-crossbones" "https://rutracker.org")
				(mkLink "Switch Upd"   "fa-skull-crossbones" "https://sigmapatches.su")
				(mkLink "Tapochek.net" "fa-skull-crossbones" "https://tapochek.net/index.php")
			])
		];
	};
in {
	file = (pkgs.formats.yaml {}).generate "HomerConfig" cfg;
}
