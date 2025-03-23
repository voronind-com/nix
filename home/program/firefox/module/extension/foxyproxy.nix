{ ... }:
{
  "foxyproxy@eric.h.jung" = {
    mode = "pattern";
    sync = false;
    data = [
      {
        active = true;
        title = "Local";
        type = "socks5";
        hostname = "localhost";
        port = 1080;
        color = "#ffffff";
        proxyDNS = true;
        include = [ ];
        exclude = [ ];
      }
      {
        active = true;
        title = "Xray";
        type = "socks5";
        hostname = "home.local";
        port = 1080;
        color = "#ffff00";
        proxyDNS = false;
        include = [
          # {
          #   active = true;
          #   pattern = "*://www.youtube.com/*";
          #   title = "YouTube";
          #   type = "wildcard"; # wildcard or regex.
          # }
        ];
        exclude = [ ];
      }
      {
        active = true;
        title = "Tor";
        type = "socks5";
        hostname = "home.local";
        port = 9050;
        color = "#0000ff";
        proxyDNS = true;
        include = [
          {
            active = true;
            pattern = "*.onion";
            title = "Onion";
            type = "wildcard"; # wildcard or regex.
          }
        ];
        exclude = [ ];
      }
    ];
  };
}
