{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.postgresql =
    let
      # Populate with services here.
      configurations = [
        "forgejo"
        "invidious"
        "nextcloud"
        "paperless"
      ];

      ensureDatabases = [ "root" ] ++ configurations;

      ensureUsers = map (name: {
        inherit name;
        ensureDBOwnership = true;
        ensureClauses =
          if name == "root" then
            {
              createdb = true;
              createrole = true;
              superuser = true;
            }
          else
            { };
      }) ensureDatabases;

      authentication = "local all all trust";
    in
    {
      inherit authentication ensureDatabases ensureUsers;

      enable = true;
      dataDir = "/var/lib/postgresql/14";
      package = pkgs.postgresql_14;

      # NOTE: Debug mode.
      # settings = {
      #   log_connections    = true;
      #   log_destination    = lib.mkForce "syslog";
      #   log_disconnections = true;
      #   log_statement      = "all";
      #   logging_collector  = true;
      # };
    };
}
