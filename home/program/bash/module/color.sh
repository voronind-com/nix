# Collection of available CLI colors.
# They may differ depending on the terminal used.
# Colors with 'b' prefix are bold colors.

export color_default="\033[0m"
export color_blue="\033[0;34m"
export color_bblue="\033[1;34m"
export color_cyan="\033[0;36m"
export color_bcyan="\033[1;36m"
export color_green="\033[0;32m"
export color_bgreen="\033[1;32m"
export color_purple="\033[0;35m"
export color_bpurple="\033[1;35m"
export color_red="\033[0;31m"
export color_bred="\033[1;31m"
export color_white="\033[0;37m"
export color_bwhite="\033[1;37m"
export color_yellow="\033[0;33m"
export color_byellow="\033[1;33m"

# Print all available colors with their names colored in corresponding color.
function color_test() {
	echo -e "${color_default}color_default\n${color_blue}color_blue\n${color_bblue}color_bblue\n${color_cyan}color_cyan\n${color_bcyan}color_bcyan\n${color_green}color_green\n${color_bgreen}color_bgreen\n${color_purple}color_purple\n${color_bpurple}color_bpurple\n${color_red}color_red\n${color_bred}color_bred\n${color_white}color_white\n${color_bwhite}color_bwhite\n${color_yellow}color_yellow\n${color_byellow}color_byellow"
}
