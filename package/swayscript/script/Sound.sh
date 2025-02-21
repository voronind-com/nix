function sound_output_cycle() {
	notify_short
	local IFS=$'\n'
	local current=$(pactl get-default-sink)
	local all=($(pactl list short sinks | cut -f2))
	local i_current=$(_index_of ${current} ${all[@]})
	local i_total=${#all[@]}
	((i_total--))
	local i_target=0

	[[ ${i_current} -lt ${i_total} ]] && i_target=$((i_current + 1))

	pactl set-default-sink ${all[${i_target}]}
}

function sound_input_cycle() {
	notify_short
	local IFS=$'\n'
	local current=$(pactl get-default-source)
	local all=($(pactl list short sources | cut -f2 | rg input))
	local i_current=$(_index_of ${current} ${all[@]})
	local i_total=${#all[@]}
	((i_total--))
	local i_target=0

	[[ ${i_current} -lt ${i_total} ]] && i_target=$((i_current + 1))

	pactl set-default-source ${all[${i_target}]}
}
