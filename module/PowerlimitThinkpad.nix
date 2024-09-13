# ThinkPad charge limits.
{ pkgs, lib, config, ... } @args: with lib; let
	cfg = config.module.powerlimit.thinkpad;

	controlFileMin = "/sys/class/power_supply/BAT0/charge_control_start_threshold";
	controlFileMax = "/sys/class/power_supply/BAT0/charge_control_end_threshold";

	script = pkgs.writeShellScriptBin "powerlimit" ''
		function toggle() {
			if status; then
				echo ${toString cfg.offMax} > ${controlFileMax}
				echo ${toString cfg.offMin} > ${controlFileMin}
			else
				echo ${toString cfg.onMin} > ${controlFileMin}
				echo ${toString cfg.onMax} > ${controlFileMax}
			fi

			pkill -RTMIN+6 waybar
			true
		}

		function widget() {
			status && printf '​' || printf ''
		}

		function status() {
			local current=$(cat ${controlFileMax})
			local enabled="${toString cfg.onMax}"

			[[ "''${current}" = "''${enabled}" ]]
		}

		''${@}
	'';
in {
	options = {
		module.powerlimit.thinkpad = {
			enable = mkEnableOption "Powerlimit Service";
			onMin = mkOption {
				default = 40;
				type    = types.int;
			};
			onMax = mkOption {
				default = 80;
				type    = types.int;
			};
			offMin = mkOption {
				default = 90;
				type    = types.int;
			};
			offMax = mkOption {
				default = 95;
				type    = types.int;
			};
		};
	};

	config = mkIf cfg.enable {
		environment.systemPackages = [ script ];
		systemd = {
			services.powerlimit = {
				description = "Limit battery charge.";
				enable      = true;
				wantedBy    = [ "multi-user.target" ];
				serviceConfig = {
					Type = "simple";
					RemainAfterExit = "yes";
					ExecStart = "${getExe pkgs.bash} -c 'echo ${toString cfg.onMin} > ${controlFileMin}; echo ${toString cfg.onMax} > ${controlFileMax};'";
					ExecStop  = "${getExe pkgs.bash} -c 'echo ${toString cfg.offMax} > ${controlFileMax}; echo ${toString cfg.offMin} > ${controlFileMin};'";
				};
			};

			# HACK: Allow user access.
			tmpfiles.rules = [
				"z ${controlFileMax} 0777 - - - -"
				"z ${controlFileMin} 0777 - - - -"
			];
		};
	};
}
