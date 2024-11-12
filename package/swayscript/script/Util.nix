{
	__findFile,
	pkgs,
	...
}: {
	text = ''
		# Find currently active SWAYSOCK paths.
		function _sway_find_sockets() {
			ls /run/user/''${UID}/sway-ipc.''${UID}.*.sock
		}

		function _sway_iterate_sockets() {
			local IFS=$'\n'
			for socket in $(_sway_find_sockets); do
				SWAYSOCK="''${socket}" ''${1}
			done
		}

		function _notify_short() {
			${pkgs.pipewire}/bin/pw-cat -p ${<static/Short.ogg>} &
		}

		function _notify_long() {
			${pkgs.pipewire}/bin/pw-cat -p ${<static/Long.ogg>} &
		}
	'';
}
