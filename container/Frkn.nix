{
	__findFile,
	config,
	container,
	inputs,
	lib,
	pkgs,
	pkgsMaster,
	util,
	...
} @args: let
	cfg = config.container.module.frkn;
in {
	options.container.module.frkn = {
		enable = lib.mkEnableOption "the Allmighty FRKN service.";
		address = lib.mkOption {
			default = "10.1.0.69";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 1080;
			type    = lib.types.int;
		};
		torport = lib.mkOption {
			default = 9150;
			type    = lib.types.int;
		};
		xrayport = lib.mkOption {
			default = 1081;
			type    = lib.types.int;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/frkn";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.frkn = container.mkContainer cfg {
			bindMounts = {
				"/data" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = true;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				disabledModules = [ "services/networking/zapret.nix" ];
				imports = [ "${inputs.nixpkgsMaster}/nixos/modules/services/networking/zapret.nix" ];

				boot.kernel.sysctl = {
					"net.ipv4.conf.all.src_valid_mark" = 1;
					"net.ipv4.ip_forward" = 1;
				};

				services.zapret = {
					inherit (config.services.zapret) params;
					enable  = true;
					package = pkgsMaster.zapret;
				};

				services = {
					microsocks = {
						enable = true;
						disableLogging = true;
						ip   = cfg.address;
						port = cfg.port;
					};

					tor = {
						enable = true;
						openFirewall = true;
						settings = let
							exclude = "{RU},{UA},{BY},{KZ},{CN},{??}";
						in {
							# ExcludeExitNodes = exclude;
							# ExcludeNodes     = exclude;
							# DNSPort = dnsport;
							UseBridges = true;
							ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird";
							Bridge = [
								"obfs4 121.45.140.249:12123 0922E212E33B04F0B7C1E398161E8EDE06734F26 cert=3AQ4iJFAzxzt7a/zgXIiFEs6fvrXInXt1Dtr09DgnpvUzG/iiyRTdXYZKSYpI124Zt3ZUA iat-mode=0"
								"obfs4 145.239.31.71:10161 882125D15B59BB82BE66F999056CB676D3F061F8 cert=AnD+EvcBMuQDVM7PwW7NgFAzW1M5jDm7DjQtIIcBSjoyAf1FJ2p535rrYL2Kk8POAd0+aw iat-mode=0"
								"obfs4 79.137.11.45:45072 ECA3197D49A29DDECD4ACBF9BCF15E4987B78137 cert=2FKyLWkPgMNCWxBD3cNOTRxJH3XP+HdStPGKMjJfw2YbvVjihIp3X2BCrtxQya9m5II5XA iat-mode=0"
								"obfs4 94.103.89.153:4443 5617848964FD6546968B5BF3FFA6C11BCCABE58B cert=tYsmuuTe9phJS0Gh8NKIpkVZP/XKs7gJCqi31o8LClwYetxzFz0fQZgsMwhNcIlZ0HG5LA iat-mode=0"
							];
						};

						client = {
							enable = true;
							# dns.enable = true;
							socksListenAddress = {
								IsolateDestAddr = true;
								addr = cfg.address;
								port = cfg.torport;
							};
						};
					};

					xray = {
						enable = true;
						settingsFile = "/data/Client.json";
					};
				};

				systemd = {
					services.tor.wantedBy = lib.mkForce [ ];

					timers.tor = {
						timerConfig = {
							OnBootSec = 5;
							Unit = "tor.service";
						};
						wantedBy = [ "timers.target" ];
					};
				};
			};
		};
	};
}
