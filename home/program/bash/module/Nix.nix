{ const, ... }: {
	text = ''
		export _nix_system_config="git+${const.url}"

		# Rebuild system.
		# Optionally force the hostname.
		# Usage: nixos_rebuild [HOSTNAME]
		function nixos_rebuild() {
			local target="''${1}"
			[[ "''${target}" = "" ]] && target="''${HOSTNAME}"

			nixos-rebuild boot --refresh --option eval-cache false --flake "''${_nix_system_config}#''${target}"
		}

		# Rebuild and switch system.
		# Optionally force the hostname.
		# Usage: nixos_switch [HOSTNAME]
		function nixos_switch() {
			local target="''${1}"
			[[ "''${target}" = "" ]] && target="''${HOSTNAME}"

			nixos-rebuild switch --refresh --option eval-cache false --flake "''${_nix_system_config}#''${target}"
		}

		# Spawn shell with specified nix environment.
		# Uses flake.nix in current dir by default.
		# Usage: shell [NAME]
		function shell() {
			local target="''${1}"
			[[ "''${target}" = "" ]] && target="default"

			# Create Nix GC root in .NixRoot{NAME}.
			nix build ".#devShells.''${NIX_CURRENT_SYSTEM}.''${target}" -o ".NixRoot''${target^}"

			SHELL_NAME="''${target}" nix develop ".#devShells.''${NIX_CURRENT_SYSTEM}.''${target}"
		}

		# Spawn temporary nix-shell with specified packages.
		# Usage: tmpshell <PACKAGES>
		function tmpshell() {
			local IFS=$'\n'
			local input=("''${@}")
			local pkgs=()
			local tag="''${SHELL_NAME}"

			if [[ "''${input}" = "" ]]; then
				help tmpshell
				return 2
			fi

			[[ "''${tag}" = "" ]] && tag="''${1}"

			for pkg in ''${input[@]}; do
				pkgs+=("nixpkgs#''${pkg}")
			done

			SHELL_NAME="''${tag}" NIXPKGS_ALLOW_UNFREE=1 nix shell --impure ''${pkgs[@]}
		}

		# Build live image.
		function nixos_live() {
			nix build "''${_nix_system_config}#nixosConfigurations.live.config.system.build.isoImage" --refresh ''${@}
		}

		# List nixos generations.
		function nixos_generations() {
			nix-env -p /nix/var/nix/profiles/system --list-generations
		}

		# Switch nix-on-droid.
		function nixdroid_switch() {
			nix-on-droid switch --flake "''${_nix_system_config}" ''${@}
		}

		# Nix auto-run wrapper.
		# Usage: , <COMMAND>
		function ,() {
			NIX_AUTO_RUN=1 ''${@}
		}

		# Autocomplete with available hosts.
		function _comp_hosts() {
			local IFS=$'\n'
			local targets=($(ls ~/.config/linux/system/host/))

			_autocomplete_first ''${targets[@]}
		}

		complete -F _comp_hosts nix_switch nix_rebuild
	'';
}
