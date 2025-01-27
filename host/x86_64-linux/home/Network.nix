# 10.0.0.0/24 & fd09:8d46:b26::/48 - phys clients (lan).
# 10.0.1.0/24 - vpn clients.
# fd09:8d46:b26::/48 - ULA.
{
  config,
  lib,
  util,
  ...
}:
let
  internal = "10.0.0.1"; # Lan host IP address.
  internal6 = "fd09:8d46:b26:0:8079:82ff:fe1a:916a"; # Lan host IP6 address.

  lan = "br0"; # Lan interface.
  wan = "enp8s0"; # Wan interface.
in
{
  # Disable systemd-resolved for DNS server.
  services.resolved.enable = false;

  # NOTE: Debugging.
  # systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";

  # Wan configuration.
  # REF: https://nixos.wiki/wiki/Systemd-networkd
  # REF: man 5 systemd.network
  # REF: Wifi config: https://openwrt.org/docs/guide-user/network/wifi/wifiextenders/bridgedap#wireless_access_point_-_dumb_access_point
  systemd.network = {
    enable = true;
    networks = {
      "10-${wan}" = {
        matchConfig.Name = wan;
        linkConfig.RequiredForOnline = "carrier";
        dns = [
          "::1"
          "1.1.1.1"
          "8.8.8.8"
        ];
        dhcpV4Config = {
          ClientIdentifier = "mac";
          UseDNS = false;
          UseRoutes = true;
        };
        dhcpV6Config = {
          DUIDRawData = "00:03:00:01:a8:a1:59:47:fd:a2";
          DUIDType = "vendor";
          UseDNS = false;
          WithoutRA = "solicit";
          # PrefixDelegationHint = "::/56";
        };
        networkConfig = {
          DHCP = "yes";
          IPv6AcceptRA = true;
          IPv6SendRA = false;
          DHCPPrefixDelegation = true;
        };
        dhcpPrefixDelegationConfig = {
          UplinkInterface = ":self";
          SubnetId = 0;
          Announce = false;
        };
      };
      "20-enp6s0f0" = {
        linkConfig.RequiredForOnline = "enslaved";
        matchConfig.Name = "enp6s0f0";
        networkConfig.Bridge = lan;
      };
      "20-enp6s0f1" = {
        linkConfig.RequiredForOnline = "enslaved";
        matchConfig.Name = "enp6s0f1";
        networkConfig.Bridge = lan;
      };
      "20-enp7s0f0" = {
        linkConfig.RequiredForOnline = "enslaved";
        matchConfig.Name = "enp7s0f0";
        networkConfig.Bridge = lan;
      };
      "20-enp7s0f1" = {
        linkConfig.RequiredForOnline = "enslaved";
        matchConfig.Name = "enp7s0f1";
        networkConfig.Bridge = lan;
      };
      "30-${lan}" = {
        matchConfig.Name = lan;
        linkConfig.RequiredForOnline = "carrier";
        address = [
          "${internal}/24"
          # "${internal6}/48"
        ];
        networkConfig = {
          DHCPPrefixDelegation = true;
          DHCPServer = true;
          IPv6AcceptRA = false;
          IPv6SendRA = true;
        };
        ipv6SendRAConfig = {
          EmitDNS = true;
          DNS = internal6;
        };
        ipv6Prefixes = [
          {
            Assign = true;
            Prefix = "${internal6}/64";
          }
        ];
        dhcpPrefixDelegationConfig = {
          Announce = true;
          SubnetId = 1;
          UplinkInterface = wan;
        };
        dhcpServerConfig = {
          DNS = internal;
          NTP = internal;
          DefaultLeaseTimeSec = "12h";
          EmitDNS = true;
          EmitNTP = true;
          EmitRouter = true;
          EmitTimezone = true;
          MaxLeaseTimeSec = "24h";
          PoolOffset = 100;
          PoolSize = 150;
          ServerAddress = "${internal}/24";
          Timezone = config.module.const.timeZone;
          UplinkInterface = wan;
        };
      };
    };

    netdevs = {
      "10-${lan}" = {
        netdevConfig = {
          Kind = "bridge";
          Name = lan;
        };
      };
    };
  };

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useNetworkd = true;
    networkmanager.enable = lib.mkForce false;
    firewall = {
      enable = true;
      extraCommands = ''
        # Wan access for 10.0.0.0/8 subnet.
        iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -d 0/0 -o ${wan} -j MASQUERADE

        # Full access from Lan.
        ip46tables  -I INPUT -j ACCEPT -i ${lan}

        # Public email server.
        ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 25

        # Public VPN service.
        ip46tables -I INPUT -j ACCEPT -i ${wan} -p udp --dport 22145
        iptables -I INPUT -j ACCEPT -s 10.0.1.0/24

        # Public Nginx.
        ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 443

        # Deluge torrenting ports.
        ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 51413
        ip46tables -I INPUT -j ACCEPT -i ${wan} -p udp --dport 51413

        # Terraria server.
        # ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 22777

        # Mumble.
        ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 22666
        ip46tables -I INPUT -j ACCEPT -i ${wan} -p udp --dport 22666

        # Public SSH access.
        # ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 22143
      '';
    };
  };
}
