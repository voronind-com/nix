{
	lib,
	config,
	pkgs,
	util,
	...
}: let
	cfg = config.module.powersave;

	script = pkgs.writeShellScriptBin "powersave" (util.trimTabs ''
		function toggle() {
			if status; then
				echo ${cfg.cpu.boost.disableCmd} > ${cfg.cpu.boost.controlFile}
			else
				echo ${cfg.cpu.boost.enableCmd} > ${cfg.cpu.boost.controlFile}
			fi

			pkill -RTMIN+5 waybar
			true
		}

		function widget() {
			status && printf '​' || printf '󰓅'
		}

		function status() {
			local current=$(cat ${cfg.cpu.boost.controlFile})
			local enabled="${cfg.cpu.boost.enableCmd}"

			[[ "''${current}" = "''${enabled}" ]]
		}

		''${@}
	'');
in {
	options.module.powersave = {
		enable = lib.mkEnableOption "the powersave";
		cpu.boost = {
			disableCmd = lib.mkOption {
				default = null;
				type    = lib.types.str;
			};
			enableCmd = lib.mkOption {
				default = null;
				type    = lib.types.str;
			};
			controlFile = lib.mkOption {
				default = null;
				type    = lib.types.str;
			};
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [
			script
		];
		systemd = {
			services.powersave-cpu = {
				enable = true;
				description = "disable CPU Boost";
				wantedBy = [
					"multi-user.target"
				];
				serviceConfig = {
					Type = "simple";
					RemainAfterExit = "yes";
					ExecStart = "${lib.getExe pkgs.bash} -c 'echo ${cfg.cpu.boost.enableCmd} > ${cfg.cpu.boost.controlFile}'";
					ExecStop  = "${lib.getExe pkgs.bash} -c 'echo ${cfg.cpu.boost.disableCmd} > ${cfg.cpu.boost.controlFile}'";
				};
			};

			# HACK: Allow user access.
			tmpfiles.rules = [
				"z ${cfg.cpu.boost.controlFile} 0777 - - - -"
			];
		};
	};
}
