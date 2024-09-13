{ ... }: let
	mod = "print";
	brstep = 5;
in {
	text = ''
		bindsym ${mod} input * xkb_switch_layout 0
		bindsym --to-code ${mod}+c exec 'systemctl reboot -i'
		bindsym --to-code ${mod}+g exec 'swayscript gaming'
		bindsym --to-code ${mod}+l exec 'powerlimit toggle'
		bindsym --to-code ${mod}+m exec 'swayscript monitor'
		bindsym --to-code ${mod}+n exec 'swayscript dnd'
		bindsym --to-code ${mod}+p exec 'powersave toggle'
		bindsym --to-code ${mod}+r exec 'swayscript reload'
		bindsym --to-code ${mod}+v exec 'swayscript vpn'
		bindsym --to-code ${mod}+x exec 'systemctl poweroff -i'
		bindsym --to-code ${mod}+z exec 'systemctl suspend -i'

		bindsym --to-code ${mod}+w    exec light -A ${toString brstep}
		bindsym XF86MonBrightnessUp   exec light -A ${toString brstep}
		bindsym --to-code ${mod}+s    exec light -U ${toString brstep}
		bindsym XF86MonBrightnessDown exec light -U ${toString brstep}
	'';
}
