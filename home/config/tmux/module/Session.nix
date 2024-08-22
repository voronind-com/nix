{ ... }: let
	mod = "M";
in {
	text = ''
		bind -n ${mod}-z detach-client
		bind -n ${mod}-Z detach-client -a

		bind -n ${mod}-( switch-client -p
		bind -n ${mod}-) switch-client -n
		bind -n ${mod}-g choose-session -Z

		set -g window-size smallest
	'';
}
