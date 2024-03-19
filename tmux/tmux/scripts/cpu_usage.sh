#!/bin/bash

function get_cpu_usage {
  local cpu_idle=$(mpstat 1 1 | grep "Average" | awk '/all/{print $12}')
  local cpu_usage=$(echo "100 - $cpu_idle" | bc | awk '{print $1}')
  echo $cpu_usage > $HOME/tmp/cpu_usage
}

function colour_bar {
    local num_bars=$1
    if [ $num_bars -ge 8 ]; then
        echo "red" # #FF0000"
    elif [ $num_bars -ge 6 ]; then
        echo "orange" # #FFA500"
    elif [ $num_bars -ge 4 ]; then
        echo "yellow" # "#FFFF00"
    else
        echo "green" # #008000"
    fi
}

function create_bar {
    local cpu_usage=$1
    local num_bars=$(echo "($cpu_usage + 10 - 1) / 10" | bc)
    local colour=$(colour_bar $num_bars)
    local bar="#[fg=$colour]"
    for i in $(seq 1 $num_bars); do
        bar="${bar}󰝤"
    done
    bar="${bar}#[fg=#00000]"
    number_of_spaces=$((10 - num_bars))
    echo $number_of_spaces
    for i in $(seq 1 $((10 - num_bars))); do
        bar="${bar}"
    done
    echo $bar
}


if [ ! -f $HOME/tmp/cpu_usage ]; then
    get_cpu_usage
else
    current_time=$(date +%s)
    last_time_edited=$(stat -c %Y $HOME/tmp/cpu_usage)
    if [ $((current_time - last_time_edited)) -ge 60 ]; then
        get_cpu_usage
    fi
fi

create_bar $(cat $HOME/tmp/cpu_usage)
