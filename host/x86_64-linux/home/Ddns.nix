{ ... }: {
	services.cloudflare-dyndns = {
		enable        = true;
		apiTokenFile  = "/storage/hot/container/ddns/data/token";
		deleteMissing = false;
		ipv4          = true;
		ipv6          = true;
		proxied       = false;
		domains = let
			domain = "voronind.com";
		in [
			domain
		] ++ map (sub: "${sub}.${domain}") [
			"cloud"
			"git"
			"mail"
			"office"
			"paste"
			"vpn"
		];
	};
}
