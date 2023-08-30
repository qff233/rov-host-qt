import Rov.window

import "./ui"

FrameLessWindow {
    id: main_window

    property string titleStr: "水下机器人上位机"
    property var areas: [
            Qt.rect(0, 0, 99999, 40)
    ]

    width: 1280
    height: 720

    visible: true
    title: titleStr
    color: "transparent"
    resizable: true
    moveArea:  areas
    minimumWidth: 1280
    minimumHeight: 720

    WindowEntry {
        anchors.fill: parent
        anchors.margins: main_window.maximized ? 0 : 8
        radius: main_window.maximized ? 0 : 4
    }
}
