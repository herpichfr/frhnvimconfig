#!/bin/bash

# This script monitors battery level (when available) and hibernate the system when 10 percent is reached.

check_if_battery_present() {
    if [ -d "/sys/class/power_supply/BAT0" ]; then
        return 0
    else
        return 1
    fi
}

get_battery_level() {
    cat /sys/class/power_supply/BAT0/capacity
}

suspend_system() {
    systemctl suspend
}

if check_if_battery_present; then
    while true; do
        BATTERY_LEVEL=$(get_battery_level)
        if [ "$BATTERY_LEVEL" -le 10 ]; then
            # Add notification with counter before suspending
            COUNTER=60
            while [ $COUNTER -gt 0 ]; do
                notify-send "Battery critical" "System will suspend in $COUNTER seconds due to low battery."
                sleep 1
                COUNTER=$((COUNTER - 1))
            done
            suspend_system
            exit 0
        fi
        sleep 60  # Check every minute
    done
else
    echo "No battery detected. Exiting."
    exit 1
fi
