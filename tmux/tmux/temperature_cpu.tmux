#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cpu_interpolation=(
	"\#{cores_status}"
	"\#{temp_status_bg}"
)
cpu_commands=(
	"#($CURRENT_DIR/cpu_temp/cores_status.sh)"
	"#($CURRENT_DIR/cpu_temp/temp_status_bg.sh)"
)

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local all_interpolated="$1"
	for ((i=0; i<${#cpu_commands[@]}; i++)); do
		all_interpolated=${all_interpolated/${cpu_interpolation[$i]}/${cpu_commands[$i]}}
	done
	echo "$all_interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
