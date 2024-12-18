function notify() {
	[[ "$(dndstate)" == "Y" ]] && return
	@pipewire@/bin/pw-cat -p @notificationogg@ &
}

function notify_short() {
	[[ "$(dndstate)" == "Y" ]] && return
	@pipewire@/bin/pw-cat -p @shortogg@ &
}

function notify_long() {
	[[ "$(dndstate)" == "Y" ]] && return
	@pipewire@/bin/pw-cat -p @longogg@ &
}
