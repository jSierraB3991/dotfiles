#! /bin/bash

name_image="$(date +%s)"
format_screen=$1

if [ "$format_screen" == "-s" ] || [ "$format_screen" == "-m" ]; then
    scrot $format_screen $HOME/Images/$name_image.png
    dunstify "Scrrenshot save in $HOME/Images/$name_image.png" -u low
fi

