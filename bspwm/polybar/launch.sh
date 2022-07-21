#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch

## Left bar
polybar log -c ~/.config/polybar/current.ini &
polybar secondary -c ~/.config/polybar/current.ini &

## Center bar
my_laptop_external_monitor=$(xrandr --query | grep 'HDMI-A-0' | awk '{print $2}' )
echo $my_laptop_external_monitor
if [ $my_laptop_external_monitor = "connected" ]
then
    polybar primary -c ~/.config/polybar/workspace.ini &
    polybar primary_external -c ~/.config/polybar/workspace.ini &
else
    polybar primary_one -c ~/.config/polybar/workspace.ini &
fi
