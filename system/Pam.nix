{ ... }: {
	security.pam.loginLimits = [
		{
			domain = "*";
			item   = "nofile";
			type   = "soft";
			value  = "999999999";
		}
		{
			domain = "@users";
			item   = "rtprio";
			type   = "-";
			value  = 1;
		}
	];
}
