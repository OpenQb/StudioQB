import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

import Qb 1.0
import Qb.Core 1.0

import "ZeUi" 1.0 as ZeUi


ZeUi.ZSOneAppUi{
    id: objMainAppUi
    dockLogo: objMainAppUi.absoluteURL("/images/StudioQB.png")
    changeWindowPosition: true

    QbSettings{
        id: objSettings
        name: "StudioQB"
        property alias windowWidth: objMainAppUi.windowWidth
        property alias windowHeight: objMainAppUi.windowHeight
        property alias windowX: objMainAppUi.windowX
        property alias windowY: objMainAppUi.windowY
    }

    Component.onCompleted: {
        objMainAppUi.addPage("/pages/ProjectsPage.qml",{});
    }
}
