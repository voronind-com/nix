# Zfs list.
function zl() {
	eval "zfs list" "${@}"
}

function zls() {
	eval "zfs list -t snapshot" "${@}"
}

# Zfs get.
function zg() {
	eval "zfs get" "${@}"
}

function zs() {
	eval "zfs set" "${@}"
}

# TODO: Autocompletes.
