{
  container,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.vpn;

  wireguardPeers =
    let
      mkPeer = name: ip: PublicKey: {
        inherit PublicKey;
        PresharedKeyFile = "/var/lib/wireguard/preshared/${name}";
        AllowedIPs = [ "${ip}/32" ];
      };
    in
    [
      (mkPeer "dashaphone" "10.1.1.3" "O/3y8+QKEY8UoLVlmbc8xdhs248L4wtQcl1MsBBfoQo=")
      (mkPeer "laptop" "10.1.1.9" "xxoCNPSB86zs8L8p+wXhqaIwpNDkiZu1Yjv8sj8XhgY=")
      (mkPeer "phone" "10.1.1.5" "bFmFisMqbDpIrAg3o/GiRl9XhceZEVnZtkegZDTL4yg=")
      (mkPeer "tablet" "10.1.1.6" "BdslswVc9OgUpEhJd0sugDBmYw44DiS0FbUPT5EjOG0=")
      (mkPeer "work" "10.1.1.2" "Pk0AASSInKO9O8RaQEmm1uNrl0cwWTJDcT8rLn7PSA0=")
    ];
in
{
  options = {
    container.module.vpn = {
      enable = mkEnableOption "Vpn server.";
      address = mkOption {
        default = "10.1.0.23";
        type = types.str;
      };
      port = mkOption {
        default = 51820;
        type = types.int;
      };
      storage = mkOption {
        default = "${config.container.storage}/vpn";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = container.mkContainerDir cfg [
      "data"
      "data/preshared"
    ];

    containers.vpn = container.mkContainer cfg {
      bindMounts = {
        "/var/lib/wireguard" = {
          hostPath = "${cfg.storage}/data";
          isReadOnly = false;
        };
      };

      config =
        { ... }:
        container.mkContainerConfig cfg {
          boot.kernel.sysctl = {
            "net.ipv4.conf.all.src_valid_mark" = 1;
            "net.ipv4.ip_forward" = 1;
          };

          environment.systemPackages = with pkgs; [ wireguard-tools ];
          networking.useNetworkd = true;
          systemd.network = {
            enable = true;
            netdevs = {
              "50-wg0" = {
                netdevConfig = {
                  Kind = "wireguard";
                  MTUBytes = "1300";
                  Name = "wg0";
                };
                wireguardConfig = {
                  PrivateKeyFile = "/var/lib/wireguard/privkey";
                  ListenPort = cfg.port;
                };
                inherit wireguardPeers;
              };
            };

            networks.wg0 = {
              matchConfig.Name = "wg0";
              address = [ "10.1.1.0/24" ];
              networkConfig = {
                IPv4Forwarding = "yes";
                IPMasquerade = "ipv4";
              };
            };
          };
        };
    };
  };
}
