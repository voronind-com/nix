{ ... }:
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    environmentFile = "/var/lib/vaultwarden/Env";
    config = {
      DATA_FOLDER = "/var/lib/vaultwarden";
      DOMAIN = "https://pass.voronind.com";
      ROCKET_ADDRESS = "::1";
      ROCKET_PORT = 8001;
      SIGNUPS_ALLOWED = false;
      WEB_VAULT_ENABLED = true;
    };
  };
}
