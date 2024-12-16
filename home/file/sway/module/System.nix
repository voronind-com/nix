{ ... }: let
	brstep = 5;
in {
	text = ''
		bindsym $sysmod input * xkb_switch_layout 0
		bindsym --to-code $sysmod+a exec 'swayscript network'
		bindsym --to-code $sysmod+c exec 'systemctl reboot -i'
		bindsym --to-code $sysmod+d exec 'swayscript dnd'
		bindsym --to-code $sysmod+g exec 'swayscript gaming'
		bindsym --to-code $sysmod+l exec 'powerlimit toggle'
		bindsym --to-code $sysmod+m exec 'swayscript monitor'
		bindsym --to-code $sysmod+p exec 'powersave toggle'
		bindsym --to-code $sysmod+r exec 'swayscript reload'
		bindsym --to-code $sysmod+v exec 'swayscript vpn'
		bindsym --to-code $sysmod+x exec 'systemctl poweroff -i'
		bindsym --to-code $sysmod+z exec 'systemctl suspend -i'

		bindsym --to-code $sysmod+w   exec light -A ${toString brstep}
		bindsym XF86MonBrightnessUp   exec light -A ${toString brstep}
		bindsym --to-code $sysmod+s   exec light -U ${toString brstep}
		bindsym XF86MonBrightnessDown exec light -U ${toString brstep}
	'';
}
