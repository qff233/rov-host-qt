import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./qml"
import "./qml/slave_window"

ApplicationWindow {
    property string titleStr: "水下机器人上位机"

    id: main_window

    width: 1280
    height: 720

    visible: true
    title: titleStr
    minimumWidth: 1280
    minimumHeight: 720

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        MenuBar {
            id: menu_bar
            Layout.fillWidth: true
            font.family: "Microsoft YaHei"
            font.pointSize: 10

            MenuBarItem {
                text: "同步拍照"
            }
            MenuBarItem {
                text: "同步录制"
            }
            MenuBarItem {
                text: "首选项"
            }
            MenuBarItem {
                text: "关于"
                onTriggered: about_window.visible ? about_window.visible
                                                = false : about_window.visible = true
            }
        }

        //    GridLayout {}
        SlaveWindow {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    AboutWindow {
        id: about_window
        visible: false
    }
}
