import QtQml.Models 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "components"

Rectangle {
    id: root

    // Login properties
    property string username: usernameTextField.text
    property string password: passswordTextField.text
    // Session properties
    property var sessions: ["Hyprland", "Sway", "i3w", "Gnome"]
    property int sessionIndex: 0
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
            id: cb

            text: "Session: "
            onCustomClicked: {
                root.sessionIndex = (root.sessionIndex + 1) % root.sessionModel.count;
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
                sddm.login(root.user, root.password, root.sessionIndex);
            }
        }

        // Do Action button
        CustomButton {
            text: root.actionKeys[root.currentActionIndex]
            onCustomClicked: {
                var action = root.actionMap[root.actionKeys[root.currentActionIndex]];
                if (action.enabled)
                    action.method();
                else
                    console.log(root.actionKeys[root.currentActionIndex] + " is not supported");
            }
        }

        // Action selector button
        CustomButton {
            text: "->"
            width: 50
            onCustomClicked: {
                root.currentActionIndex = (root.currentActionIndex + 1) % root.actionKeys.length;
            }
        }

    }

    Connections {
        function onLoginSucceeded() {
            console.log("Login succeeded"); // TODO
        }

        function onLoginFailed() {
            passswordTextField.text = "";
            passswordTextField.focus = true;
        }

        target: sddm
    }

}
