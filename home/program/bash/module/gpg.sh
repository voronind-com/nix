# Check smartcard pin.
function scunlock() {
	pkill keyboxd &>/dev/null
	pkill gpg-agent &>/dev/null
	pkill age &>/dev/null
	echo verify | gpg --card-edit --no-tty --command-fd=0
}

# Encrypt files to myself from a file or stdin.
# Usage: encrypt [FILES]
function encrypt() {
	local IFS=$'\n'
	local targets=(${@})

	if [[ ${targets} == "" ]]; then
		gpg --encrypt --armor --recipient hi@voronind.com
	else
		process() {
			pv "${target}" | gpg --encrypt --recipient hi@voronind.com --output "${target}.gpg"
		}

		_iterate_targets process ${targets[@]}
	fi
}

# Decrypt files to myself.
# Usage: decrypt [FILES]
function decrypt() {
	local IFS=$'\n'
	local targets=(${@})

	if [[ ${targets} == "" ]]; then
		gpg --decrypt
	else
		process() {
			pv "${target}" | gpg --decrypt --output "${target%.gpg}"
		}

		_iterate_targets process ${targets[@]}
	fi
}

# Sign a file.
# Usage: sign <FILES>
function sign() {
	local IFS=$'\n'
	local targets=(${@})

	if [[ ${targets} == "" ]]; then
		help sign
		return 2
	fi

	process() {
		gpg --detach-sig --armor --output "${target}.sig" "${target}"
	}

	_iterate_targets process ${targets[@]}
}

# Verify a signature. All .sig files by default.
# Usage: verify [FILES]
function verify() {
	local IFS=$'\n'
	local targets=(${@})

	[[ ${targets} == "" ]] && targets=(*.sig)

	process() {
		gpg --verify "${target}"
	}

	_iterate_targets process ${targets[@]}
}

# Find user keys using keyservers.
# Usage: gpg_find <EMAIL>
function gpg_find() {
	local email="${1}"

	if [[ ${email} == "" ]]; then
		help gpg_find
		return 2
	fi

	gpg --locate-keys "${email}" ||
		gpg --locate-keys --auto-key-locate hkps://keys.openpgp.org "${email}"
}

# Update keys.
function gpg_refresh() {
	gpg --refresh-keys
}
