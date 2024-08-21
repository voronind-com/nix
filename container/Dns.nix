{ container, pkgs, lib, config, ... } @args: with lib; let
	cfg = config.container.module.dns;
in {
	options = {
		container.module.dns = {
			enable = mkEnableOption "Dns server.";
			address = mkOption {
				default = "10.1.0.6";
				type    = types.str;
			};
			port = mkOption {
				default = 53;
				type    = types.int;
			};
		};
	};

	config = mkIf cfg.enable {
		containers.dns = container.mkContainer cfg {
			config = { ... }: container.mkContainerConfig cfg {
				environment.systemPackages = [
					pkgs.cloudflared
				];

				systemd.services.cloudflared = {
					description = "Cloudflare DoH server.";
					enable      = true;
					wantedBy    = [ "multi-user.target" ];
					serviceConfig = {
						Type = "simple";
						ExecStart = "${getExe pkgs.cloudflared} proxy-dns --port 5054";
					};
				};

				services.blocky = {
					enable = true;
					settings = {
						upstream = {
							default = [
								"0.0.0.0:5054"
								"0.0.0.0:5054"
							];
						};
						blocking = {
							blackLists = {
								suspicious = [
									"https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
									"https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
									"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
									"https://v.firebog.net/hosts/static/w3kbl.txt"
								];
								ads = [
									"https://easylist-downloads.adblockplus.org/bitblock.txt"
									"https://adaway.org/hosts.txt"
									"https://v.firebog.net/hosts/AdguardDNS.txt"
									"https://v.firebog.net/hosts/Admiral.txt"
									"https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
									"https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
									"https://v.firebog.net/hosts/Easylist.txt"
									"https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
									"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
									"https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
									"https://github.com/easylist/ruadlist/blob/master/advblock/adservers.txt"
								];
								tracking = [
									"https://v.firebog.net/hosts/Easyprivacy.txt"
									"https://v.firebog.net/hosts/Prigent-Ads.txt"
									"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
									"https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
									"https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
								];
								malicious = [
									"https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
									"https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
									"https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
									"https://v.firebog.net/hosts/Prigent-Crypto.txt"
									"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
									"https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"
									"https://phishing.army/download/phishing_army_blocklist_extended.txt"
									"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
									"https://v.firebog.net/hosts/RPiList-Malware.txt"
									"https://v.firebog.net/hosts/RPiList-Phishing.txt"
									"https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
									"https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
									"https://urlhaus.abuse.ch/downloads/hostfile/"
								];
								other = [
									"https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
								];
							};
							# whiteLists = {
							# 	other = [
							# 		"/.*.vk.com/"
							# 	];
							# };
							clientGroupsBlock = {
								default = [
									"suspicious"
									"ads"
									"tracking"
									"malicious"
									"other"
								];
							};
						};
						customDNS = {
							mapping = {
								# All subdomains to current host.
								# ${config.container.domain} = config.container.host;
								"voronind.com" = "10.0.0.1";
							};
						};
						port = cfg.port;
						# httpPort = "80";
					};
				};
			};
		};
	};
}

