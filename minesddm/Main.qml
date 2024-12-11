import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Rectangle {
    id: root

    // Property to hold session list and current index
    property var sessions: ["Hyprland", "Sway", "i3w", "Gnome"]
    property int currentSessionIndex: 0
    // Property for action list and current index
    property var actions: ["Turn Off", "Sleep", "Hibernate", "Reboot"]
    property int currentActionIndex: 0

    height: Screen.height
    width: Screen.width

    // Load the Minecraft font globally
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
            font.family: minecraftFont.name
            font.pixelSize: config.fontPixelSize
            color: config.lightText
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Spacer Rectangle between title and input fields
        Rectangle {
            width: parent.width
            height: config.itemsSpacing * 0.5
            color: "transparent" // Invisible spacer
        }

        // Username label and field container
        Column {
            spacing: config.labelFieldSpacing

            Text {
                text: "World Name"
                font.family: minecraftFont.name
                font.pixelSize: config.fontPixelSize
                color: config.darkText
            }

            Rectangle {
                id: usernameFieldContainer

                width: 500
                height: 50
                color: "black"
                border.color: "white"
                border.width: 2.5

                TextField {
                    id: usernameField

                    anchors.fill: parent
                    anchors.margins: 4
                    font.family: minecraftFont.name
                    font.pixelSize: config.fontPixelSize
                    color: config.lightText
                    placeholderText: "Username_"
                    placeholderTextColor: config.darkText
                    background: null
                    // Set focus to the username field by default
                    focus: true
                }

            }

        }

        // Password label and field container
        Column {
            spacing: config.labelFieldSpacing

            Text {
                text: "Seed"
                font.family: minecraftFont.name
                font.pixelSize: config.fontPixelSize
                color: config.darkText
            }

            Rectangle {
                id: passwordFieldContainer

                width: 500
                height: 50
                color: "black"
                border.color: "white"
                border.width: 2.5

                TextField {
                    id: passwordField

                    anchors.fill: parent
                    anchors.margins: 4
                    font.family: minecraftFont.name
                    font.pixelSize: config.fontPixelSize
                    color: config.lightText
                    placeholderText: "Password_"
                    placeholderTextColor: config.darkText
                    echoMode: TextInput.Password
                    background: null
                }

            }

        }

        // Session selector button
        Image {
            id: sessionSelectButton

            width: 500
            height: 50
            source: "images/button_background.png"
            fillMode: Image.Stretch

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Cycle through the sessions
                    currentSessionIndex = (currentSessionIndex + 1) % sessions.length;
                }

                Text {
                    anchors.centerIn: parent
                    text: "Session: " + sessions[currentSessionIndex]
                    color: config.lightText
                    font.family: minecraftFont.name
                    font.pixelSize: config.fontPixelSize
                }

            }

        }

    }

    // Buttons container
    Row {
        spacing: config.itemsSpacing
        // offset to make login and action buttons aligned. This it to ignore the select action button
        anchors.horizontalCenterOffset: 50

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: config.itemsSpacing
        }

        // Login button
        Image {
            id: loginButton

            width: 400
            height: 50
            source: "images/button_background.png"
            fillMode: Image.Stretch

            MouseArea {
                anchors.fill: parent

                Text {
                    anchors.centerIn: parent
                    text: "Login"
                    color: config.lightText
                    font.family: minecraftFont.name
                    font.pixelSize: config.fontPixelSize
                }

            }

        }

        // Do Action button
        Image {
            id: doActionButton

            width: 400
            height: 50
            source: "images/button_background.png"
            fillMode: Image.Stretch

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Action: " + actions[currentActionIndex]);
                }

                Text {
                    anchors.centerIn: parent
                    text: actions[currentActionIndex]
                    color: config.lightText
                    font.family: minecraftFont.name
                    font.pixelSize: config.fontPixelSize
                }

            }

        }

        // Action selector button (Square, ">" character)
        Image {
            id: actionSelectButton

            width: 50
            height: 50
            source: "images/button_background.png"
            fillMode: Image.Stretch

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Cycle through the actions
                    currentActionIndex = (currentActionIndex + 1) % actions.length;
                }

                Text {
                    anchors.centerIn: parent
                    text: "->"
                    color: config.lightText
                    font.family: minecraftFont.name
                    font.pixelSize: config.fontPixelSize
                }

            }

        }

    }

}
