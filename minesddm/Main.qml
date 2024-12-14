import QtQml.Models 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "components"

Rectangle {
    id: root

    // Session properties. Please look at the SessionHandler.qml file to understand hwo these properties work
    property int sessionIndex: sessionModel.lastIndex
    property var sessions: []
    // Define a mapping of actions to their corresponding methods and availability
    property var actionMap: ({
        "Power Off": {
            "enabled": sddm.canPowerOff,
            "method": sddm.powerOff
        },
        "Reboot": {
            "enabled": sddm.canReboot,
            "method": sddm.reboot
        },
        "Suspend": {
            "enabled": sddm.canSuspend,
            "method": sddm.suspend
        },
        "Hibernate": {
            "enabled": sddm.canHibernate,
            "method": sddm.hibernate
        },
        "Hybrid Sleep": {
            "enabled": sddm.canHybridSleep,
            "method": sddm.hybridSleep
        }
    })
    property var actionKeys: Object.keys(root.actionMap)
    property int currentActionIndex: 0

    height: Screen.height
    width: Screen.width

    // Load the minecraft font
    FontLoader {
        id: minecraftFont

        source: "resources/MinecraftRegular-Bmg3.otf"
    }

    // This is the background image
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

        // Username field
        InputContainer {
            label: "World Name"

            UsernameTextField {
                id: usernameTextField

                text: userModel.lastUser
                onAccepted: loginButton.clicked()
            }

        }

        // Password field
        InputContainer {
            label: "Seed"

            PasswordTextField {
                id: passswordTextField

                focus: true
                onAccepted: loginButton.clicked()
            }

        }

        // Session selector button
        // Please look at the SessionHandler.qml file to understand what is happening here
        CustomButton {
            text: "Session: " + root.sessions[root.sessionIndex].name
            onCustomClicked: {
                root.sessionIndex = (root.sessionIndex + 1) % sessionModel.count;
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
            }

            SessionHandler {
                // Please look at the SessionHandler.qml file to understand what is happening here

            }

        }

    }

    Row {
        spacing: config.itemsSpacing

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: config.itemsSpacing
            // Offset to ignore the size of the small button for centering
            horizontalCenterOffset: config.itemHeight
        }

        // Login button
        CustomButton {
            id: loginButton

            text: "Login"
            enabled: usernameTextField.text !== "" && passswordTextField.text !== ""
            onCustomClicked: {
                console.log("login button clicked");
                sddm.login(usernameTextField.text, passswordTextField.text, root.sessionIndex);
            }
        }

        // Do Action button
        CustomButton {
            text: root.actionKeys[root.currentActionIndex]
            onCustomClicked: {
                var action = root.actionMap[root.actionKeys[root.currentActionIndex]];
                if (action.enabled)
                    action.method();

            }
        }

        // Action selector button
        CustomButton {
            text: "->"
            width: config.itemHeight
            onCustomClicked: {
                root.currentActionIndex = (root.currentActionIndex + 1) % root.actionKeys.length;
            }
        }

    }

    Connections {
        function onLoginFailed() {
            passswordTextField.text = "";
            passswordTextField.focus = true;
        }

        target: sddm
    }

}
