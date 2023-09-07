import QtQuick 2.5
import QtQuick.Window 2.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 2.5

Window {
    id: main_window

    property string titleStr: "水下机器人上位机"

    width: 1280
    height: 720

    visible: true
    title: titleStr
    color: "transparent"
    minimumWidth: 1280
    minimumHeight: 720

    // menu_bar: MenuBar {
    //     Menu {
    //         title: "同步操作"
    //         Action {
    //             text: "拍照"
    //         }
    //         Action {
    //             text: "录制" 
    //         }
    //     } 
    //     Menu {
    //         title: "设置"
    //     } 
    //     Menu {
    //         title: "帮助"
    //         Action {
    //             text: "关于"
    //         }
    //     }
    // }
    slaves: GridLayout {
    }
}
