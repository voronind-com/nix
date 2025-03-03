{ config, pkgs, ... }:
{
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    # REF: https://github.com/transmission/transmission/blob/main/docs/Editing-Configuration-Files.md
    settings =
      let
        downloadDir = config.module.const.host.download;
      in
      {
        bind-address-ipv4 = "0.0.0.0";
        bind-address-ipv6 = "::";
        cache-size-mb = 4;
        dht-enabled = true;
        download-dir = downloadDir;
        download-queue-enabled = true;
        download-queue-size = 10;
        encryption = 1;
        incomplete-dir-enabled = false;
        message-level = 3;
        peer-limit-global = 500;
        peer-limit-per-torrent = 50;
        peer-port = 51413;
        pex-enabled = true;
        port-forwarding-enabled = false;
        preallocation = 0;
        preferred-transport = "utp";
        rename-partial-files = true;
        rpc-bind-address = "::";
        rpc-host-whitelist-enabled = false;
        rpc-password = "";
        rpc-port = 9091;
        rpc-username = "root";
        rpc-whitelist-enabled = false;
        start-added-torrents = true;
        tcp-enabled = true;
        torrent-added-verify-mode = "fast";
        trash-can-enabled = false;
        trash-original-torrent-files = true;
        utp-enabled = true;
        watch-dir = "/var/lib/transmission/watchdir/";
        watch-dir-enabled = true;
      };
  };
}
