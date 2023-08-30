import QtQuick
import QtQuick.Controls.Fusion

Button {
    id: container
    implicitWidth: 30
    implicitHeight: 30
    property string imageSrc: ''
    property string hoverimageSrc: ''
    property string backHoverColor: 'transparent'
    property string backColor: 'transparent'
    property alias radius: back.radius

    clip: true
    padding: 0
    background: Rectangle {
       id: back
       anchors.fill: parent
       color: container.hovered ? backHoverColor : backColor
       Image {
           anchors.centerIn: parent
           antialiasing: true
           source: container.hovered ? (!hoverimageSrc? imageSrc : hoverimageSrc) : imageSrc
           fillMode: Image.PreserveAspectFit
       }
   }
}
