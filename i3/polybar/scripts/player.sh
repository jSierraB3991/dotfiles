#!/bin/bash

get_player() {
    for player in $(playerctl -l 2>/dev/null); do
        status=$(playerctl -p "$player" status 2>/dev/null)

        if [ "$status" = "Playing" ]; then
            echo "$player"
            return
        fi
    done

    # Si ninguno está reproduciendo, usa el primero disponible
    playerctl -l 2>/dev/null | head -n1
}

while true; do
    player=$(get_player)

    if [ -n "$player" ]; then
        status=$(playerctl -p "$player" status 2>/dev/null)

        case "$status" in
            Playing)
                icon="󰏤"
                ;;
            Paused)
                icon="󰐊"
                ;;
            *)
                icon="󰓛"
                ;;
        esac

        song=$(playerctl -p "$player" metadata \
            --format '{{title}}' 2>/dev/null)

        if [ -n "$song" ]; then
            echo "󰒮  $icon  󰒭  $song"
        else
            echo "$icon"
        fi
    fi

    sleep 1
done
