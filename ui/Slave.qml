import QtQuick
import QtQuick.Layouts

Rectangle {

    RowLayout {
        anchors.fill: parent
        anchors.rightMargin: 14
        // anchors.leftMargin: leftSidebar.isOpen ? 14 : 0
        anchors.leftMargin: 14
        anchors.topMargin: 0
        anchors.bottomMargin: 14

        Behavior on anchors.leftMargin {
            NumberAnimation { duration: 100 }
        }

        spacing: 20
//        SlaveConfig {
//            id: slave_config
//            Layout.fillHeight: true
//            Layout.preferredWidth: 198
//        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true

            radius: 8
            color: "#FFF"
        }
    }
}
