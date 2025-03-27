{ config, pkgs, ... }:
{
  module.dpi.bypass = {
    enable = true;
    udpSupport = true;
    udpPorts = [ "443" ];
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

      "booktracker.org"
      "flibusta.is"
      "libgen.is"

      "medium.com"
    ];
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
            "obfs4 92.252.95.203:8080 02F00A33017A24E99112E5CA498AECD204F913F3 cert=eWfCYOE/3kdmDpYy/tT0CuKI01dWKY6BtSAMSu0uuD4ixo7RE4/av+0fNjw4sbZmORLKVQ iat-mode=0"
            "obfs4 107.173.203.25:443 D1E5D320BB055566190B9D11DF7A8456F390D87A cert=TEDIJPnZDUTbstON7gS4nxxuu5G5yaMf6UIj9XqgfSWviJQR6vHADbIlW1NUiF1qtrGHKw iat-mode=0"
            "obfs4 15.235.44.216:21678 ABEA6F3690E0169D35B9E6E6DB19099B81607C02 cert=gzRHf+IF4SLjmKL3XM09XaofsFs9pP5xv0uBRec8tbf9tj9HBdgepQqVXcQYMron6hZOHA iat-mode=0"
            "obfs4 37.27.251.34:38177 5A6EBAE05805F50F33654891861A0E6B88456E33 cert=cbdosmrEEoDyphm9oeWhPaszwymIbkrcqwlBkZrUAnew00pW+wBUP+SWfTGBSOeUjRlePw iat-mode=0"
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
      settingsFile = "/data/secret/xray-client.json";
    };
  };
}
