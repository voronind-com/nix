{
	secret,
	...
}: {
	users.users.root.openssh.authorizedKeys.keys = secret.ssh.trustedKeys;
	services.openssh = {
		enable = true;
		allowSFTP = true;
		ports = [
			22143
		];
		listenAddresses = [{
			addr = "0.0.0.0";
			port = 22143;
		}];
		settings = {
			GSSAPIAuthentication         = false;
			HostbasedAuthentication      = false;
			KbdInteractiveAuthentication = false;
			KerberosAuthentication       = false;
			LoginGraceTime               = "1m";
			MaxSessions                  = 10;
			PasswordAuthentication       = false;
			PermitEmptyPasswords         = false;
			PermitRootLogin              = "prohibit-password";
			PubkeyAuthentication         = true;
			StrictModes                  = false;
			UseDns                       = false;
			UsePAM                       = true;
			AllowUsers = [
				"root"
				"nixbuilder"
			];
		};
	};
}
