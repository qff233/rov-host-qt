import QtQuick
import QtQuick.Window
import QtQuick.Layouts

Window {
    ColumnLayout {
        anchors.fill: parent 
        Rectangle {
            color: "black"
            Layout.fillWidth: true
            Label {
                id: url_label
                text: "Url"
                font.pointSize: 10
                anchors.top: parent.top
            }
            TextField {
                anchors.top: url_label.bottom
                Layout.fillWidth: true
            }
        }
    } 
}
