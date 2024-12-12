import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: passwordTextField

    echoMode: config.hidePassword === "true" ? TextInput.Password : TextInput.Normal
    passwordCharacter: "*"
    width: config.inputWidth
    height: config.itemHeight
    color: config.lightText
    placeholderText: "Password_"
    placeholderTextColor: config.darkText

    font {
        family: minecraftFont.name
        pixelSize: config.fontPixelSize
    }

    background: TextFieldBackground {
    }

}
