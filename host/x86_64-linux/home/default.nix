{ ... }: {
	home.nixos.enable = true;
	user = {
		root.enable     = true;
		voronind.enable = true;
	};

	module = {
		builder.server.enable = true;
		desktop.sway.enable   = true;
		kernel.enable         = true;
		keyd.enable           = true;
		amd = {
			cpu.enable = true;
			gpu.enable = true;
		};
		ftpd = {
			enable  = true;
			storage = "/storage/hot/ftp";
		};
		hwmon = {
			file = "temp1_input";
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
		};
		package = {
			common.enable  = true;
			core.enable    = true;
			desktop.enable = true;
		};
		zapret = {
			enable = true;
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
	};
}
