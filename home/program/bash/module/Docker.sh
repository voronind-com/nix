# Show container's volumes.
# Usage: docker_volumes <CONTAINER>
function docker_volumes() {
	docker inspect -f '{{ .Mounts }}' "${@}"
}

# Check if any container exited.
function docker_health() {
	docker ps -a | grep Exited
}

# Find out container's IP address.
# Usage: docker_ip <CONTAINER>
function docker_ip() {
	docker inspect -f '\'{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'\' "${1}" | sed "s/^.//" | sed "s/.$//"
}

# Update all docker images.
function docker_update() {
	docker images --format "{{.Repository}}:{{.Tag}}" | xargs -L1 docker pull
}

# Docker compose shortcut.
function dc() {
	docker compose "${@}"
}

# Docker compose up.
# Usage: dcu [SERVICES]
function dcu() {
	docker compose up -d "${@}"
}

# Docker compose down.
# Usage: dcd [SERVICES]
function dcd() {
	docker compose down "${@}"
}

# Docker compose pull.
# Usage: dcp [SERVICES]
function dcp() {
	docker compose pull "${@}"
}

# Docker compose logs.
# Usage: dcl [SERVICES]
function dcl() {
	docker compose logs -f "${@}"
}

# Docker compose restart.
# Usage: dcr [SERVICES]
function dcr() {
	docker compose restart "${@}"
}

# Docker compose stop.
# Usage: dcs [SERVICES]
function dcs() {
	docker compose stop "${@}"
}

# Docker compose down & up specified services.
# Usage: dcdu [SERVICES]
function dcdu() {
	dcd "${@}"
	dcu "${@}"
}

# Docker compose pull & up specified services.
# Usage: dcpu [SERVICES]
function dcpu() {
	dcp "${@}"
	dcu "${@}"
}

# Docker compose up & attach to logs for specified services.
# Usage: dcul [SERVICES]
function dcul() {
	dcu "${@}" && dcl "${@}"
}

# Autocomplete with available services.
function _dc_services() {
	_autocomplete "$(docker compose config --services 2>/dev/null)"
}

# Autocomplete with available container names.
function _dc_containers() {
	_autocomplete "$(docker ps --format '"'{{.Names}}"\"")"
}

complete -F _dc_services dcu dcd dcp dcl dcul dcdu dcr dcs dcpu
complete -F _dc_containers docker_volumes docker_ip
