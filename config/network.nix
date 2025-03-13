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
  ];
}
