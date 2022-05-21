#!/usr/bin/bash

case $1 in
    up)
        brightnessctl set 5%+
        ;;
    down)
        brightnessctl set 5%-
	    ;;
    *)
        echo "Usage: $0 up | down "
        ;;
esac
