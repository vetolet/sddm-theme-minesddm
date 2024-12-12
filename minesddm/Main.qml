import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "components"

Rectangle {
    id: root

    property string username: usernameTextField.text
    property string password: passswordTextField.text
    // Property to hold session list and current index
    property var sessions: ["Hyprland", "Sway", "i3w", "Gnome"]
    property int currentSessionIndex: 0
    // Property for action list and current index
    property var actions: ["Power Off", "Reboot", "Suspend", "Hibernate", "Hybrid Sleep"]
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

        InputContainer {
            label: "World Name"

            UsernameTextField {
                id: usernameTextField
            }

        }

        InputContainer {
            label: "Seed"

            PasswordTextField {
                id: passswordTextField
            }

        }

        // Session selector button
        CustomButton {
            text: "Session: " + sessions[currentSessionIndex]
            onCustomClicked: {
                currentSessionIndex = (currentSessionIndex + 1) % sessions.length;
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

        }

        // Keyboard tips
        Text {
            text: "[F1] to ... | [F2] to ... | [ESC] to ..."
            color: config.darkText

            font {
                family: minecraftFont.name
                pixelSize: config.fontPixelSize
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
            // Offset to ignore the size of the small button for centering
            horizontalCenterOffset: 50
        }

        // Login button
        CustomButton {
            text: "Login"
            enabled: root.username !== "" && root.password !== ""
            onCustomClicked: {
                console.log(root.username);
                console.log(root.password);
                sddm.login(rood.user, root.password, session);
            }
        }

        // Do Action button
        CustomButton {
            text: actions[currentActionIndex]
            onCustomClicked: {
                console.log("Action: " + actions[currentActionIndex]);
            }
        }

        // Action selector button
        CustomButton {
            text: "->"
            onCustomClicked: {
                currentActionIndex = (currentActionIndex + 1) % actions.length;
            }
            width: 50
        }

    }

    Connections {
        function onLoginSucceeded() {
            coverScreen.start();
        }

        function onLoginFailed() {
            passswordTextField.text = "";
            passswordTextField.focus = true;
        }

        target: sddm
    }

}
