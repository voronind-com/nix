{ lib, config, pkgs, ... }: with lib; let
	cfg = config.module.powersave;

	script = pkgs.writeShellScriptBin "powersave" ''
		function toggle() {
			if status; then
				echo ${cfg.cpu.boost.disableCmd} > ${cfg.cpu.boost.controlFile}
			else
				echo ${cfg.cpu.boost.enableCmd} > ${cfg.cpu.boost.controlFile}
			fi

			pkill -RTMIN+5 waybar
			true
		}

		function waybar() {
			status || echo -n "󰓅"
		}

		function status() {
			local current=$(cat ${cfg.cpu.boost.controlFile})
			local enabled="${cfg.cpu.boost.enableCmd}"

			[[ "''${current}" = "''${enabled}" ]]
		}

		''${@}
	'';
in {
	options = {
		module.powersave = {
			enable = mkEnableOption "Powersave";
			cpu.boost = mkOption {
				default = {};
				type = types.submodule {
					options = {
						disableCmd = mkOption {
							default = null;
							type    = types.str;
						};
						enableCmd = mkOption {
							default = null;
							type    = types.str;
						};
						controlFile = mkOption {
							default = null;
							type    = types.str;
						};
					};
				};
			};
		};
	};

	config = mkIf cfg.enable {
		environment.systemPackages = [ script ];
		systemd = {
			services.powersave-cpu = {
				description = "Disable CPU Boost";
				enable      = true;
				wantedBy    = [ "multi-user.target" ];
				serviceConfig = {
					Type = "simple";
					RemainAfterExit = "yes";
					ExecStart = "${getExe pkgs.bash} -c 'echo ${cfg.cpu.boost.enableCmd} > ${cfg.cpu.boost.controlFile}'";
					ExecStop  = "${getExe pkgs.bash} -c 'echo ${cfg.cpu.boost.disableCmd} > ${cfg.cpu.boost.controlFile}'";
				};
			};

			# HACK: Allow user access.
			tmpfiles.rules = [ "z ${cfg.cpu.boost.controlFile} 0777 - - - -" ];
		};
	};
}
