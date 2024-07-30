{ config, ... }: let
	mod = config.setting.sysctrl;
in {
	text = ''
		bindsym ${mod} input * xkb_switch_layout 0
		bindsym --to-code ${mod}+c exec 'systemctl reboot -i'
		bindsym --to-code ${mod}+g exec 'swayscript gamingtoggle'
		bindsym --to-code ${mod}+l exec 'powerlimit toggle'
		bindsym --to-code ${mod}+m exec 'swayscript montoggle'
		bindsym --to-code ${mod}+p exec 'powersave toggle'
		bindsym --to-code ${mod}+v exec 'swayscript vpntoggle'
		bindsym --to-code ${mod}+x exec 'systemctl poweroff -i'
		bindsym --to-code ${mod}+z exec 'systemctl suspend -i'
	'';
}
