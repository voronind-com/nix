{ ... }: {
	home.nixos.enable = true;
	user = {
		root     = true;
		voronind = true;
	};

	module = {
		builder.client.enable = true;
		package.extra = true;
		print.enable  = true;
		purpose = {
			desktop = true;
			gaming  = true;
			work    = true;
		};
		amd = {
			compute.enable = true;
			gpu.enable     = true;
			cpu = {
				enable    = true;
				powersave = true;
			};
		};
		sway.extraConfig = ''
			output "ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165" mode 1920x1080@74.986Hz transform 180 pos 780,0
			output "Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622" pos 0,1080
			workspace 1 output "ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165"
		'';
		hwmon = {
			file = "temp1_input";
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
		};
	};
}
