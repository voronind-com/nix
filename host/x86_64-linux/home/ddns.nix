{ config, ... }:
{
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = "/data/secret/CfToken";
    deleteMissing = false;
    ipv4 = true;
    ipv6 = true;
    proxied = false;
    domains =
      let
        domain = "voronind.com";
      in
      [ domain ]
      ++ map (sub: "${sub}.${domain}") [
        "git"
        "mail"
        "paste"
        "share"
        "vpn"
      ];
  };
}
