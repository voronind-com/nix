# Create/attach to named session.
# By default uses current dir name.
# Usage: ta [NAME]
function ta() {
	local name="${1}"

	# Set default name.
	# [[ "${name}" = "" ]] && name="main"
	[[ ${name} == "" ]] && name=$(printf "%s" "${PWD##*/}" | parse_alnum)

	# Create session.
	tmux new-session -s "${name}" -d &>/dev/null

	# Attach to session.
	if _is_tmux; then
		tmux switch-client -t "${name}"
	else
		tmux attach-session -t "${name}"
	fi
}

# Detach from running session.
function td() {
	tmux detach-client
}

# Detach all other tmux clients.
function tda() {
	tmux detach-client -s $(tmux display-message -p '#S')
}

# List running sessions.
function tl() {
	tmux list-sessions
}

# Assign name to session. Uses current dir name by default.
# Usage: tns [NAME]
function tns() {
	local name="${1}"

	[[ ${name} == "" ]] && name=$(printf "%s" "${PWD##*/}" | parse_alnum)

	tmux rename-session "${name}"
}

# Assign name to window. Uses current dir name by default.
# Usage: tnw [NAME]
function tnw() {
	local name="${1}"

	[[ ${name} == "" ]] && name=$(printf "%s" "${PWD##*/}" | parse_alnum)

	tmux rename-window "${name}"
}

# Kill specified session.
# By default uses current dir name.
# Usage: tk [NAME]
function tk() {
	local name="${1}"

	[[ ${name} == "" ]] && name=$(printf "%s" "${PWD##*/}" | parse_alnum)

	tmux kill-session -t "${name}"
}

# Kill all sessions.
function tka() {
	local sessions=$(tmux list-sessions | sed -e 's/:.*//')

	for session in $sessions; do
		tmux kill-session -t "$session"
	done
}

# Autocomplete with running sessions once.
function _complete_tmux_session() {
	_autocomplete "$(tmux list-sessions 2>/dev/null | sed -e 's/:.*//')"
}

# Autocomplete with running sessions.
function _complete_tmux_sessions() {
	_autocomplete "$(tmux list-sessions 2>/dev/null | sed -e 's/:.*//')"
}

# Autocomplete with current dir name and dirs inside this one.
function _complete_tmux_name() {
	_autocomplete "${PWD##*/}"$'\n'$(ls --classify | grep /$ | sed -e 's/\/$//')
}

complete -F _complete_tmux_session ta
complete -F _complete_tmux_sessions tk
complete -o nosort -F _complete_tmux_name tns tnw
