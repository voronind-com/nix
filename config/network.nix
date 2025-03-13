{ config, lib, ... }:
let
  cfg = config.module.network;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.setup.wifi {
      networking.networkmanager.ensureProfiles = {
        environmentFiles = [ config.age.secrets.wifi.path ];

        profiles = {
          cakee = {
            connection = {
              id = "cakee";
              type = "wifi";
            };
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
              addr-gen-mode = "eui64";
              method = "auto";
            };
            wifi = {
              mode = "infrastructure";
              ssid = "cakee";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$CAKEE_PSK";
            };
          };

          # Larisa Wifi.
          Kotik = {
            connection = {
              id = "Kotik";
              type = "wifi";
            };
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
              addr-gen-mode = "eui64";
              method = "auto";
            };
            wifi = {
              mode = "infrastructure";
              ssid = "Kotik";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$KOTIK_PSK";
            };
          };
        };
      };
    })

    (lib.mkIf cfg.setup.vpn.home {
      networking.networkmanager.ensureProfiles = {
        profiles = {
          Home = {
            connection = {
              id = "Home";
              type = "vpn";
            };
            vpn = {
              ca = config.age.secrets."vpn/home/ca".path;
              cert = config.age.secrets."vpn/home/cert".path;
              cert-pass-flags = 1;
              challenge-response-flags = 2;
              connection-type = "tls";
              key = config.age.secrets."vpn/home/key".path;
              remote = "voronind.com:22145";
              service-type = "org.freedesktop.NetworkManager.openvpn";
            };
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
              addr-gen-mode = "stable-privacy";
              method = "auto";
            };
          };
        };
      };
    })

    (lib.mkIf cfg.setup.vpn.fsight {
      networking.networkmanager.ensureProfiles = {
        environmentFiles = [ config.age.secrets."vpn/fsight/pw".path ];

        profiles = {
          Fsight = {
            connection = {
              id = "Fsight";
              type = "vpn";
            };
            vpn = {
              auth = "SHA256";
              ca = config.age.secrets."vpn/fsight/ca".path;
              cert = config.age.secrets."vpn/fsight/cert".path;
              cert-pass-flags = 0;
              challenge-response-flags = 2;
              cipher = "AES-128-CBC";
              compress = "yes";
              connection-type = "password-tls";
              dev = "tun";
              key = config.age.secrets."vpn/fsight/key".path;
              password-flags = 0;
              remote = "185.40.128.168:1196:udp";
              remote-cert-tls = "server";
              service-type = "org.freedesktop.NetworkManager.openvpn";
              username = "dd.voronin";
              verify-x509-name = "name:Fsight CA";
            };
            vpn-secrets.password = "$FSIGHT_PW";
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
              addr-gen-mode = "stable-privacy";
              method = "auto";
            };
          };
        };
      };
    })
  ];
}
