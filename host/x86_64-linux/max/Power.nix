{
	__findFile,
	pkgs,
	...
}: let
	tbase = 45;
	wm2fc = pkgs.callPackage <package/wm2fc> {};
in {
	# hardware.cpu.amd.ryzen-smu.enable = true;

	environment.systemPackages = with pkgs; [
		# SRC: https://github.com/FlyGoat/RyzenAdj
		# ./ryzenadj --stapm-limit=45000 --fast-limit=45000 --slow-limit=45000 --tctl-temp=90
		# ryzenAdj --info
		# radg [TEMP]
		ryzenadj

		# SRC: https://github.com/nbfc-linux/nbfc-linux
		nbfc-linux

		wm2fc
	];

	systemd.services.radj = {
		enable = true;
		description = "Ryzen Adj temperature limiter.";
		serviceConfig.Type = "simple";
		wantedBy = [ "multi-user.target" ];
		path = with pkgs; [
			coreutils
			ryzenadj
		];
		script = ''
			ryzenadj --tctl-temp=${toString (tbase+5)}
			while true; do
				sleep 60
				ryzenadj --tctl-temp=${toString (tbase+5)} &> /dev/null
			done
		'';
	};

	systemd.services.fan = {
		enable = true;
		description = "The fan control";
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			ExecStop = "${wm2fc}/bin/wm2fc a";
			Type = "simple";
		};
		path = with pkgs; [
			coreutils
			wm2fc
		];
		script = let
			templimit = add: if (tbase+add) > 80 then
				"80000"
			else
				"${toString (tbase+add)}000";
		in ''
			old=0
			while true; do
				temp=$(cat /sys/devices/pci0000\:00/0000\:00\:18.3/hwmon/*/temp1_input)
				value=0

				if   [ $temp -gt ${templimit 35} ]
				then value=184
				elif [ $temp -gt ${templimit 30} ]
				then value=161
				elif [ $temp -gt ${templimit 25} ]
				then value=138
				elif [ $temp -gt ${templimit 20} ]
				then value=115
				elif [ $temp -gt ${templimit 15} ]
				then value=92
				elif [ $temp -gt ${templimit 10} ]
				then value=69
				elif [ $temp -gt ${templimit 5} ]
				then value=46
				elif [ $temp -gt ${templimit 0} ]
				then value=23
				fi

				if [[ $old != $value ]]; then
					old=$value
					printf "%s: %d\n" "New fan speed" $value
				fi

				wm2fc $value &> /dev/null
				sleep 2
			done
		'';
	};

	# security.wrappers.wm2fc = {
	# 	source = "${wm2fc}/bin/wm2fc";
	# 	owner  = "root";
	# 	group  = "root";
	# 	setuid = true;
	# 	permissions = "u+rx,g+x,o+x";
	# };
}
