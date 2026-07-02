import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "config.js" as Config

Scope {
    id: root
    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: n => {
            console.log("got: ", n.summary, "----", n.body)
            n.tracked = true
        }
    }
    PanelWindow {
        anchors { top: true; right: true }
        margins { top: 12; right: 12 }

        implicitWidth: 380
        implicitHeight: Math.max(1, column.implicitHeight)

        color: "transparent"

        exclusionMode: ExclusionMode.Ignore
    }
}

