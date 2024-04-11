#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#cpu_temp=$(< /sys/class/thermal/thermal_zone0/temp)
#cpu_temp=$(($cpu_temp/1000))

color_good_usage="#[bg=black]#[fg=white]"
color_well_usage="#[bg=green]#[fg=black]"
color_warn_usage="#[bg=yellow]#[fg=black]"
color_crit_usage="#[bg=red]#[fg=yellow]"

MEMPERC=$(echo "$(free | grep Mem | awk '{print $3}') / $(free | grep Mem | awk '{print $2}') * 100" | bc -l)

print_mem_status_bg() {
    if (( $(echo "$MEMPERC <= 25.0" | bc -l) )); then
        printf $color_good_usage
    elif (( $(echo "$MEMPERC <= 50.0" | bc -l) && $(echo "$MEMPERC > 25.0" | bc -l) )); then
        printf $color_well_usage
    elif (( $(echo "$MEMPERC <= 75.0" | bc -l) && $(echo "$MEMPERC > 50.0" | bc -l) )); then
        printf $color_warn_usage
    else
        printf $color_crit_usage
    fi
}

main() {
	print_mem_status_bg
}
main

