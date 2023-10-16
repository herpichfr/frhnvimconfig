#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#cpu_temp=$(< /sys/class/thermal/thermal_zone0/temp)
#cpu_temp=$(($cpu_temp/1000))

color_good_temp="#[bg=black]"
color_well_temp="#[bg=green]"
color_warn_temp="#[bg=yellow]"
color_crit_temp="#[bg=red]"

CPULIST="$(sensors | grep -oP 'Core.*?\+\K[0-9]+')" 

INUM=0
for TEMP in $CPULIST; do
    if [ $INUM -eq 0 ]; then
        ITEMP=$TEMP
    else
        if [ $TEMP -ge $ITEMP ]; then
            ITEMP=$TEMP
        fi
    fi
    INUM+=1
done

print_cpu_status_bg() {
    # Call `proc_temp.sh`.
    temperature=$ITEMP
    if [ $temperature -le 50 -a $temperature -ge 0 ]; then
        printf $color_good_temp
    elif [ $temperature -le 65 -a $temperature -ge 51 ]; then
        printf $color_well_temp
    elif [ $temperature -le 80 -a $temperature -ge 66 ]; then
        printf $color_warn_temp
    else
        printf $color_crit_temp
    fi
}

main() {
	print_cpu_status_bg
}
main
