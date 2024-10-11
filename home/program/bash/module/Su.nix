{ ... }: {
	text = ''
		# Su shortcut for lazy me.
		# Root by default.
		# Usage: s [USER]
		function s() {
			su - ''${1}
		}
		alias su="SHELL_NAME=su su"

		# Run something as root. Runs command as a current user if su is not available.
		# Usage: sudo <COMMAND>
		function sudo() {
			if command -v su &> /dev/null; then
				su -c "$(echo ''${*} | tr '\n' ' ')"
			else
				''${*}
			fi
		}

		# Run something as current user. If fails, try to run with sudo.
		# Usage: trysudo <COMMAND>
		function trysudo() {
			''${*} || sudo ''${*}
		}

		function _complete_s() {
			_autocomplete_first $(_get_users)
		}

		complete -F _complete_s s
		complete -F _autocomplete_nested sudo trysudo
	'';
}
