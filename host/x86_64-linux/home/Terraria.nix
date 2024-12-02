{
	pkgs,
	...
}: {
	# NOTE: Admin with `tmux -S /var/lib/terraria/terraria.sock attach-session -t 0`
	environment.systemPackages = with pkgs; [ tmux ];

	services.terraria = {
		enable = true;
		autoCreatedWorldSize = "large";
		messageOfTheDay = "<3";
		maxPlayers   = 4;
		noUPnP       = false;
		openFirewall = false;
		password     = "mishadima143";
		port         = 22777;
		secure       = false;
		worldPath    = "/var/lib/terraria/.local/share/Terraria/Worlds/World.wld";
	};
}
