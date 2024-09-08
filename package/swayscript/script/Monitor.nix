{ ... }: {
	text = ''
		# Toggle monitors.
		function montoggle() {
			toggle() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .power')

				if ''${state}; then
					swaymsg "output \"''${output}\" power off"
				else
					swaymsg "output \"''${output}\" power on"
				fi
			}
			_sway_iterate_sockets toggle
		}

		# Toggle gaming.
		function gamingtoggle() {
			toggle() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .adaptive_sync_status')

				if [[ "''${state}" = "disabled" ]]; then
					swaymsg "output \"''${output}\" adaptive_sync on"
				else
					swaymsg "output \"''${output}\" adaptive_sync off"
				fi
			}
			_sway_iterate_sockets toggle
		}

		# Waybar output.
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
					printf off
					return 1
				}
			done

			printf on
			return 0
		}

		function _recording() {
			[[ "$(ps cax | rg wf-recorder)" = "" ]] && printf off || printf on
		}

		function _gamingstate() {
			local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .adaptive_sync_status'))

			for state in "''${outputs[@]}"; do
				[[ "''${state}" = "disabled" ]] || {
					printf on
					return 1
				}
			done

			printf off
			return 0
		}
	'';
}
