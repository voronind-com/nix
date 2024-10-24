{
  container,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.container.module.dns;
in
{
  options = {
    container.module.dns = {
      enable = lib.mkEnableOption "the DNS server.";
      address = lib.mkOption {
        default = "10.1.0.6";
        type = lib.types.str;
      };
      port = lib.mkOption {
        default = 53;
        type = lib.types.int;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    containers.dns = container.mkContainer cfg {
      config =
        { ... }:
        container.mkContainerConfig cfg {
          environment.systemPackages = [ pkgs.cloudflared ];

          # systemd.services.cloudflared = {
          #   description = "Cloudflare DoH server.";
          #   enable = true;
          #   wantedBy = [ "multi-user.target" ];
          #   serviceConfig = {
          #     Type = "simple";
          #     ExecStart = "${lib.getExe pkgs.cloudflared} proxy-dns --port 5054";
          #   };
          # };

          services.blocky = {
            enable = true;
            # REF: https://0xerr0r.github.io/blocky/main/configuration/
            settings = {
              bootstrapDns = "tcp+udp:1.1.1.1";
              connectIPVersion = "v4";
              upstreams.groups = {
                default = [ "https://dns.quad9.net/dns-query" ];
              };
              caching = {
                maxItemsCount = 100000;
                maxTime = "30m";
                minTime = "5m";
                prefetchExpires = "2h";
                prefetchMaxItemsCount = 100000;
                prefetchThreshold = 5;
                prefetching = true;
              };
              blocking = {
                blockTTL = "1m";
                blockType = "zeroIP";
                loading = {
                  refreshPeriod = "24h";
                  strategy = "blocking";
                  downloads = {
                    timeout = "5m";
                    attempts = 3;
                    cooldown = "10s";
                  };
                };
                # SRC: https://oisd.nl
                # SRC: https://v.firebog.net
                denylists = {
                  suspicious = [
                    "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
                    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" # https://github.com/StevenBlack/hosts
                    "https://v.firebog.net/hosts/static/w3kbl.txt"
                  ];
                  ads = [
                    "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
                    "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
                    "https://v.firebog.net/hosts/AdguardDNS.txt"
                    "https://v.firebog.net/hosts/Admiral.txt"
                    "https://v.firebog.net/hosts/Easylist.txt"
                  ];
                  tracking = [
                    "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
                    "https://v.firebog.net/hosts/Easyprivacy.txt"
                    "https://v.firebog.net/hosts/Prigent-Ads.txt"
                  ];
                  malicious = [
                    "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
                    "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
                    "https://phishing.army/download/phishing_army_blocklist_extended.txt"
                    "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
                    "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
                    "https://urlhaus.abuse.ch/downloads/hostfile/"
                    "https://v.firebog.net/hosts/Prigent-Crypto.txt"
                    "https://v.firebog.net/hosts/Prigent-Malware.txt"
                  ];
                  other = [
                    "https://big.oisd.nl/domainswild"
                    "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
                  ];
                };
                # allowlists = {
                #   other = [
                #     "/.*.vk.com/"
                #   ];
                # };
                clientGroupsBlock = {
                  default = [
                    "suspicious"
                    "ads"
                    "tracking"
                    "malicious"
                    "other"
                  ];
                };
              };
              customDNS = {
                mapping =
                  let
                    block = host: { ${host} = "0.0.0.0"; };
                  in
                  {
                    # All subdomains to current host.
                    # ${config.container.domain} = config.container.host;
                    "voronind.com" = "10.0.0.1";
                  }
                  // block "gosuslugi.ru"
                  // block "rutube.ru"
                  // block "vk.com";
              };
              ports.dns = cfg.port;
              # httpPort = "80";
            };
          };
        };
    };
  };
}
