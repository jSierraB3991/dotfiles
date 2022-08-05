#!/bin/bash

DATA_LOCAL="$HOME/.local/data"

function showNotification() {
while sleep 3; do
    ids_noti=$(echo "SELECT id FROM Notifications WHERE deleted = false ORDER  BY id  DESC " | sqlite3 $DATA_LOCAL/ejemplo.db )
    output=" (box :class \"notifications-box\" :vexpand "true" :orientation \"v\" :halign \"center\" :valign \"start\" :space-evenly \"false\" :spacing \"-5\""

    for id_noti in $(echo $ids_noti); do

        urgency=$(echo "SELECT urgency FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
        body=$(echo "SELECT body FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
        title=$(echo "SELECT title FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
        application=$(echo "SELECT program FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )

        image=""
        if [ "$application" == "Brave" ];  then 
            image=$(echo "SELECT icon FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
            if [ ! -f $image ]; then
                image="/opt/brave.com/brave/product_logo_256.png"
            fi
        elif [ "$application" == "flameshot" ];  then 
            image="/usr/share/icons/Papirus/64x64/apps/flameshot.svg"
        elif [ "$application" == "Slack" ];  then 
            image="/usr/share/icons/Papirus/64x64/apps/slack.svg"
        elif [ "$application" == "Siduction" ] || [ "$application" == "Siduction" ]; then 
            image="/usr/share/icons/Papirus/64x64/apps/debian-logo.svg"
        else
            image=$(echo "SELECT icon FROM Notifications WHERE id = $id_noti" | sqlite3 $DATA_LOCAL/ejemplo.db )
            if [ "$image" == "dialog-information" ]; then
                image="/usr/share/icons/Papirus/48x48/status/dialog-information.svg"
            fi
        fi

        classUrgency="notification-card-NORMAL"
        if [ "$urgency" == "LOW" ]; then
            classUrgency="notification-card-LOW"
        elif [ "$urgency" == "CRITICAL" ]; then
            classUrgency="notification-card-CRITICAL"
        fi

        CONFIG_EWW="$HOME/.config/eww/notification"
        boxContainer="(box :space-evenly false :orientation \"vertical\""
        imageNoti="(image :valign \"start\" :vexpand false :image-width 60 :image-height 60 :class \"notification-image\" :path \"$image\" )"
        output=$(echo "$output $boxContainer (box :space-evenly \"true\" :orientation \"h\" :class" \
            "\"notification-card-header-box\" (label :class \"notification-app-name\" :text \"${application}\"" \
            " :halign \"start\") (button :onclick \"$CONFIG_EWW/scripts/notifications.sh rm_id $id_noti\" "\
            " :class \"notification-card-notify-close\" :halign \"end\" "\
            " (label :text \" \" :tooltip \"Remove this notification.\"))) (box :class \"notification-card-eventbox\" :orientation \"horizontal\" $imageNoti (box :orientation \"vertical\""\
            " :class $classUrgency :space-evenly false :hexpand true :class \"notification-card-box\"" \
            " (box :space-evenly false (label :limit-width 25 :wrap true  :text \"$title\"" \
            " :class \"notification-summary\" :halign \"start\" :hexpand true))" \
            " (label :limit-width 30 :wrap true :text \"$body\" :halign \"start\" :class \"notification-body\"))))")
    done
    CONFIG_EWW="$HOME/.config/eww/notification"
    clearAll="(button :onclick \"$CONFIG_EWW/scripts/notifications.sh clear\" :halign \"end\" :class \"notification-headers-clear\" \"Clear All\" )"
    #echo "$output $clearAll)"
    if [ "$ids_noti" == "" ]; then
      echo "(box :class \"notifications-empty-box\" :height 660 :orientation \"vertical\" :space-evenly \"false\"" \
       " (image :class \"notifications-empty-banner\" :valign \"end\" :vexpand true :path \"$CONFIG_EWW/images/no-notifications.svg\"" \
       ":image-width 300 :image-height 300) (label :vexpand true :valign \"start\" :wrap true :class \"notifications-empty-label\" :text \"No Notifications \"))"
    else
      content=$(echo "$output)")
      echo "(scroll :height 1000 :vscroll true  $content )"
    fi
    

done
}

function clearAllNotification() {
    echo "UPDATE Notifications SET deleted = true" | sqlite3 $DATA_LOCAL/ejemplo.db
}

function removeNotification() {
    echo "UPDATE Notifications SET deleted = true WHERE id = $1" | sqlite3 $DATA_LOCAL/ejemplo.db
}

if [ "$1" == "show" ]; then
    showNotification
elif [ "$1" == "clear" ]; then
    clearAllNotification
elif [ "$1" == "rm_id" ]; then
    removeNotification $2
fi
