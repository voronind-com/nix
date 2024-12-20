{ ... }:
{
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = "/storage/hot/data/CfToken";
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
        "chat"
        "cloud"
        "git"
        "mail"
        "office"
        "paste"
        "play"
        "vpn"
      ];
  };
}
