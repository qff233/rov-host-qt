import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Rectangle {
    property int tool_bar_width: 40 
    
    MouseArea {
        anchors.fill: parent
        width: tool_bar_width
        onMouseXChanged: mouseX <= tool_bar_width ? tool_bar.visible = true : tool_bar.visible = false
    }
    RowLayout {
        anchors.fill: parent
        spacing: 0
        SlaveToolBar {
            id: tool_bar 
            visible: true

            Layout.preferredWidth: tool_bar_width
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
