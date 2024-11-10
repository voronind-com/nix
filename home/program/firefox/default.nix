{
	__findFile,
	config,
	pkgs,
	...
}: let
	bookmarks = [
		(mkBookmark "Dashboard" "https://home.voronind.com")
		(mkBookmark "Watch"     "https://watch.voronind.com")
		(mkBookmark "Telegram"  "https://web.telegram.org/a")
		(mkBookmark "WorkChat"  "https://fsmm.fsight.ru/fmp")
		(mkBookmark "Mail"      "https://mail.voronind.com")
		(mkBookmark "WorkMail"  "https://mail.fsight.ru")
		(mkBookmark "Git"       "https://git.voronind.com")
		(mkBookmark "WorkGit"   "https://git.fmp.fsight.world")
		(mkBookmark "WorkBoard" "https://support.fsight.ru")
		(mkBookmark "Hass"      "https://iot.voronind.com")
		(mkBookmark "Cloud"     "https://cloud.voronind.com")
		(mkBookmark "GitHub"    "https://github.com/notifications")
	];

	searchEngines = [
		(mkSearchEngine "4pda" "4pda"           "https://4pda.to/forum/index.php?act=search&forums[]=all&source=all&query={searchTerms}")
		(mkSearchEngine "aw"   "Arch Wiki"      "https://wiki.archlinux.org/index.php?search={searchTerms}")
		(mkSearchEngine "gh"   "GitHub"         "https://github.com/search?q={searchTerms}")
		(mkSearchEngine "ghc"  "GitHub Code"    "https://github.com/search?q={searchTerms}&type=code")
		(mkSearchEngine "ghn"  "GitHub Notif"   "https://github.com/notifications?query={searchTerms}")
		(mkSearchEngine "hm"   "Home Manager"   "https://home-manager-options.extranix.com/?query={searchTerms}")
		(mkSearchEngine "no"   "NixOS Options"  "https://search.nixos.org/options?query={searchTerms}")
		(mkSearchEngine "np"   "NixOS Packages" "https://search.nixos.org/packages?query={searchTerms}")
		(mkSearchEngine "re"   "Reddit"         "https://www.reddit.com/search/?q={searchTerms}")
		(mkSearchEngine "rt"   "RuTracker"      "https://rutracker.org/forum/tracker.php?nm={searchTerms}")
		(mkSearchEngine "s"    "SearX"          "https://search.voronind.com/search?q={searchTerms}")
		(mkSearchEngine "so"   "Stack Overflow" "https://stackoverflow.com/search?tab=votes&q={searchTerms}")
		(mkSearchEngine "st"   "Steam"          "https://store.steampowered.com/search/?term={searchTerms}")
		(mkSearchEngine "yt"   "YouTube"        "https://yt.voronind.com/search?q={searchTerms}")
	];

	extensions = [
		# TODO: Use this after https://github.com/darkreader/darkreader/pull/12920 gets merged.
		# (mkExtension "addon@darkreader.org" "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi")
		(mkExtension "addon@darkreader.org"                   "file://${pkgs.callPackage <package/darkreader> { }}/latest.xpi")
		(mkExtension "cliget@zaidabdulla.com"                 "https://addons.mozilla.org/firefox/downloads/latest/cliget/latest.xpi")
		(mkExtension "foxyproxy@eric.h.jung"                  "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi")
		(mkExtension "uBlock0@raymondhill.net"                "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi")
		(mkExtension "{446900e4-71c2-419f-a6a7-df9c091e268b}" "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi")
		(mkExtension "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi")
		(mkExtension "{d7742d87-e61d-4b78-b8a1-b469842139fa}" "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi")
		(mkExtension "{e7625f06-e252-479d-ac7a-db68aeaff2cb}" "https://addons.mozilla.org/firefox/downloads/latest/togglefonts/latest.xpi")
		# NOTE: This extension is helpful to find the required parameters for this config.
		# Or find them yourself inside the `about:support`.
		# (mkExtension "queryamoid@kaply.com" "https://github.com/mkaply/queryamoid/releases/download/v0.1/query_amo_addon_id-0.1-fx.xpi")
	];

	prefs = [
		# WARN: Remove when Dark Reader policies gets merged.
		(mkLockedPref "xpinstall.signatures.required" false)

		# Bookmarks.
		(mkLockedPref "browser.microsummary.enabled" true)
		(mkLockedPref "browser.places.importBookmarksHTML" true)
		(mkLockedPref "browser.toolbars.bookmarks.visibility" "never")

		# Fonts.
		(mkUserPref "browser.display.use_document_fonts" 0)
		(mkLockedPref "font.minimum-size.x-cyrillic"    (toString config.module.style.font.size.application))
		(mkLockedPref "font.minimum-size.x-unicode"     (toString config.module.style.font.size.application))
		(mkLockedPref "font.minimum-size.x-western"     (toString config.module.style.font.size.application))
		(mkLockedPref "font.name.monospace.x-cyrillic"  config.module.style.font.monospace.name)
		(mkLockedPref "font.name.monospace.x-unicode"   config.module.style.font.monospace.name)
		(mkLockedPref "font.name.monospace.x-western"   config.module.style.font.monospace.name)
		(mkLockedPref "font.name.sans-serif.x-cyrillic" config.module.style.font.sansSerif.name)
		(mkLockedPref "font.name.sans-serif.x-unicode"  config.module.style.font.sansSerif.name)
		(mkLockedPref "font.name.sans-serif.x-western"  config.module.style.font.sansSerif.name)
		(mkLockedPref "font.name.serif.x-cyrillic"      config.module.style.font.serif.name)
		(mkLockedPref "font.name.serif.x-unicode"       config.module.style.font.serif.name)
		(mkLockedPref "font.name.serif.x-western"       config.module.style.font.serif.name)

		# Animations.
		(mkLockedPref "browser.fullscreen.animateUp" 0)
		(mkLockedPref "browser.fullscreen.autohide" true)

		# Formats.
		(mkLockedPref "image.jxl.enabled" true)

		# Disable HTTP3.
		# (mkLockedPref "network.http.http3.enable" false)

		# Style.
		(mkLockedPref "toolkit.legacyUserProfileCustomizations.stylesheets" true)
	];

	userChrome = ''
		* {
			font-family: "${config.module.style.font.serif.name}" !important;
			font-size:   ${toString config.module.style.font.size.application}pt !important;
		}
	'';

	userContent = ''
		@-moz-document url(about:home), url(about:newtab), url(about:privatebrowsing), url(about:blank) {
			.click-target-container *, .top-sites-list * {
				color: #fff !important ;
				text-shadow: 2px 2px 2px #222 !important ;
			}
			body::before {
				content: "" ;
				z-index: -1 ;
				position: fixed ;
				top: 0 ;
				left: 0 ;
				background: #f9a no-repeat url("${config.module.wallpaper.path}?raw=true") center ;
				background-color: #222;
				background-size: cover ;
				/* filter: blur(4px) ; */
				width: 100vw ;
				height: 100vh ;
			}
			/* .logo { background-image: url("{repo}/logo.png?raw=true") !important; } */
			/* .logo { background-image: none !important; } */
		}
	'';

	mkExtension = id: install_url: {
		${id} = {
			inherit install_url;
			installation_mode = "force_installed";
		};
	};

	mkBookmark = name: url: { inherit name url; };

	mkSearchEngine = Alias: Description: URLTemplate: {
		inherit Alias Description URLTemplate;
		Method = "GET";
		Name   = Description;
	};

	mkPref = Name: Value: Status: {
		${Name} = { inherit Value Status; };
	};
	mkLockedPref = Name: Value: mkPref Name Value "locked";
	mkUserPref   = Name: Value: mkPref Name Value "user";
in {
	enable = true;
	package = pkgs.firefox-esr;
	# languagePacks = [ "en-US" "ru" ];
	profiles.default = {
		inherit userChrome userContent;
	};
	# REF: https://mozilla.github.io/policy-templates/
	policies = {
		AppAutoUpdate                  = false;
		AutofillAddressEnabled         = true;
		AutofillCreditCardEnabled      = false;
		BackgroundAppUpdate            = false;
		CaptivePortal                  = true;
		DisableBuiltinPDFViewer        = true;
		DisableFirefoxAccounts         = true;
		DisableFirefoxStudies          = true;
		DisableFormHistory             = true;
		DisableMasterPasswordCreation  = true;
		DisablePasswordReveal          = true;
		DisablePocket                  = true;
		DisableProfileImport           = true;
		DisableSafeMode                = true;
		DisableSetDesktopBackground    = true;
		DisableTelemetry               = true;
		DontCheckDefaultBrowser        = false;
		ExtensionUpdate                = true;
		HttpsOnlyMode                  = "enabled";
		ManagedBookmarks               = [ { toplevel_name = "Pin"; } ] ++ bookmarks;
		NetworkPrediction              = false;
		NoDefaultBookmarks             = true;
		OfferToSaveLogins              = false;
		PasswordManagerEnabled         = false;
		PostQuantumKeyAgreementEnabled = true;
		Preferences                    = builtins.foldl' (acc: pref: acc // pref) { } prefs;
		PromptForDownloadLocation      = false;
		SearchSuggestEnabled           = false;
		ShowHomeButton                 = false;
		StartDownloadsInTempDirectory  = false;
		TranslateEnabled               = false;
		UseSystemPrintDialog           = true;
		WebsiteFilter = [ ];
		PopupBlocking = {
			Allow = [];
			Default = true;
			Locked  = true;
		};
		Homepage = {
			Locked    = true;
			StartPage = "previous-session";
			URL       = "https://home.voronind.com";
		};
		DNSOverHTTPS = {
			Enabled     = false;
			# Fallback    = false;
			Locked      = false;
			ProviderURL = "https://dns.quad9.net/dns-query";
		};
		Cookies = {
			Behavior = "reject-foreign";
			AllowSession = [
				"https://yandex.ru"
			];
			Block = [
				"https://google.com"
			];
		};
		# Containers = {}; # TODO: Use containers? https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/
		Certificates = {
			ImportEnterpriseRoots = false;
			Install = [ ];
		};
		EnableTrackingProtection = {
			Value          = true;
			Locked         = false;
			Cryptomining   = true;
			Fingerprinting = true;
			EmailTracking  = true;
			Exceptions = [
				"https://example.com"
			];
		};
		EncryptedMediaExtensions = {
			Enabled = true;
			Locked  = true;
		};
		ExtensionSettings = {
			# Block extension installation outside of this config.
			"*" = {
				install_sources   = [ "*" ];
				installation_mode = "blocked";
			};
		} // builtins.foldl' (acc: ext: acc // ext) { } extensions;
		"3rdparty".Extensions = {
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
			"addon@darkreader.org" = {
				enabled                 = true;
				enabledByDefault        = true;
				changeBrowserTheme      = false;
				detectDarkTheme         = false;
				enableContextMenus      = false;
				enableForPDF            = false;
				enableForProtectedPages = false;
				fetchNews               = false;
				previewNewDesign        = true;
				syncSettings            = true;
				syncSitesFixes          = false;
				disabledFor = [
					"home.voronind.com"
				];
				theme = {
					brightness                 = 100;
					contrast                   = 100;
					darkColorScheme            = "Default";
					darkSchemeBackgroundColor  = "#${config.module.style.color.bg.dark}";
					darkSchemeTextColor        = "#${config.module.style.color.fg.light}";
					engine                     = "dynamicTheme"; # dynamicTheme, cssFilter or svgFilter.
					fontFamily                 = config.module.style.font.sansSerif.name;
					grayscale                  = 0;
					immediateModify            = true;
					lightColorScheme           = "Default";
					lightSchemeBackgroundColor = "#${config.module.style.color.bg.light}";
					lightSchemeTextColor       = "#${config.module.style.color.fg.dark}";
					mode                       = 1;
					scrollbarColor             = "#${config.module.style.color.neutral}";
					selectionColor             = "#${config.module.style.color.selection}";
					sepia                      = 0;
					styleSystemControls        = true;
					stylesheet                 = "";
					textStroke                 = 0;
					useFont                    = false;
				};
				automation = {
					enabled  = false;
					behavior = "OnOff";
					mode     = "";
				};
				time = {
					activation   = "18:00";
					deactivation = "9:00";
				};
				location = {
					latitude  = null;
					longitude = null;
				};
			};
			"{446900e4-71c2-419f-a6a7-df9c091e268b}".environment = {
				base = "https://pass.voronind.com";
			};
		};
		# NOTE: `firefox-esr` edition is required to change search engines.
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
		FirefoxHome = {
			Highlights        = false;
			Locked            = true;
			Pocket            = false;
			Search            = false;
			Snippets          = false;
			SponsoredTopSites = false;
			TopSites          = false;
		};
		FirefoxSuggest = {
			ImproveSuggest       = false;
			Locked               = true;
			SponsoredSuggestions = false;
			WebSuggestions       = false;
		};
		PDFjs = {
			Enabled = false;
			EnablePermissions = false;
		};
		Handlers = {
			mimeTypes."application/pdf".action = "saveToDisk";
		};
		extensions = {
			pdf = {
				action = "useHelperApp";
				ask    = true;
				handlers = [
					{
						name = "GNOME Document Viewer";
						path = "${pkgs.evince}/bin/evince";
					}
				];
			};
		};
		Permissions = {
			Camera = {
				Allow = [ ];
				Block = [ ];
				BlockNewRequests = false;
				Locked = false;
			};
			Microphome = {
				Allow = [ ];
				Block = [ ];
				BlockNewRequests = false;
				Locked = false;
			};
			Location = {
				Allow = [ ];
				Block = [ ];
				BlockNewRequests = true;
				Locked = true;
			};
			Autoplay = {
				Allow = [ ];
				Block = [ ];
				Default = "block-audio-video"; # allow-audio-video | block-audio | block-audio-video
				Locked = true;
			};
		};
		PictureInPicture = {
			Enabled = false;
			Locked  = false;
		};
		SanitizeOnShutdown = {
			Cache        = true;
			Cookies      = false;
			Downloads    = false;
			FormData     = true;
			History      = false;
			Locked       = true;
			OfflineApps  = true;
			Sessions     = false;
			SiteSettings = false;
		};
		UserMessaging = {
			ExtensionRecommendations = false;
			FeatureRecommendations   = false;
			Locked                   = true;
			MoreFromMozilla          = false;
			SkipOnboarding           = true;
			UrlbarInterventions      = false;
			WhatsNew                 = false;
		};
	};
}
