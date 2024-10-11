{
  container,
  lib,
  config,
  pkgsStable,
  ...
}:
with lib;
let
  cfg = config.container.module.iot;
in
{
  options = {
    container.module.iot = {
      enable = mkEnableOption "IoT service.";
      address = mkOption {
        default = "10.1.0.27";
        type = types.str;
      };
      port = mkOption {
        default = 8123;
        type = types.int;
      };
      domain = mkOption {
        default = "iot.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/iot";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
    ];

    containers.iot = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/hass" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
        "/dev/ttyACM0" = {
          hostPath = "/dev/ttyACM0";
          isReadOnly = false;
        };
        "/dev/serial/by-id" = {
          hostPath = "/dev/serial/by-id";
          isReadOnly = false;
        };
      } // container.attachMedia "photo" true;

      allowedDevices = [
        {
          modifier = "rwm";
          node = "/dev/ttyACM0";
        }
      ];

      config =
        { ... }:
        container.mkContainerConfig cfg {
          # Allow Hass to talk to Zigbee dongle.
          users.users.hass.extraGroups = [
            "dialout"
            "tty"
          ];

          services.home-assistant = {
            # NOTE: Missing: hacs. Inside hacs: `card-mod`, `Clock Weather Card`, `WallPanel` and `Yandex.Station`.
            enable = true;
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
                python-telegram-bot
                pyturbojpeg
                pyspeex-noise
                zeroconf
              ];
            configDir = "/var/lib/hass";
            # lovelaceConfig = {
            #   title = "Home IoT control center.";
            # };
            # NOTE: Using imperative config because of secrets.
            config = null;
          };

          # HACK: Delay so that nextcloud calendar can reply on reboot.
          systemd = {
            services."home-assistant".wantedBy = mkForce [ ];
            timers.fixsystemd = {
              timerConfig = {
                OnBootSec = 15;
                Unit = "home-assistant.service";
              };
              wantedBy = [ "timers.target" ];
            };
          };
        };
    };
  };
}
