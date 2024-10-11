{ secret, ... }:
{
  users.users.root.openssh.authorizedKeys.keys = secret.ssh.trustedKeys;

  services.openssh = {
    enable = true;
    allowSFTP = true;
    # openFirewall = false;
    ports = [ 22143 ];
    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = 22143;
      }
    ];
    settings = {
      AllowUsers = [
        "root"
        "nixbuilder"
      ];
      LoginGraceTime = "1m";
      # MaxAuthTries    = 1;
      MaxSessions = 10;
      PermitRootLogin = "prohibit-password";
      StrictModes = false;

      UseDns = false;
      UsePAM = true;

      GSSAPIAuthentication = false;
      HostbasedAuthentication = false;
      KbdInteractiveAuthentication = false;
      KerberosAuthentication = false;
      PasswordAuthentication = false;
      PermitEmptyPasswords = false;
      PubkeyAuthentication = true;
    };
  };
}
