import QtQuick
import QtQuick.Layouts

Rectangle {
    id: window_entry
    color: "#FFF"
    gradient: Gradient {
        orientation: Gradient.Horizontal;
        GradientStop { position: 0.0; color: "#12B4FF" }
        GradientStop { position: 0.15; color: "#3297FF" }
        GradientStop { position: 1.0; color: "#B822FF" }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        WindowTitle {
            color: "transparent"
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.alignment: Qt.AlignTop
            clip: true
        }
        Slave {
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
        }
    }

    SequentialAnimation {
        running: true
        NumberAnimation {
            target: window_entry;
            properties: "scale"; from: 0.3; to: 1.0; easing.type: Easing.InOutQuad; duration: 200
        }
    }
}
