{ ... }:
{
  networking = {
    firewall.extraCommands = ''
      # Local access.
      iptables  -I INPUT -j ACCEPT -s 10.0.0.0/8
      ip6tables -I INPUT -j ACCEPT -s fd09:8d46:0b26::/48
    '';
  };
}
