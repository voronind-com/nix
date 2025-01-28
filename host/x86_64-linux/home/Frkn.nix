{ config, pkgs, ... }:
{
  services = {
    tor = {
      enable = true;
      openFirewall = true;
      settings =
        let
          exclude = "{RU},{UA},{BY},{KZ},{CN},{??}";
        in
        {
          # ExcludeExitNodes = exclude;
          # ExcludeNodes     = exclude;
          # DNSPort = dnsport;
          UseBridges = true;
          ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird";
          Bridge = [
            "obfs4 121.45.140.249:12123 0922E212E33B04F0B7C1E398161E8EDE06734F26 cert=3AQ4iJFAzxzt7a/zgXIiFEs6fvrXInXt1Dtr09DgnpvUzG/iiyRTdXYZKSYpI124Zt3ZUA iat-mode=0"
            "obfs4 145.239.31.71:10161 882125D15B59BB82BE66F999056CB676D3F061F8 cert=AnD+EvcBMuQDVM7PwW7NgFAzW1M5jDm7DjQtIIcBSjoyAf1FJ2p535rrYL2Kk8POAd0+aw iat-mode=0"
            "obfs4 79.137.11.45:45072 ECA3197D49A29DDECD4ACBF9BCF15E4987B78137 cert=2FKyLWkPgMNCWxBD3cNOTRxJH3XP+HdStPGKMjJfw2YbvVjihIp3X2BCrtxQya9m5II5XA iat-mode=0"
            "obfs4 94.103.89.153:4443 5617848964FD6546968B5BF3FFA6C11BCCABE58B cert=tYsmuuTe9phJS0Gh8NKIpkVZP/XKs7gJCqi31o8LClwYetxzFz0fQZgsMwhNcIlZ0HG5LA iat-mode=0"
          ];
        };
      client = {
        enable = true;
        # dns.enable = true;
        socksListenAddress = {
          IsolateDestAddr = true;
          addr = "0.0.0.0";
          port = 9050;
        };
      };
    };

    xray = {
      enable = true;
      settingsFile = "${config.module.const.host.data}/XrayClient.json";
    };
  };
}
