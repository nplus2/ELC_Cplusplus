import QtQuick 2.0

Item {
    width: 90
    height: 90
    property alias text: text1.text
    Rectangle {
        id: rectangle
        color: "#e9e9e9"
        radius: 10
        anchors.fill: parent

        Text {
            id: text1
            x: 31
            y: 16
            text: qsTr("4")
            renderType: Text.QtRendering
            font.pixelSize: 50
        }
    }

}
