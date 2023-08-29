import QtQuick
import QtQuick.Controls

Rectangle {
    property string title_text: qsTr("水下机器人上位机")

    id: title_bar
    width: parent.width
    height: 30

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    color: "black"

    Text {
        text: title_text
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        property point clickPos: "0,0"
        property bool   isDoubleClicked:false

        onDoubleClicked: {
            isDoubleClicked = true;
            if(main_window.visibility === Window.Maximized){
                main_window.showNormal();
            }else{
                main_window.showMaximized();
            }
        }
    }

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        spacing: 5
        layoutDirection: Qt.RightToLeft
        Button {
            width: 20
            height: 20
            text: "X"
            onClicked: main_window.close()
        }

        Button {
            width: 20
            height: 20
            text: "口"
            onClicked: main_window.visibility === Window.Maximized ? main_window.showNormal() : main_window.showMaximized()
        }

        Button {
            width: 20
            height: 20
            text: "一"
            onClicked: main_window.showMinimized()
        }
    }
}
