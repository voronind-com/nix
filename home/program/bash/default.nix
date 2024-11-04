{
	util,
	pkgs,
	...
} @args: let
	modules     = util.catText (util.ls ./module) args;
	modulesFile = pkgs.writeText "BashModules" modules;
in {
	inherit modules modulesFile;

	bashrc = modules + ''
		# Find all functions.
		function find_function() {
			/usr/bin/env cat ${modulesFile} | /usr/bin/env grep "^function.*()" | /usr/bin/env sed -e "s/^function //" -e "s/().*//"
		}

		# Export all functions.
		export -f $(find_function | tr '\n' ' ')
		export -f find_function

		# Autostart Sway.
		if [[ -z $DISPLAY ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
			exec sway
		fi
	'';

	# bash_profile = ''
	#   # Home manager.
	#   [ -e ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh

	#   # Bashrc.
	#   [ -f ~/.bashrc ] && source ~/.bashrc

	#   # Profile.
	#   [ -f ~/.profile ] && source ~/.profile
	# '';

	# profile = ''
	#   # Load HM vars.
	#   [ -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh ] && source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	# '';
}
