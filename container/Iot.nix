{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.iot;
in {
	options.container.module.iot = {
		enable = lib.mkEnableOption "IoT service.";
		address = lib.mkOption {
			default = "10.1.0.27";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 8123;
			type    = lib.types.int;
		};
		domain = lib.mkOption {
			default = "iot.${config.container.domain}";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/iot";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.iot = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/hass" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
				"/dev/ttyACM0" = {
					hostPath   = "/dev/ttyACM0";
					isReadOnly = false;
				};
				"/dev/serial/by-id" = {
					hostPath   = "/dev/serial/by-id";
					isReadOnly = false;
				};
			}
			// container.attachMedia "photo" true
			;

			allowedDevices = [
				{
					modifier = "rwm";
					node     = "/dev/ttyACM0";
				}
			];

			config = { ... }: container.mkContainerConfig cfg {
				# Allow Hass to talk to Zigbee dongle.
				users.users.hass.extraGroups = [
					"dialout"
					"tty"
				];

				services.home-assistant = {
					# NOTE: Missing: hacs. Inside hacs: `card-mod`, `Clock Weather Card`, `WallPanel` and `Yandex.Station`.
					enable = true;
					# NOTE: Using imperative config because of secrets.
					config = null;
					configDir = "/var/lib/hass";
					extraComponents = [
						"caldav"
						"met"
						"sun"
						"systemmonitor"
						"zha"
					];
					extraPackages =
						python3Packages: with python3Packages; [
							aiodhcpwatcher
							aiodiscover
							aiogithubapi
							arrow
							async-upnp-client
							av
							gtts
							ha-ffmpeg
							hassil
							home-assistant-intents
							mutagen
							numpy
							pymicro-vad
							pynacl
							pyspeex-noise
							python-telegram-bot
							pyturbojpeg
							zeroconf
						];
					# lovelaceConfig = {
					#   title = "Home IoT control center.";
					# };
				};

				# HACK: Delay so that nextcloud calendar can reply on reboot.
				systemd = {
					services."home-assistant".wantedBy = lib.mkForce [ ];
					timers.fixsystemd = {
						timerConfig = {
							OnBootSec = 60;
							Unit = "home-assistant.service";
						};
						wantedBy = [ "timers.target" ];
					};
				};
			};
		};
	};
}
