{ ... }: {
	text = ''
		# Show only physical drives info.
		function pdf() {
			df --si | sed -e '1p' -e '/^\/dev\//!d'
		}

		# Show total size in SI.
		# Current dir by default.
		# Usage: tdu [DIRS]
		function tdu() {
			du -sh --si "''${@}"
		}

		# Unlock encrypted disk file.
		# Usage: unlock <FILE> <DIR>
		function unlock() {
			if [[ "''${UID}" != 0 ]]; then
				_error "Must be root."
				return 2
			fi

			local file="''${1}"
			local dir="''${2}"

			if [[ "''${dir}" = "" ]]; then
				help unlock
				return 2
			fi

			local name=$(parse_alnum "''${file##*/}")
			cryptsetup open "''${file}" "''${name}"
			mount "/dev/mapper/''${name}" "''${dir}"
		}

		# Unlock encrypted disk file.
		# Usage: unlock <FILE>
		# function unlock() {
		# 	_filter() {
		# 		sed -e "s/.*\ a[st]\ //" -e "s/\.$//"
		# 	}
		# 	local file="''${1}"
		# 	local name=$(parse_alnum ''${file} | _filter)
		# 	local loop=$(udisksctl loop-setup -f "''${file}" | _filter)
		# 	local unlock=$(udisksctl unlock -b "''${loop}" | _filter)
		# 	local mount=$(udisksctl mount -b "''${unlock}" | _filter)

		# 	[ -L "./''${name}" ] || ln -s "''${mount}" "./''${name}"
		# 	cd "''${mount}"
		# }
	'';
}
