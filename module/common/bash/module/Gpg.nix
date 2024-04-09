{ ... }: {
	text = ''
		# Encrypt files to myself.
		# Usage: encrypt <FILES>
		function encrypt() {
			local IFS=$'\n'
			local targets=(''${@})
			[[ "''${targets}" = "" ]] && targets=($(_ls_file))

			process() {
				gpg --encrypt --armor --recipient hi@voronind.com --output "''${target}.enc" "''${target}"
			}

			_iterate_targets process ''${targets[@]}
		}

		# Decrypt files to myself.
		# Usage: decrypt <FILES>
		function decrypt() {
			local IFS=$'\n'
			local targets=(''${@})
			[[ "''${targets}" = "" ]] && targets=($(_ls_file))

			process() {
				gpg --decrypt --output "''${target%.enc}" "''${target}"
			}

			_iterate_targets process ''${targets[@]}
		}

		# Sign a file.
		# Usage: sign <FILES>
		function sign() {
			local IFS=$'\n'
			local targets=(''${@})
			[[ "''${targets}" = "" ]] && targets=($(_ls_file))

			process() {
				gpg --detach-sig --armor --output "''${target}.sig" "''${target}"
			}

			_iterate_targets process ''${targets[@]}
		}

		# Verify a signature.
		# Usage: verify <FILES>
		function verify() {
			local IFS=$'\n'
			local targets=(''${@})
			[[ "''${targets}" = "" ]] && targets=(*.sig)

			process() {
				gpg --verify "''${target}"
			}

			_iterate_targets process ''${targets[@]}
		}
	'';
}
