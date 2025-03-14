function monitor() {
	toggle() {
		local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
		local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .power')

		if ${state}; then
			swaymsg "output \"${output}\" power off"
			notify_long
		else
			swaymsg "output \"${output}\" power on"
			notify_short
		fi

		pkill -RTMIN+4 waybar
	}
	_sway_iterate_sockets toggle
}

function monitors() {
	toggle() {
		local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
		local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .power')

		if ${state}; then
			swaymsg "output * power off"
			notify_long
		else
			swaymsg "output * power on"
			notify_short
		fi

		pkill -RTMIN+4 waybar
	}
	_sway_iterate_sockets toggle
}

function monitorreset() {
	swaymsg 'output * power on'
	pkill -RTMIN+4 waybar
}

function gaming() {
	toggle() {
		local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
		local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .adaptive_sync_status')

		if [[ ${state} == "disabled" ]]; then
			swaymsg "output \"${output}\" adaptive_sync on"
			notify_short
		else
			swaymsg "output \"${output}\" adaptive_sync off"
			notify_long
		fi

		pkill -RTMIN+4 waybar
	}
	_sway_iterate_sockets toggle
}

function gamingreset() {
	swaymsg 'output * adaptive_sync off'
	pkill -RTMIN+4 waybar
}

function dnd() {
	toggle() {
		local state=$(makoctl mode)

		if [[ ${state} == "dnd" ]]; then
			makoctl mode -s default
			notify_long
		else
			notify_short
			makoctl mode -s dnd
		fi

		pkill -RTMIN+4 waybar
	}
	_sway_iterate_sockets toggle
}

# Reset the state of everything.
function displayreset() {
	notify_long
	[[ "$(monitorstate)" == "Y" ]] && monitorreset
	[[ "$(gamingstate)" == "Y" ]] && gamingreset
	[[ "$(recordingstate)" == "Y" ]] && pkill wf-recorder
	[[ "$(dndstate)" == "Y" ]] && dnd
	true
}

# Waybar output.
function displaywidget() {
	local _monitorstate=$(monitorstate)
	local _gamingstate=$(gamingstate)
	local _recordingstate=$(recordingstate)
	local _dndstate=$(dndstate)
	local class=""
	local icon="" # 󰈈󰫢󱝂󱡄󰳊󰋑

	local ic_rec="󰻂"
	local ic_dnd="󰂛"
	local ic_power="󰔢"
	local ic_gaming="󰊴"

	if [ "${_recordingstate}" == "Y" ]; then
		class="rec"
		icon="${ic_rec}"
	elif [ "${_dndstate}" == "Y" ]; then
		class="dnd"
		icon="${ic_dnd}"
	elif [ "${_monitorstate}" == "Y" ]; then
		class="power"
		icon="${ic_power}"
	elif [ "${_gamingstate}" == "Y" ]; then
		class="gaming"
		icon="${ic_gaming}"
	fi

	printf "%s" "{\"text\": \"${icon}\", \"tooltip\": \"${ic_rec} ${_recordingstate}\\t${ic_dnd} ${_dndstate}\\n${ic_power} ${_monitorstate}\\t${ic_gaming} ${_gamingstate}\", \"class\": \"${class}\"}\n"
}

function monitorstate() {
	local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .power'))

	for state in "${outputs[@]}"; do
		${state} || {
			printf "%s" Y
			return 1
		}
	done

	printf "%s" n
	return 0
}

function recordingstate() {
	[[ "$(ps cax | rg wf-recorder)" == "" ]] && printf "%s" n || printf "%s" Y
}

function dndstate() {
	[[ "$(makoctl mode)" == "dnd" ]] && printf "%s" Y || printf "%s" n
}

function gamingstate() {
	local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .adaptive_sync_status'))

	for state in "${outputs[@]}"; do
		[[ ${state} == "disabled" ]] || {
			printf "%s" Y
			return 1
		}
	done

	printf "%s" n
	return 0
}
