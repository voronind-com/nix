{
  container,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.container.module.chat;
  db = config.container.module.postgres;
in
{
  options = {
    container.module.chat = {
      enable = lib.mkEnableOption "chat container.";
      address = lib.mkOption {
        default = "10.1.0.20";
        type = lib.types.str;
      };
      port = lib.mkOption {
        default = 8065;
        type = lib.types.int;
      };
      domain = lib.mkOption {
        default = "chat.${config.container.domain}";
        type = lib.types.str;
      };
      storage = lib.mkOption {
        default = "${config.container.storage}/chat";
        type = lib.types.str;
      };
    };
  };

  # WIP: https://search.nixos.org/options?channel=24.05&from=0&size=50&sort=relevance&type=packages&query=mattermost
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.chat = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/mattermost" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.mattermost = {
            enable = true;
            listenAddress = ":${toString cfg.port}";
            localDatabaseCreate = false;
            mutableConfig = false;
            package = pkgs.mattermost;
            siteName = "Chat";
            siteUrl = "https://${cfg.domain}";
            statePath = "/var/lib/mattermost";
            plugins =
              let
                calls =
                  let
                    version = "1.2.0";
                  in
                  pkgs.fetchurl {
                    url = "https://github.com/mattermost/mattermost-plugin-calls/releases/download/v${version}/mattermost-plugin-calls-v${version}.tar.gz";
                    hash = "sha256-yQGBpBPgXxC+Pm6dHlbwlNEdvn6wg9neSpNNTC4YYAA=";
                  };
              in
              [ calls ];
            extraConfig = {
              SqlSettings = {
                DataSource = "postgres://mattermost:any@${db.address}:${toString db.port}/mattermost?sslmode=disable&connect_timeout=10";
                DriverName = "postgres";
              };
            };
          };
        };
    };
  };
}
