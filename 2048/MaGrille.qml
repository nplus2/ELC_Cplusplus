import QtQuick 2.0

Item {
    width: 400
    height: 400

    Rectangle {
        id: rectangle
        width: 400
        height: 400
        color: "#696969"

        GridView {
            id: grid
            x: 5
            y: 5
            width: 390
            height: 390
            /*rows: 4
            columns: 4
            spacing: 10*/

            ListModel {
                id: fruitModel

                ListElement {
                    name: "Apple"
                    cost: 2.45
                }
                ListElement {
                    name: "Orange"
                    cost: 3.25
                }
                ListElement {
                    name: "Banana"
                    cost: 1.95
                }
            }
            Grid {
                id: tuileDelegate
                Item {
                    x: 5
                    y: 5
                    width: 390
                    height: 390

                    Rectangle {

                        color: "#e9e9e9"
                        radius: 10
                        anchors.fill: parent

                        Text {
                            id: text1
                            x: 31
                            y: 16
                            text: qsTr(name)
                            renderType: Text.QtRendering
                            font.pixelSize: 50
                        }
                    }
                }
            }
            ListView {
                maximumFlickVelocity: 2488
                anchors.fill: parent
                model: fruitModel
                delegate: tuileDelegate
            }


            delegate: MaTuile2{
                id : ma_tuile

            }

            /*MaTuile2 {
                    id: maTuile44
                    x: 5
                    y: 5
                }*/
        }

    }
    /*Rectangle {
        width: 200; height: 200


        ListModel {
            id: fruitModel

            ListElement {
                name: "Apple"
                cost: 2.45
            }
            ListElement {
                name: "Orange"
                cost: 3.25
            }
            ListElement {
                name: "Banana"
                cost: 1.95
            }
        }
        Component {
            id: tuileDelegate
            Item {
                width: 90
                height: 90
                Rectangle {
                    id: rectangle
                    color: "#e9e9e9"
                    radius: 10
                    anchors.fill: parent

                    Text {
                        id: text1
                        x: 31
                        y: 16
                        text: qsTr(name)
                        renderType: Text.QtRendering
                        font.pixelSize: 50
                    }
                }
            }
        }




        ListView {
            maximumFlickVelocity: 2488
            anchors.fill: parent
            model: fruitModel
            delegate: tuileDelegate
        }
    }*/

}
/*
Item {
    width: 90
    height: 90
    Rectangle {
        id: rectangle
        color: "#e9e9e9"
        radius: 10
        anchors.fill: parent

        Text {
            id: text1
            x: 31
            y: 16
            text: qsTr("2")
            renderType: Text.QtRendering
            font.pixelSize: 50
        }
    }
}

  */
