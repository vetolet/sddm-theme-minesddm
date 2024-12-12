import QtQml.Models 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

ListView {
    model: sessionModel
    // Hide and disable interaction
    enabled: false
    visible: false

    delegate: Item {
        Component.onCompleted: {
            root.sessions.push({
                "name": model.name
            });
        }
    }

}
