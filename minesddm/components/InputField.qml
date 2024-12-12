import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    id: inputField

    property string label: ""
    property string placeholder: ""

    spacing: config.labelFieldSpacing

    Text {
        text: inputField.label
        color: config.darkText

        font {
            family: minecraftFont.name
            pixelSize: config.fontPixelSize
        }

    }

    Rectangle {
        id: usernameFieldContainer

        width: 500
        height: 50
        color: "black"

        border {
            color: "white"
            width: 2.5
        }

        TextField {
            id: usernameField

            color: config.lightText
            placeholderText: inputField.placeholder
            placeholderTextColor: config.darkText
            background: null

            anchors {
                fill: parent
                margins: 4
            }

            font {
                family: minecraftFont.name
                pixelSize: config.fontPixelSize
            }

        }

    }

}
