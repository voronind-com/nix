{ ... }: {
	text = ''
		# Enable monitors.
		function monon() {
			on() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				swaymsg "output \"''${output}\" power on"
			}
			_sway_iterate_sockets on
		}

		# Disable monitors.
		function monoff() {
			off() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				swaymsg "output \"''${output}\" power off"
			}
			_sway_iterate_sockets off
		}

		# Toggle monitors.
		function montoggle() {
			if [[ "$(_monstate)" = "on" ]]; then
				monoff
			else
				monon
			fi
		}

		function monbar() {
			local __monstate=$(_monstate)
			local __gamingstate=$(_gamingstate)
			local __recording=$(_recording)
			local class=""

			if [[ "''${__monstate}" = "off" ]] || [[ "''${__gamingstate}" = "on" ]] || [[ "''${__recording}" = "on" ]]; then
				class="modified"
			fi

			printf "{\"text\": \"󰍹\", \"tooltip\": \"Monitor: ''${__monstate^} / Gaming: ''${__gamingstate^} / Recording: ''${__recording^}\", \"class\": \"''${class}\"}\n"
		}

		function _monstate() {
			local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .power'))

			for state in "''${outputs[@]}"; do
				''${state} || {
					echo off
					return 1
				}
			done

			echo on
			return 0
		}

		function _recording() {
			[[ "$(ps cax | rg wf-recorder)" = "" ]] && echo off || echo on
		}

		# Enable Gaming.
		function gamingon() {
			on() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				swaymsg "output \"''${output}\" adaptive_sync on"
			}
			_sway_iterate_sockets on
		}

		# Disable Gaming.
		function gamingoff() {
			off() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				swaymsg "output \"''${output}\" adaptive_sync off"
			}
			_sway_iterate_sockets off
		}

		# Toggle gaming.
		function gamingtoggle() {
			if [[ "$(_gamingstate)" = "on" ]]; then
				gamingoff
			else
				gamingon
			fi
		}

		function _gamingstate() {
			local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .adaptive_sync_status'))

			for state in "''${outputs[@]}"; do
				[[ "''${state}" = "disabled" ]] || {
					echo on
					return 1
				}
			done

			echo off
			return 0
		}
	'';
}
