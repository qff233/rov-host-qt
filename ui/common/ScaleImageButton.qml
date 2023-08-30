import QtQuick
import QtQuick.Controls.Fusion

Button {
    id: container
    implicitWidth: 30
    implicitHeight: 30
    property bool shrink: true
    property string normalImage: ''
    property string maxImage: ''

    property string backHoverColor: '#20334455'
    property string backColor: 'transparent'

    clip: true
    padding: 0
    background: Rectangle {
        anchors.fill: parent
        color: container.hovered ? backHoverColor : backColor
        Image {
           anchors.fill: parent
           anchors.margins: container.padding
           antialiasing: true
           source: shrink ? normalImage : maxImage
           // fillMode: Image.PreserveAspectFit
       }
   }

   onClicked: {
       shrink = !shrink
   }
}
