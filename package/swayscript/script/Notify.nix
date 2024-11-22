{
	__findFile,
	pkgs,
	...
}: {
	text = ''
		function notify() {
			[[ "''$(dndstate)" = "Y" ]] && return
			${pkgs.pipewire}/bin/pw-cat -p ${<static/Notification.ogg>} &
		}

		function notify_short() {
			[[ "''$(dndstate)" = "Y" ]] && return
			${pkgs.pipewire}/bin/pw-cat -p ${<static/Short.ogg>} &
		}

		function notify_long() {
			[[ "''$(dndstate)" = "Y" ]] && return
			${pkgs.pipewire}/bin/pw-cat -p ${<static/Long.ogg>} &
		}
	'';
}
