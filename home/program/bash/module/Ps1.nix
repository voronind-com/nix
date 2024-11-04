{
	config,
	...
}: let
	accent   = "${config.module.style.color.accent-r};${config.module.style.color.accent-g};${config.module.style.color.accent-b}";
	negative = "${config.module.style.color.negative-r};${config.module.style.color.negative-g};${config.module.style.color.negative-b}";
	neutral  = "${config.module.style.color.neutral-r};${config.module.style.color.neutral-g};${config.module.style.color.neutral-b}";
	positive = "${config.module.style.color.positive-r};${config.module.style.color.positive-g};${config.module.style.color.positive-b}";
in {
	text = ''
		export PROMPT_COMMAND=(__prompt_command "''${PROMPT_COMMAND[@]}")

		function __prompt_color() {
			local color="''${1}"
			if [[ "''${color}" = "" ]]; then
				printf "\[\x1b[0m\]"
			else
				printf "\[\x1b[38;2;''${color}m\]"
			fi
		}

		# Custom terminal prompt format.
		function __prompt_command() {
			local last_status="''${?}"
			local is_error=false
			local is_root=false

			if [[ ''${last_status} != 0 && ''${last_status} != 130 ]]; then
				is_error=true
			fi
			if [[ "''${UID}" -eq 0 ]]; then
				is_root=true
			fi

			# Add newline.
			PS1="\n"

			# Set error red.
			if ''${is_error}; then
				PS1+="$(__prompt_color '${negative}')"
				PS1+="["
			else
				PS1+="$(__prompt_color)"
				PS1+="["
			fi

			# Add time.
			# PS1+="$(__prompt_color '${accent}')"
			# PS1+="$(date +%H:%M) "

			# Set root red.
			if ''${is_root}; then
				PS1+="$(__prompt_color '${negative}')"
			else
				PS1+="$(__prompt_color '${neutral}')"
			fi

			# Add user, host and working dir.
			PS1+="\u@\h "
			PS1+="$(__prompt_color '${positive}')"
			PS1+="\w"
			# PS1+="\''${PWD}"

			# Add git branch if available.
			local git_branch="$(_git_current_branch)"
			if [[ "''${git_branch}" != "" ]]; then
				PS1+=" $(__prompt_color '${accent}')@''${git_branch}"
			fi

			# Set error red.
			if ''${is_error}; then
				PS1+="$(__prompt_color '${negative}')"
				PS1+="] "
			else
				PS1+="$(__prompt_color)"
				PS1+="] "
			fi

			# If error, show code.
			if ''${is_error}; then
				PS1+="$(__prompt_color '${negative}')("
				PS1+="''${last_status}"
				local error_type="$(_ps1error ''${last_status})"
				[[ "''${error_type}" != "" ]] && PS1+=" ''${error_type}"
				PS1+=")$(__prompt_color) "
			fi

			# Command on new line.
			PS1+="\n"

			# Show nix shell name or shell depth.
			if [ -n "''${SHELL_NAME}" ]; then
				PS1+="''${SHELL_NAME} "
			fi

			# Show remote connections.
			if [ -n "''${SSH_TTY}" ]; then
				PS1+=">"
			fi

			PS1+="$(__prompt_color)"

			# Set user tag.
			if ''${is_root}; then
				PS1+="# "
			else
				PS1+="$ "
			fi

			# Reset color.
			PS1+="\[\033[0m\]"
		}

		# Convert error code into short description.
		# Usage: _ps1error <CODE>
		function _ps1error() {
			local type
			case ''${1} in
				1)   type="GENERAL" ;;
				2)   type="MISUSE" ;;
				126) type="CANTEXEC" ;;
				127) type="CMDNF" ;;
				129) type="SIGHUP" ;;
				130) type="SIGINT" ;;
				131) type="SIGQUIT" ;;
				132) type="SIGILL" ;;
				133) type="SIGTRAP" ;;
				134) type="SIGABRT" ;;
				135) type="SIGBUS" ;;
				136) type="SIGFPE" ;;
				137) type="SIGKILL" ;;
				138) type="SIGUSR1" ;;
				139) type="SIGSEGV" ;;
				140) type="SIGUSR2" ;;
				141) type="SIGPIPE" ;;
				142) type="SIGALRM" ;;
				143) type="SIGTERM" ;;
				144) type="" ;;
				145) type="SIGCHLD" ;;
				146) type="SIGCONT" ;;
				147) type="SIGSTOP" ;;
				148) type="SIGTSTP" ;;
				149) type="SIGTTIN" ;;
				150) type="SIGTTOU" ;;
				151) type="SIGURG" ;;
				152) type="SIGXCPU" ;;
				153) type="SIGXFSZ" ;;
				154) type="SIGVTALRM" ;;
				155) type="SIGPROF" ;;
				156) type="SIGWINCH" ;;
				157) type="SIGIO" ;;
				158) type="SIGPWR" ;;
				159) type="SIGSYS" ;;
				*)   type="" ;;
			esac

			echo -n "''${type}"
		}
	'';
}
