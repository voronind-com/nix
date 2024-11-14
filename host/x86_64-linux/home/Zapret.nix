{
	inputs,
	pkgsMaster,
	...
}: {
	disabledModules = [ "services/networking/zapret.nix" ];
	imports = [ "${inputs.nixpkgsMaster}/nixos/modules/services/networking/zapret.nix" ];

	# TODO: Single place.
	services.zapret = {
		enable  = true;
		package = pkgsMaster.zapret;
		params = [
			"--dpi-desync=fake,disorder2"
			"--dpi-desync-ttl=1"
			"--dpi-desync-autottl=2"
		];
		whitelist = [
			"youtube.com"
			"googlevideo.com"
			"ytimg.com"
			"youtu.be"
			"rutracker.org"
			"rutracker.cc"
			"rutrk.org"
			"t-ru.org"
			"medium.com"
			"dis.gd"
			"discord.co"
			"discord.com"
			"discord.dev"
			"discord.gg"
			"discord.gift"
			"discord.media"
			"discord.new"
			"discordapp.com"
			"discordapp.net"
			"discordcdn.com"
			"discordstatus.com"
		];
	};
}
