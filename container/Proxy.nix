# NOTE: To generate self-signed certs use: `openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./privkey.pem -out ./fullchain.pem`
# For dhparams: `openssl dhparam -out ./ssl-dhparam.pem 4096`
# Example for options-ssl-nginx.conf:
# ```
# ssl_session_cache shared:le_nginx_SSL:10m;
# ssl_session_timeout 1440m;
# ssl_protocols TLSv1.2 TLSv1.3;
# ssl_prefer_server_ciphers off;
# ssl_ciphers "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384";
# ```
# For certbot to generate new keys: `certbot certonly --manual --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory -d "*.voronind.com" -d voronind.com`
{
  util,
  container,
  pkgs,
  lib,
  config,
  ...
}@args:
with lib;
let
  cfg = config.container.module.proxy;
  virtualHosts = util.catSet (util.ls ./proxy/host) args;
in
{
  options = {
    container.module.proxy = {
      enable = mkEnableOption "Proxy server.";
      address = mkOption {
        default = "10.1.0.2";
        type = types.str;
      };
      port = mkOption {
        default = 443;
        type = types.int;
      };
      storage = mkOption {
        default = "${config.container.storage}/proxy";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "challenge"
      "letsencrypt"
    ];

    containers.proxy = container.mkContainer cfg {
      bindMounts = {
        "/etc/letsencrypt" = {
          hostPath = "${cfg.storage}/letsencrypt";
          isReadOnly = false;
        };
        "/var/www/.well-known" = {
          hostPath = "${cfg.storage}/challenge";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          environment.systemPackages = with pkgs; [ certbot ];

          services.nginx = {
            inherit virtualHosts;

            enable = true;
            recommendedOptimisation = true;
            recommendedProxySettings = true;
            clientMaxBodySize = "4096m";
            appendConfig = ''
              worker_processes 4;
            '';
            eventsConfig = ''
              worker_connections 4096;
            '';
            appendHttpConfig = ''
              proxy_max_temp_file_size 0;
              proxy_buffering off;

              server {
                listen 443 ssl default_server;
                server_name _;

                ssl_certificate /etc/letsencrypt/live/${config.container.domain}/fullchain.pem;
                ssl_certificate_key /etc/letsencrypt/live/${config.container.domain}/privkey.pem;
                include /etc/letsencrypt/conf/options-ssl-nginx.conf;
                ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;

                return 403;
              }
            '';
          };
        };
    };
  };
}
