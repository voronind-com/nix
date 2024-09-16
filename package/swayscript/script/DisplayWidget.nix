{ ... }: {
	text = ''
		function monitor() {
			toggle() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .power')

				if ''${state}; then
					swaymsg "output \"''${output}\" power off"
				else
					swaymsg "output \"''${output}\" power on"
				fi

				pkill -RTMIN+4 waybar
			}
			_sway_iterate_sockets toggle
		}

		function gaming() {
			toggle() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .adaptive_sync_status')

				if [[ "''${state}" = "disabled" ]]; then
					swaymsg "output \"''${output}\" adaptive_sync on"
				else
					swaymsg "output \"''${output}\" adaptive_sync off"
				fi

				pkill -RTMIN+4 waybar
			}
			_sway_iterate_sockets toggle
		}

		function dnd() {
			toggle() {
				local state=$(makoctl mode)

				if [[ "''${state}" = "dnd" ]]; then
					makoctl mode -s default
				else
					makoctl mode -s dnd
				fi

				pkill -RTMIN+4 waybar
			}
			_sway_iterate_sockets toggle
		}

		# Waybar output.
		function displaywidget() {
			local __monitor=$(_monitor)
			local __gaming=$(_gaming)
			local __recording=$(_recording)
			local __dnd=$(_dnd)
			local class=""

			if [[ "''${__monitor}" = "Y" ]] || [[ "''${__gaming}" = "Y" ]] || [[ "''${__recording}" = "Y" ]] || [[ "''${__dnd}" = "Y" ]]; then
				class="modified"
			fi

			printf "{\"text\": \"󰍹\", \"tooltip\": \"DND: ''${__dnd} / Monitor: ''${__monitor} / Gaming: ''${__gaming} / Recording: ''${__recording}\", \"class\": \"''${class}\"}\n"
		}

		function _monitor() {
			local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .power'))

			for state in "''${outputs[@]}"; do
				''${state} || {
					printf Y
					return 1
				}
			done

			printf n
			return 0
		}

		function _recording() {
			[[ "$(ps cax | rg wf-recorder)" = "" ]] && printf n || printf Y
		}

		function _dnd() {
			[[ "$(makoctl mode)" = "dnd" ]] && printf Y || printf n
		}

		function _gaming() {
			local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .adaptive_sync_status'))

			for state in "''${outputs[@]}"; do
				[[ "''${state}" = "disabled" ]] || {
					printf Y
					return 1
				}
			done

			printf n
			return 0
		}
	'';
}
