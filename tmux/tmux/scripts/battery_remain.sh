#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

battery_discharging() {
	local status="$(battery_status)"
	[[ $status =~ (discharging) ]]
}

pmset_battery_remaining_time() {
	local status="$(pmset -g batt)"
	if echo $status | grep 'no estimate' >/dev/null 2>&1; then
		echo '- Calculating estimate...'
	else
		local remaining_time="$(echo $status | grep -o '[0-9]\{1,2\}:[0-9]\{1,2\}')"
		if battery_discharging; then
			echo $remaining_time | awk '{printf "- %s left", $1}'
		else
			echo $remaining_time | awk '{printf "- %s till full", $1}'
		fi
	fi
}

print_battery_remain() {
	if command_exists "pmset"; then
		pmset_battery_remaining_time
	elif command_exists "acpi"; then
		acpi -b | grep -Eo "[0-9]+:[0-9]+:[0-9]+"
	fi
}

print_battery_full() {
	if command_exists "pmset"; then
		pmset_battery_remaining_time
	elif command_exists "upower"; then
		battery=$(upower -e | grep battery | head -1)
		upower -i $battery | grep 'time to full' | awk '{printf "- %s %s till full", $4, $5}'
	fi
}

notify_battery_status() {
    # Call `battery_percentage.sh`.
    percentage=$($CURRENT_DIR/battery_percentage.sh | sed -e 's/%//')
    if [ $percentage -le 30 -a $percentage -ge 16 ]; then
        notify-send "Battery is low: $percentage%" "Remaning time is $(print_battery_remain)" --urgency=critical
    elif [ $percentage -le 15 ];then
        notify-send "tmux: Battery is critically low: $percentage. Please plug in your charger." "Remaning time is $(print_battery_remain)" --urgency=critical
    else
        true
    fi
}

print_battery_percentage() {
	# percentage displayed in the 2nd field of the 2nd row
	if command_exists "pmset"; then
		pmset -g batt | grep -o "[0-9]\{1,3\}%"
	elif command_exists "acpi"; then
		acpi -b | grep -Eo "[0-9]+%"
	fi
}

main() {
	print_battery_percentage
	if battery_discharging; then
		notify_battery_status
	fi
}
main
