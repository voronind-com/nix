{
	config,
	inputs,
	lib,
	pkgsMaster,
	...
}: let
	cfg = config.module.dpi;
in {
	disabledModules = [ "services/networking/zapret.nix" ];
	imports = [ "${inputs.nixpkgsMaster}/nixos/modules/services/networking/zapret.nix" ];

	config = lib.mkIf cfg.bypass.enable {
		services.zapret = {
			inherit (cfg.bypass) params;
			enable  = true;
			package = pkgsMaster.zapret;
			httpMode    = "full";
			httpSupport = true;
			udpSupport  = true;
			udpPorts = [
				"50000:50099"
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
	};
}
