# Spawn shell with specified nix environment.
# Uses flake.nix in current dir by default.
# Usage: shell [NAME]
function shell() {
	local target="${1}"
	[[ ${target} == "" ]] && target="default"

	# Create Nix GC root in .NixRoot{NAME}.
	nix build ".#devShells.${NIX_CURRENT_SYSTEM}.${target}" -o ".gc-roots-nix-${target}"

	SHELL_NAME="${target}" nix develop ".#devShells.${NIX_CURRENT_SYSTEM}.${target}"
}

# Spawn temporary nix-shell with specified packages.
# Usage: tmpshell <PACKAGES>
function tmpshell() {
	local IFS=$'\n'
	local input=("${@}")
	local pkgs=()
	local tag="${1}"

	if [[ ${input} == "" ]]; then
		help tmpshell
		return 2
	fi

	for pkg in ${input[@]}; do
		pkgs+=("nixpkgs#${pkg}")
	done

	SHELL_NAME="${tag}" NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix shell --impure ${pkgs[@]}
}

function nix_depends() {
	nix why-depends /run/current-system nixpkgs#${1}
}

# Run stuff directrly from Nixpks.
# Usage: nixpkgs_run <REV> <PACKAGE> [COMMAND]
function nixpkgs_run() {
	local rev="${1}"
	local pkg="${2}"
	local cmd="${@:3}"

	if [[ ${pkg} == "" ]]; then
		help nixpkgs_run
		return 2
	fi

	[[ ${cmd} == "" ]] && cmd="${pkg}"

	SHELL_NAME="${pkg}" NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix shell --impure github:NixOS/nixpkgs/${rev}#${pkg} -c ${cmd}
}

# Prefetch to nix store.
# Usage: prefetch <URL>
function prefetch() {
	local url="${1}"
	local name="${1##*/}"
	name=$(printf "%s" "${name%%\?*}" | parse_alnum)

	if [[ ${url} == "" ]]; then
		help prefetch
		return 2
	fi

	local result=$(nix hash convert --to sri --hash-algo sha256 $(nix-prefetch-url --name "${name}" "${url}"))
	printf "%s" ${result} | copy
	printf "%s\n" ${result}
}

# Run nix locally with no builders.
# Usage: nix_local <COMMAND>
function nix_local() {
	nix --option max-jobs $(nproc) --builders "" --substituters https://cache.nixos.org ${@}
}

# Run test app from other people PRs.
# Usage: nix_test github:user/nixpkgs/<REV>#<PKG>
function nix_test() {
	if [[ ${@} == "" ]]; then
		help nix_test
		return 2
	fi

	local name=${*##*#}
	SHELL_NAME="${name}" NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix --option max-jobs $(nproc) --builders "" --substituters https://cache.nixos.org shell --impure ${@}
}
