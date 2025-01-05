{ ... }:
{
  networking = {
    firewall.extraCommands = ''
      # Local access.
      ip6tables -I INPUT -j ACCEPT -s fd09:8d46:0b26::/48
    '';
  };
}
