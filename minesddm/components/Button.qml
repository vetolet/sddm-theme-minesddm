import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    id: button

    property string text: ""

    signal customClicked()

    width: 400
    height: 50
    source: "../images/button_background.png"
    fillMode: Image.Stretch

    MouseArea {
        onClicked: {
            button.customClicked();
        }

        anchors {
            fill: parent
        }

        Text {
            text: button.text
            color: config.lightText

            anchors {
                centerIn: parent
            }

            font {
                family: minecraftFont.name
                pixelSize: config.fontPixelSize
            }

        }

    }

}
