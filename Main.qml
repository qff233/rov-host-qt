import QtQuick
import QtQuick.Window
import QtQuick.Controls

import Rov.window

import "./ui"

FrameLessWindow {
    property bool isMoveWindow: false
    property point rootWindowTitleMousePos: Qt.point(x,y)

    property var areas: [
            Qt.rect(0, 0, 99999, 30)
    ]

    id: main_window
    width: 1280
    minimumWidth: 1280
    height: 720
    minimumHeight: 720
    visible: true
    moveArea:  areas

    onTitleChanged: rootWindowTitleBarTitleText.text = title

    TitleBar{}
}
