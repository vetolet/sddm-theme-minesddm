import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Rectangle {
    id: root

    // Font properties
    property string globalFontFamily: minecraftFont.name
    property int globalFontPixelSize: 24
    property string lightText: "white"
    property string darkText: "#AAAAAA"
    property int labelFieldSpacing: 8
    property int itemsSpacing: 20
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

        spacing: root.itemsSpacing

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: root.itemsSpacing * 2
        }

        // Main title
        Text {
            text: "Log in to session"
            font.family: root.globalFontFamily
            font.pixelSize: root.globalFontPixelSize
            color: root.lightText
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Spacer Rectangle between title and input fields
        Rectangle {
            width: parent.width
            height: root.itemsSpacing * 0.5
            color: "transparent" // Invisible spacer
        }

        // Username label and field container
        Column {
            spacing: root.labelFieldSpacing

            Text {
                text: "World Name"
                font.family: root.globalFontFamily
                font.pixelSize: root.globalFontPixelSize
                color: root.darkText
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
                    font.family: root.globalFontFamily
                    font.pixelSize: root.globalFontPixelSize
                    color: root.lightText
                    placeholderText: "Username_"
                    placeholderTextColor: root.darkText
                    background: null
                    // Set focus to the username field by default
                    focus: true
                }

            }

        }

        // Password label and field container
        Column {
            spacing: root.labelFieldSpacing

            Text {
                text: "Seed"
                font.family: root.globalFontFamily
                font.pixelSize: root.globalFontPixelSize
                color: root.darkText
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
                    font.family: root.globalFontFamily
                    font.pixelSize: root.globalFontPixelSize
                    color: root.lightText
                    placeholderText: "Password_"
                    placeholderTextColor: root.darkText
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
                    color: root.lightText
                    font.family: root.globalFontFamily
                    font.pixelSize: root.globalFontPixelSize
                }

            }

        }

    }

    // Buttons container
    Row {
        spacing: root.itemsSpacing
        // offset to make login and action buttons aligned. This it to ignore the select action button
        anchors.horizontalCenterOffset: 50

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: root.itemsSpacing
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
                    color: root.lightText
                    font.family: root.globalFontFamily
                    font.pixelSize: root.globalFontPixelSize
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
                    color: root.lightText
                    font.family: root.globalFontFamily
                    font.pixelSize: root.globalFontPixelSize
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
                    color: root.lightText
                    font.family: root.globalFontFamily
                    font.pixelSize: root.globalFontPixelSize
                }

            }

        }

    }

}
//