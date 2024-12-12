import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    id: inputContainer

    property string label: ""

    spacing: config.labelFieldSpacing

    Text {
        text: inputContainer.label
        color: config.darkText

        font {
            family: minecraftFont.name
            pixelSize: config.fontPixelSize
        }

    }

}
