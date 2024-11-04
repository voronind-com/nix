{ ... }: {
	text = ''
		# Change file ownership to specified user id and restrict access to him.
		# Root user by default. This directory recursively by default.
		# Usage: own [USER] [FILES]
		function own() {
			local IFS=$'\n'
			local files=("''${@:2}")
			local user="''${1}"
			local group="''${1}"

			# default to current dir.
			if [ "''${files[*]}" = "" ]; then
				files=(".")
			fi

			# default to current user.
			if [ "''${user}" = "" ]; then
				user="''${UID}"
			fi

			# If not root, default to users group.
			[[ "''${user}" = 0 ]] && group="0" || group="100"

			for file in "''${files[@]}"; do
				# set ownership.
				chown "''${user}":"''${group}" -R "''${file}" &> /dev/null

				# remove access from group and others.
				chmod -077 -R "''${file}"
			done
		}

		function _complete_own() {
			_autocomplete_first_ls $(_get_users)
		}

		complete -F _complete_own own
	'';
}
