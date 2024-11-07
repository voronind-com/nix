{ ... }: {
	home.nixos.enable = true;
	user = {
		root.enable     = true;
		voronind.enable = true;
	};

	module = {
		autoupdate.enable     = true;
		builder.client.enable = true;
		distrobox.enable      = true;
		keyd.enable           = true;
		ollama.enable         = true;
		print.enable          = true;
		virtmanager.enable    = true;
		amd = {
			compute.enable = true;
			gpu.enable     = true;
			cpu = {
				enable    = true;
				powersave = true;
			};
		};
		sway = {
			enable = true;
			extraConfig = ''
				output "ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165" mode 1920x1080@74.986Hz transform 180 pos 780,0
				output "Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622" pos 0,1080
				workspace 1 output "ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165"
			'';
		};
		docker = {
			enable    = true;
			autostart = false;
			rootless  = false;
		};
		hwmon = {
			file = "temp1_input";
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
		};
		kernel = {
			enable = true;
			latest = true;
		};
		package = {
			common.enable   = true;
			core.enable     = true;
			creative.enable = true;
			desktop.enable  = true;
			dev.enable      = true;
			extra.enable    = true;
			gaming.enable   = true;
		};
	};
}
