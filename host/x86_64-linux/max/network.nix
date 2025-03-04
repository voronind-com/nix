{ config, ... }:
{
  networking = {
    firewall.extraCommands = ''
      # Local access.
      ip6tables -I INPUT -j ACCEPT -s ${config.module.network.ula}
    '';
  };
}
