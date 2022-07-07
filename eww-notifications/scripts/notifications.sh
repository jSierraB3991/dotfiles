#!/bin/bash

DATA_LOCAL="$HOME/.local/data"

function showNotification() {
    
    ids_noti=$(echo "SELECT id FROM Notifications WHERE deleted = false" | sqlite3 $DATA_LOCAL/ejemplo.db )
    output=" (box :class \"notifications-box\" :orientation \"v\" :halign \"center\" :valign \"start\" :space-evenly \"false\" :spacing \"-5\""

    for id_noti in $(echo $ids_noti); do

        urgency=$(echo "SELECT urgency FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
        body=$(echo "SELECT body FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
        title=$(echo "SELECT title FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
        application=$(echo "SELECT program FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )

        image=""
        if [ "$application" == "Brave" ]; then 
            image="/opt/brave.com/brave/product_logo_32.png"
        else
            image=$(echo "SELECT icon FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
            if [ -f $image ]; then
                image="/opt/brave.com/brave/product_logo_32.png"
            fi
        fi

        classUrgency="notification-card-NORMAL"
        if [ "$urgency" == "LOW" ]; then
            classUrgency="notification-card-LOW"
        elif [ "$urgency" == "CRITICAL" ]; then
            classUrgency="notification-card-CRITICAL"
        fi

        CONFIG_EWW="$HOME/.config/eww/notification"
        output=$(echo "$output (box :space-evenly \"true\" :orientation \"h\" :class" \
            "\"notification-card-header-box\" (label :class \"notification-app-name\" :text \"${application}\"" \
            " :halign \"start\") (button :onclick \"$CONFIG_EWW/scripts/notifications.sh rm_id $id_noti\" "\
            " :class \"notification-card-notify-close\" :halign \"end\" "\
            " (label :text \" \" :tooltip \"Remove this notification.\"))) (box :orientation \"vertical\""\
            " :class $classUrgency :space-evenly false :hexpand true :class \"notification-card-box\"" \
            " (box :space-evenly false (label :limit-width 25 :wrap true  :text \"$title\"" \
            " :class \"notification-summary\" :halign \"start\" :hexpand true))" \
            " (label :limit-width 30 :wrap true :text \"$body\" :halign \"start\" :class \"notification-body\"))")
    done
    echo "$output)"
}

function clearAllNotification() {
    echo "UPDATE Notifications SET deleted = true" | sqlite3 $DATA_LOCAL/ejemplo.db
}

function removeNotification() {
    echo "UPDATE Notifications SET deleted = true WHERE id = $1" | sqlite3 $DATA_LOCAL/ejemplo.db
    ~/Source/dotfiles/i3/scripts/run-notification-center.sh
    ~/Source/dotfiles/i3/scripts/run-notification-center.sh
}

if [ "$1" == "show" ]; then
    showNotification
elif [ "$1" == "clear" ]; then
    clearAllNotification
elif [ "$1" == "rm_id" ]; then
    removeNotification $2
fi
