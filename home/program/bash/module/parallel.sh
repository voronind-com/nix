function par() {
	local IFS=$'\n'
	local input=($(cat))
	local cmd="${@}"

	for line in ${input[@]}; do
		local todo="${cmd//\{\}/$line}"
		local todo="${todo//\{\.\}/${line%.*}}"
		while test $(jobs -p | wc -w) -ge $(nproc); do wait -n; done
		eval ${todo} &
	done
	wait
}

function par1() {
	local IFS=$'\n'
	local input=($(cat))
	local cmd="${@}"

	for line in ${input[@]}; do
		local todo="${cmd/\{\}/$line}"
		local todo="${todo/\{\.\}/${line%.*}}"
		eval ${todo}
	done
}
