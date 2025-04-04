{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.syncthing;
in
{
  config = lib.mkIf cfg.enable {
    # CLI tools.
    environment.systemPackages = with pkgs; [ syncthing ];

    # Access at sync.lan.
    networking.hosts = {
      "::1" = [ "sync.local" ];
    };
    services.nginx.enable = true;
    services.nginx.virtualHosts."sync.local".extraConfig = ''
      location / {
        allow ::1;
        deny all;
        proxy_pass http://[::1]:8384;
      }
    '';

    services.syncthing = {
      inherit (cfg)
        enable
        dataDir
        user
        group
        ;
      guiAddress = "[::1]:8384";
      openDefaultPorts = false;
      systemService = true;
      settings =
        let
          myDevices = {
            "desktop".id = "767Z675-SOCY4FL-JNYEBB6-5E2RG5O-XTZR6OP-BGOBZ7G-XVRLMD6-DQEB2AT";
            "home".id = "L5A5IPE-2FPJPHP-RJRV2PV-BLMLC3F-QPHSCUQ-4U3NM2I-AFPOE2A-HOPQZQF";
            "max".id = "3E3N4G4-SZ7LQXE-WQQZX7N-KFXEQKM-7VVN6QP-OMB5356-ICNXUZY-TTLEKAR";
            "phone".id = "6RO5JXW-2XO4S3E-VCDAHPD-4ADK6LL-HQGMZHU-GD6DE2O-6KNHWXJ-BCSBGQ7";
          };
          dashaDevices = {
            "dasha".id = "VNRA5VH-LWNPVV4-Y2RF7FJ-446FHRQ-PET7Q4R-D3H5RT3-AUNARH5-5XYB3AT";
            "dashaphone".id = "QKGXSZC-HGAA6S5-RJJAT5Z-UPUGDAA-3GXEO6C-WHKMBUD-ESKQPZE-TZFNYA6";
            "thinkpad".id = "Y6YY3ZH-YXQ2RM3-Q642WN6-N6WO3VV-S65NVTR-RF3GHXD-DR3VMRU-XHE3KQU";
          };
        in
        lib.recursiveUpdate cfg.settings {
          devices = myDevices // dashaDevices;
          folders =
            let
              allMyDevices = lib.mapAttrsToList (n: v: n) myDevices;
              allDashaDevices = lib.mapAttrsToList (n: v: n) dashaDevices;
            in
            lib.filterAttrs (n: v: builtins.elem config.networking.hostName v.devices) {
              "save" = {
                path = "${cfg.dataDir}/save";
                devices = [
                  "desktop"
                  "home"
                  "max"
                ];
              };
              "photo" = {
                path = "${cfg.dataDir}/photo";
                devices = [
                  "dashaphone"
                  "home"
                  "phone"
                ];
              };
              "tmp" = {
                path = "${cfg.dataDir}/tmp";
                devices = allMyDevices;
              };
              "document" = {
                path = "${cfg.dataDir}/document";
                devices = allMyDevices;
              };
              "dima" = {
                path = "${cfg.dataDir}/dima";
                devices = allMyDevices ++ allDashaDevices;
              };
              "dasha" = {
                path = "${cfg.dataDir}/dasha";
                devices = [ "home" ] ++ allDashaDevices;
              };
            };
        };
    };
  };
}
