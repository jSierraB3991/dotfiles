#!/bin/bash

player=$(playerctl -l 2>/dev/null | head -n 1)

if [ -z "$player" ]; then
    echo '{"text":"", "class":"hidden"}'
    exit
fi

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon=""
else
    icon=""
fi

title=$(playerctl metadata --format '{{ title }}' 2>/dev/null)
artist=$(playerctl metadata --format '{{ artist }}' 2>/dev/null)

if [ -z "$title" ]; then
    echo '{"text":"", "class":"hidden"}'
    exit
fi

player_name=$(echo $player | awk -F. '{print toupper($1)}')

echo "{\"text\":\"$player_name - $icon $title\"}"
