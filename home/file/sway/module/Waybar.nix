{ ... }: {
	text = ''
		bindsym --to-code $mod+shift+r exec 'pkill waybar || exec waybar'
		exec waybar
		exec nm-applet
		exec blueman-applet
		exec syncthingtray
	'';
}
