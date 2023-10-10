#!/bin/bash

get_weather () {
    WEATHER=$(curl -s wttr.in/?format="%C+%t+%w")
    echo "$WEATHER" > "$HOME"/.cache/tmux-weather/weather.txt
}

if [ -f "$HOME"/.cache/tmux-weather/weather.txt ]; then
    if test "$(find "$HOME"/.cache/tmux-weather/weather.txt -mmin +15)"; then
        get_weather
    fi
else
    get_weather
fi

cat "$HOME"/.cache/tmux-weather/weather.txt
