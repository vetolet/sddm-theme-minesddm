import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "components"

Rectangle {
    id: root

    // Property to hold session list and current index
    property var sessions: ["Hyprland", "Sway", "i3w", "Gnome"]
    property int currentSessionIndex: 0
    // Property for action list and current index
    property var actions: ["Poweroff", "Suspend", "Hibernate", "Reboot"]
    property int currentActionIndex: 0

    height: Screen.height
    width: Screen.width

    FontLoader {
        id: minecraftFont

        source: "resources/MinecraftRegular-Bmg3.otf"
    }

    Image {
        source: "images/dirt.png"
        fillMode: Image.PreserveAspectCrop
        clip: true

        anchors {
            fill: parent
        }

    }

    Column {
        id: loginArea

        spacing: config.itemsSpacing

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: config.itemsSpacing * 2
        }

        // Main title
        Text {
            text: "Log in to session"
            color: config.lightText

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

            font {
                family: minecraftFont.name
                pixelSize: config.fontPixelSize
            }

        }

        // Spacer Rectangle between title and input fields
        Rectangle {
            width: parent.width
            height: config.itemsSpacing * 0.5
            color: "transparent" // Invisible spacer
        }

        // Username label and field container
        InputField {
            label: "World Name"
            placeholder: "Username_"
        }

        // Password label and field container
        InputField {
            label: "Seed"
            placeholder: "Password_"
        }

        // Session selector button
        Button {
            text: "Session: " + sessions[currentSessionIndex]
            onCustomClicked: {
                currentSessionIndex = (currentSessionIndex + 1) % sessions.length;
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

        }

    }

    // Buttons container
    Row {
        spacing: config.itemsSpacing

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: config.itemsSpacing
            horizontalCenterOffset: 50
        }

        // Login button
        Button {
            text: "Login"
            onCustomClicked: {
                console.log("Logged in");
            }
        }

        // Do Action button
        Button {
            text: actions[currentActionIndex]
            onCustomClicked: {
                console.log("Action: " + actions[currentActionIndex]);
            }
        }

        // Action selector button
        Button {
            text: "->"
            onCustomClicked: {
                currentActionIndex = (currentActionIndex + 1) % actions.length;
            }
            width: 50
        }

    }

}
