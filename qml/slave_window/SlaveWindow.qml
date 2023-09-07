import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Rectangle {
    RowLayout {
        anchors.fill: parent

        Setting {
            id: slave_setting
            visible: false

            Layout.fillHeight: true
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // MouseArea {}
            VideoOutput {
                id: video_output
                anchors.fill: parent
                z: 0
            }

            FlowBar {
                z: 1
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
            }
            color: "Black"
        }
    }
}
