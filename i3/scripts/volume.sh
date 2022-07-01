#!/usr/bin/env bash

notify_id=$(cat $HOME/.local/data/volume_id.txt | head -1)
if [ "$notify_id" == "" ]; then
    notify_id=0
fi
sink_nr=1   # use `pacmd list-sinks` to find out sink_nr
MIXER="pulse"
SCONTROL="Master"

#------------------------------------------------------------------------

capability() { # Return "Capture" if the device is a capture device
  amixer -D $MIXER get $SCONTROL |
    sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

volume() {
  amixer -D $MIXER get $SCONTROL $(capability)
}

format() {
  
  perl_filter='if (/.*\[(\d+%)\] (\[(-?\d+.\d+dB)\] )?\[(on|off)\]/)'
  perl_filter+='{CORE::say $4 eq "off" ? "MUTE" : "'
  # If dB was selected, print that instead
  perl_filter+=$([[ $STEP = *dB ]] && echo '$3' || echo '$1')
  perl_filter+='"; exit}'
  output=$(perl -ne "$perl_filter")
  echo "$LABEL$output"
}

#------------------------------------------------------------------------


function get_volume {
    volume | format | head -n1 | cut -d '%' -f 1
}

function get_volume_icon {

    num=$1
    if [ "$1" == "MUTE" ]; 
        then num=0
    fi

    if [ $num -lt 34 ]
    then
        echo "audio-volume-low"
    elif [ $num -lt 67 ]
    then
        echo "audio-volume-medium"
    elif [ $num -le 100 ]
    then
        echo "audio-volume-high"
    else
        echo "audio-volume-overamplified"
    fi
}

get_volume

