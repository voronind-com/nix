{ ... }: {
	text = ''
		bindsym --to-code $mod+shift+r exec 'pkill waybar || exec waybar'
		exec waybar
	'';
}
