#!/bin/bash

crunch_appname=$(echo "$1" | sed '/^$/d')
crunch_summary=$(echo "$2" | sed '/^$/d' | xargs)
crunch_body=$(echo "$3" | sed '/^$/d' | xargs)
crunch_icon=$(echo "$4" | sed '/^$/d')
crunch_urgency=$(echo "$5" | sed '/^$/d')
timestamp=$(date +"%I:%M %p")

if [[ "$crunch_appname" == "Spotify" ]]; then
    random_name=$(mktemp --suffix ".png")
    artlink=$(playerctl metadata mpris:artUrl | sed -e 's/open.spotify.com/i.scdn.co/g')
    curl -s "$artlink" -o "$random_name"
    crunch_icon=$random_name
elif [[ "$crunch_appname" == "VLC media player" ]]; then
    crunch_icon="vlc"
elif [[ "$crunch_appname" == "Calendar" ]] || [[ "$crunch_appname" == "Volume" ]] || [[ "$crunch_appname" == "Brightness" ]] || [[ "$crunch_appname" == "notify-send" ]]; then
    exit 0
fi


if [ "$(which sqlite3)" == "" ]; then
    echo -en "$timestamp\n$crunch_urgency\n$crunch_icon\n$crunch_body\n$crunch_summary\n$crunch_appname\n" >>$HOME/.cache/dunst.log
else
    if [ ! -d $HOME/.local/data ]; then
        mkdir $HOME/.local/data
    fi
    
    imgBase64=""
    if [ "$crunch_appname" == "Brave"  ]; then
        imgBase64=""
    fi
    
    if [ "$crunch_appname" == "audio" ] || [ "$crunch_appname" == "sleep" ] || [ "$crunch_appname" == "brightness" ] ; then
        data=$(echo "SELECT * FROM Notifications WHERE program = '$crunch_appname'" | sqlite3 $HOME/.local/data/ejemplo.db)
        if [ "$data" != "" ]; then
            echo "UPDATE Notifications SET body = '$crunch_body', deleted = false WHERE program = '$crunch_appname'" | sqlite3 $HOME/.local/data/ejemplo.db
        else
            echo "INSERT INTO Notifications(hora, title, body, urgency, icon, program, deleted, imgBase64) VALUES('$timestamp', '$crunch_summary', '$crunch_body', '$crunch_urgency', '$crunch_icon', '$crunch_appname', false, '$(cat $crunch_icon | base64)')" | sqlite3 $HOME/.local/data/ejemplo.db
        fi
    else
        echo "INSERT INTO Notifications(hora, title, body, urgency, icon, program, deleted, imgBase64) VALUES('$timestamp', '$crunch_summary', '$crunch_body', '$crunch_urgency', '$crunch_icon', '$crunch_appname', false, '$(cat $crunch_icon | base64)')" | sqlite3 $HOME/.local/data/ejemplo.db
    fi
    echo "" | sqlite3 $HOME/.local/data/ejemplo.db
fi

