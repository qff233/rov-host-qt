import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "./common"

Rectangle {
    id: window_title

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onDoubleClicked: scaleInput.clicked()
    }

    RowLayout {
        z: 2
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.margins: 0

        spacing: 0

        Text {
            text: main_window.title
            font.pixelSize: 20
            color: "black"
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.leftMargin: 15
        }

        ImageButton {
            imageSrc: "qrc:/res/angle-down.png"
            Layout.alignment:  Qt.AlignVCenter | Qt.AlignRight
            backHoverColor: "#22FFFFFF"

            onClicked: main_window.showMinimized()
            padding: 1
        }

        ScaleImageButton  {
            id: scaleInput
            normalImage: "/res/expand-arrows-alt.png"
            maxImage: "/res/compress-arrows-alt.png"
            Layout.alignment:  Qt.AlignVCenter | Qt.AlignRight
            backHoverColor:"#22FFFFFF"
            focusPolicy: Qt.NoFocus

            onShrinkChanged: {
                main_window.maximized = !shrink
                main_window.update();
            }
            padding:1
        }

        ImageButton {
            imageSrc: "qrc:/res/times.png"
            Layout.alignment:  Qt.AlignVCenter | Qt.AlignRight
            backHoverColor: "#22FFFFFF"

            onClicked: main_window.close()
            padding: 1
        }
    }
}
