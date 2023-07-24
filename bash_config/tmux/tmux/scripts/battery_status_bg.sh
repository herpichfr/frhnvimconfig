#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

color_full_charge_default="#[bg=gray]"
color_high_charge_default="#[bg=blue]"
color_middle_high_charge_default="#[bg=green]"
color_medium_charge_default="#[bg=yellow]"
color_low_charge_default="#[bg=red]"

color_full_charge=""
color_high_charge=""
color_middle_high_charge=""
color_medium_charge=""
color_low_charge=""

get_charge_color_settings() {
    color_full_charge=$(get_tmux_option "@batt_color_full_charge" "$color_full_charge_default")
    color_high_charge=$(get_tmux_option "@batt_color_high_charge" "$color_high_charge_default")
    color_middle_high_charge=$(get_tmux_option "@batt_color_middle_high_charge" "$color_middle_high_charge_default")
    color_medium_charge=$(get_tmux_option "@batt_color_medium_charge" "$color_medium_charge_default")
    color_low_charge=$(get_tmux_option "@batt_color_low_charge" "$color_low_charge_default")
}

print_battery_status_bg() {
    # Call `battery_percentage.sh`.
    percentage=$($CURRENT_DIR/battery_percentage.sh | sed -e 's/%//')
    if [ $percentage -eq 100 ]; then
        printf $color_full_charge
    elif [ $percentage -le 99 -a $percentage -ge 76 ];then
        printf $color_high_charge
    elif [ $percentage -le 75 -a $percentage -ge 50 ];then
        printf $color_middle_high_charge
    elif [ $percentage -le 49 -a $percentage -ge 25 ];then
        printf $color_medium_charge
    else
        printf $color_low_charge
    fi
}

notify_battery_status() {
    # Call `battery_percentage.sh`.
    percentage=$($CURRENT_DIR/battery_percentage.sh | sed -e 's/%//')
    if [ $percentage -eq 30 ]; then
        notify-send "tmux: Battery is low: 30%"
    elif [ $percentage -eq 20 ];then
        notify-send "tmux: Battery is low: 20%"
    elif [ $percentage -eq 10 ];then
        notify-send "tmux: Battery is critically low: 10%. Will shutdown soon"
    else
        continue
    fi
}

main() {
    get_charge_color_settings
	print_battery_status_bg
    notify_battery_status
}
main
