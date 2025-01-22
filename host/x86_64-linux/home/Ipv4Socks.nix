# Use `nixos-container login ipv4` as root and empty pw.
{ __findFile, lib, ... }:
{
  networking.nat = {
    enable = true;
    externalInterface = "enp8s0";
    internalInterfaces = [ "ve-+" ];
  };

  containers.ipv4 = {
    autoStart = true;
    enableTun = true;
    privateNetwork = true;
    hostAddress = "188.242.247.132";
    localAddress = "10.1.0.3";

    config =
      { ... }:
      {
        boot.kernel.sysctl = {
          "net.ipv6.conf.all.disable_ipv6" = 1;
          "net.ipv6.conf.default.disable_ipv6" = 1;
        };

        networking.firewall.extraCommands = ''
          iptables -I INPUT -j ACCEPT -s 10.0.0.0/24
        '';

        services.microsocks = {
          enable = true;
          disableLogging = true;
          ip = "10.1.0.3";
          port = 1080;
        };

        boot.isContainer = true;
        system.stateVersion = "24.11";
        networking = {
          useHostResolvConf = lib.mkForce false;
          nameservers = [
            "1.1.1.1"
            "8.8.8.8"
          ];
        };
      };
  };
}
