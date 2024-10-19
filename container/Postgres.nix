{
  container,
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.postgres;
in
{
  options = {
    container.module.postgres = {
      enable = mkEnableOption "Postgresql server.";
      address = mkOption {
        default = "10.1.0.3";
        type = types.str;
      };
      port = mkOption {
        default = 5432;
        type = types.int;
      };
      storage = mkOption {
        default = "${config.container.storage}/postgres";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [ "data" ];

    containers.postgres = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/postgresql/data" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.postgresql =
            let
              # Populate with services here.
              configurations = with config.container.module; {
                forgejo = git;
                invidious = yt;
                mattermost = chat;
                nextcloud = cloud;
                onlyoffice = office;
                paperless = paper;
                privatebin = paste;
              };

              access = configurations // {
                all = {
                  address = config.container.host;
                };
              };

              authentication = builtins.foldl' (acc: item: acc + "${item}\n") "" (
                mapAttrsToList (db: cfg: "host ${db} ${db} ${cfg.address}/32 trust") access
              );

              ensureDatabases = [ "root" ] ++ mapAttrsToList (name: _: name) configurations;

              ensureUsers = map (name: {
                inherit name;
                ensureClauses =
                  if name == "root" then
                    {
                      superuser = true;
                      createrole = true;
                      createdb = true;
                    }
                  else
                    { };
                ensureDBOwnership = true;
              }) ensureDatabases;
            in
            {
              inherit authentication ensureDatabases ensureUsers;

              enable = true;
              package = pkgs.postgresql_14;
              dataDir = "/var/lib/postgresql/data/14";
              enableTCPIP = true;

              # NOTE: Debug mode.
              # settings = {
              #   log_connections    = true;
              #   log_destination    = lib.mkForce "syslog";
              #   log_disconnections = true;
              #   log_statement      = "all";
              #   logging_collector  = true;
              # };
            };
        };
    };
  };
}
