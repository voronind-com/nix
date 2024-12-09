{ ... }: {
	security.pam.loginLimits = [
		{
			domain = "*";
			item   = "nofile";
			type   = "soft";
			value  = "99999";
		}
		{
			domain = "@users";
			item   = "rtprio";
			type   = "-";
			value  = 1;
		}
	];
}
