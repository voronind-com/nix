{ secret, ... }:
{
  networking = {
    firewall.extraCommands = ''
      # Local access.
      ip6tables -I INPUT -j ACCEPT -s ${secret.network.ula}
    '';
  };
}
