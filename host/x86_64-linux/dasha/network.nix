{ secret, ... }:
{
  networking = {
    firewall.extraCommands = ''
      # Local access.
      ip6tables -I INPUT -j ACCEPT -s ${secret.network.ula}
    '';

    networkmanager.ensureProfiles.profiles = {
      Wired = {
        connection = {
          id = "Wired";
          type = "802-3-ethernet";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "eui64";
          method = "auto";
        };
      };
    };
  };
}
