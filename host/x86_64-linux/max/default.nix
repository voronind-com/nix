# SEE: https://github.com/Sabrina-Fox/WM2-Help
{
	__findFile,
	pkgs,
	...
}: {
	home.nixos.enable = true;
	user = {
		root     = true;
		voronind = true;
	};

	module = {
		builder.client.enable = true;
		package.extra = true;
		print.enable  = true;
		syncthing.enable = true;
		purpose = {
			creative = true;
			gaming   = true;
			laptop   = true;
			work     = true;
		};
		display = {
			primary = "eDP-1";
		};
		sway.extraConfig = [
			"output eDP-1 scale 1.75"
			"bindsym $sysmod+0 exec /run/wrappers/bin/wm2fc 0"
			"bindsym $sysmod+9 exec /run/wrappers/bin/wm2fc a"
			"bindsym $sysmod+1 exec /run/wrappers/bin/wm2fc 23"
			"bindsym $sysmod+2 exec /run/wrappers/bin/wm2fc 46"
			"bindsym $sysmod+3 exec /run/wrappers/bin/wm2fc 69"
			"bindsym $sysmod+4 exec /run/wrappers/bin/wm2fc 92"
			"bindsym $sysmod+5 exec /run/wrappers/bin/wm2fc 115"
			"bindsym $sysmod+6 exec /run/wrappers/bin/wm2fc 138"
			"bindsym $sysmod+7 exec /run/wrappers/bin/wm2fc 161"
			"bindsym $sysmod+8 exec /run/wrappers/bin/wm2fc 184"
		];
		hwmon = {
			file = "temp1_input";
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
		};
		amd = {
			gpu.enable = true;
			cpu = {
				enable    = true;
				powersave = true;
			};
		};
	};
}
