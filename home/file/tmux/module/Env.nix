{ ... }: {
	text = ''
		set -sg escape-time 0
		set-option -g default-terminal "tmux-256color"
		set-option -g focus-events on
		set-option -sa terminal-features "RGB"
		set -g allow-passthrough on
		set-option -g update-environment "SSH_CLIENT SSH_TTY DOCKER_CONFIG DOCKER_HOST DISPLAY XAUTHORITY BASH_PATH SWAY_SOCK TERM TERM_PROGRAM"
	'';
}
