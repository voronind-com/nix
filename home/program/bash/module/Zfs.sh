# Zfs list.
function zl() {
	eval "zfs list" "${@}"
}

# Zfs get.
function zg() {
	eval "zfs get" "${@}"
}

function zs() {
	eval "zfs set" "${@}"
}

# TODO: Autocompletes.
