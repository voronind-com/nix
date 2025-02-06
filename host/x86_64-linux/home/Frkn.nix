{ config, pkgs, ... }:
{
  module.dpi.bypass = {
    enable = true;
    udpSupport = true;
    params = [
      "--dpi-desync=multisplit"
      "--dpi-desync-split-pos=10,midsld"
      "--dpi-desync-split-seqovl=1"

      "--dpi-desync-any-protocol"
    ];
    whitelist = [
      "youtube.com"
      "googlevideo.com"
      "google.com"
      "ytimg.com"
      "youtu.be"
      "m.youtube.com"
      "rutracker.org"
      "rutracker.cc"
      "rutrk.org"
      "t-ru.org"
      "medium.com"
    ];
    udpPorts = [ "443" ];
  };

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
            "obfs4 89.58.2.217:9292 B72A7169C09F78E9F65020BEFA1F7ECD1BD838F7 cert=9pkzE06rv53gTCAofw1jIOymJkm1D7aMT+gAm+OAcowHLkjwJvnIUpNYDldlJu4dstxiHg iat-mode=0"
            "obfs4 107.189.3.186:32363 5ABFC5405EAFD091BCAF4D9E4318D1FC52D531B9 cert=7p2ynsYB7whyjW6m/zF2kSl/X5veyfHZsFQWGyYr+zTvu+g3IhvbW7OUhG1EOgmBa3dbfA iat-mode=0"
            "obfs4 51.91.210.40:50499 02EBBFE93E096DE4A951A7490BA6F627D19E17D6 cert=zi18veVS2T3yEXzOc2k238UAUZjCQk0AZYpdP0TjlzDpQzH3N7S1vYF2xpjtcV5SjyhZXA iat-mode=0"
            "obfs4 91.134.80.21:2755 7AEA25E46D7BE4E1F86021DC76AEA5E196179D21 cert=loKrRJYnD9H1TOPx+axdQgjbz8At5B6cgUWzAxiG/HNLQLytxvwCmZ/7YB8vwSFNmGslYA iat-mode=0"
          ];
        };
      client = {
        enable = true;
        # dns.enable = true;
        socksListenAddress = {
          IsolateDestAddr = true;
          addr = "::";
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
