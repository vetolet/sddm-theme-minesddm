import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: customButton

    signal customClicked()

    width: config.buttonWidth
    height: config.itemHeight
    enabled: true
    hoverEnabled: true
    onClicked: {
        customButton.customClicked();
    }
    states: [
        State {
            name: "hovered"
            when: customButton.hovered

            PropertyChanges {
                target: customButtonBackground
                source: "../images/selected_button_background.png"
            }

            PropertyChanges {
                target: customButtonShadowText
                color: config.selectedShadowText
            }

            PropertyChanges {
                target: customButtonText
                color: config.selectedText
            }

        },
        State {
            name: "disabled"
            when: !customButton.enabled

            PropertyChanges {
                target: customButtonBackground
                source: "../images/disabled_button_background.png"
            }

            PropertyChanges {
                target: customButtonShadowText
                opacity: 0
            }

            PropertyChanges {
                target: customButtonText
                color: config.darkText
            }

        }
    ]

    Text {
        id: customButtonShadowText

        text: customButton.text
        color: config.shadowText
        z: -1

        anchors {
            centerIn: parent
            horizontalCenterOffset: 2.5
            verticalCenterOffset: 2.5
        }

        font {
            family: minecraftFont.name
            pixelSize: config.fontPixelSize
        }

    }

    contentItem: Text {
        id: customButtonText

        text: customButton.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.lightText

        font {
            family: minecraftFont.name
            pixelSize: config.fontPixelSize
        }

    }

    background: Image {
        id: customButtonBackground

        source: "../images/button_background.png"
    }

}
