#! /bin/bash

if [ "$(ps -aux | grep eww | grep open |wc -l )" != "1" ]; then
    /home/juan-sierra/.local/bin/eww -c /home/juan-sierra/.config/eww/notification open bar
else
    /home/juan-sierra/.local/bin/eww -c /home/juan-sierra/.config/eww/notification close bar
    killall eww
fi
