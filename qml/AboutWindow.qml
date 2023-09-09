import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window {
    property string version: "0.0.1"
     
    id: about_window
    title: "关于"
    visible: true

    flags: Qt.WindowCloseButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint | Qt.MSWindowsFixedSizeDialogHint
    width: 400
    height: 360
    maximumWidth: width
    minimumWidth: width
    maximumHeight: height
    minimumHeight: height

    ColumnLayout {
        anchors.fill: parent
        Rectangle {
            Layout.preferredWidth: 120
            Layout.preferredHeight: 120
            Layout.alignment: Qt.AlignHCenter  
            color: "black"
        }
        Rectangle {
            Layout.alignment: Qt.AlignHCenter  
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "blue"
            Column {
                anchors.centerIn: parent
                
                Text {
                    text: "Rov-Host"
                }
                Text {
                    text: version
                }
                Text {
                    text: version
                }
                Text {
                    text: "<a href='http://192.168.3.190'><h1>Page</h1></a>"
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }
    }
}
