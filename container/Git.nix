{
  container,
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.container.module.git;
in
{
  options = {
    container.module.git = {
      enable = mkEnableOption "Git server.";
      address = mkOption {
        default = "10.1.0.8";
        type = types.str;
      };
      port = mkOption {
        default = 3000;
        type = types.int;
      };
      portSsh = mkOption {
        default = 22144;
        type = types.int;
      };
      domain = mkOption {
        default = "git.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/git";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
    ];

    containers.git = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/forgejo" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          environment.systemPackages = with pkgs; [ forgejo ];

          services.forgejo = {
            enable = true;
            stateDir = "/var/lib/forgejo";

            database =
              let
                postgre = config.container.module.postgres;
              in
              {
                type = "postgres";
                host = postgre.address;
                port = postgre.port;
                user = "forgejo";
                name = "forgejo";
                createDatabase = false;
              };

            settings =
              let
                gcArgs = "--aggressive --no-cruft --prune=now";
                gcTimeout = 600;
              in
              {
                "service".DISABLE_REGISTRATION = true;
                "log".LEVEL = "Error";
                "server" = {
                  DOMAIN = cfg.domain;
                  HTTP_ADDR = cfg.address;
                  ROOT_URL = "https://${cfg.domain}";

                  BUILTIN_SSH_SERVER_USER = "git";
                  DISABLE_SSH = false;
                  SSH_PORT = cfg.portSsh;
                  START_SSH_SERVER = true;
                };
                "ui" = {
                  AMBIGUOUS_UNICODE_DETECTION = false;
                };
                "repository" = {
                  DEFAULT_PRIVATE = "private";
                  DEFAULT_PUSH_CREATE_PRIVATE = true;
                };
                "repository.pull-request".DEFAULT_MERGE_STYLE = "rebase";
                "repository.issue".MAX_PINNED = 99999;
                "cron" = {
                  ENABLED = true;
                  RUN_AT_START = true;
                };
                "repo-archive".ENABLED = false;
                "cron.update_mirrors".SCHEDULE = "@midnight";
                "cron.cleanup_actions".ENABLED = true;
                "cron.git_gc_repos" = {
                  ENABLED = true;
                  SCHEDULE = "@midnight";
                  TIMEOUT = gcTimeout;
                  ARGS = gcArgs;
                };
                "git" = {
                  GC_ARGS = gcArgs;
                };
                "git.timeout".GC = gcTimeout;
              };
          };
        };
    };
  };
}
