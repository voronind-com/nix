{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    database.createLocally = true;
    extraAppsEnable = true;
    hostName = "cloud.voronind.com";
    https = true;
    # package = pkgs.nextcloud29;
    # phpOptions = {
    #   memory_limit = lib.mkForce "20G";
    # };
    config = {
      adminpassFile = "${pkgs.writeText "NextcloudPassword" "root"}";
      adminuser = "root";
      dbname = "nextcloud";
      # dbpassFile    = "${pkgs.writeText "NextcloudDbPassword" "nextcloud"}";
      dbtype = "pgsql";
      dbuser = "nextcloud";
    };
    extraApps = { inherit (config.services.nextcloud.package.packages.apps) contacts calendar; };
    settings = {
      allow_local_remote_servers = true;
      trusted_domains = [ "cloud.voronind.com" ];
      trusted_proxies = [
        # proxy.address
      ];
    };
  };
}
