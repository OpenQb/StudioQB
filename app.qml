import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


QbApp {
    id: objAppUi

    onAppClosing: {

    }

    Component.onCompleted: {
        var themeOne = {};
        themeOne["primary"] = "blue";
        themeOne["secondary"] = "green";
        themeOne["accent"] = "black";
        themeOne["background"] = "white";
        themeOne["foreground"] = "black";
        themeOne["theme"] = "light";
        objAppTheme.setThemeFromJsonData(JSON.stringify(themeOne));
    }

    QbMetaTheme{
        id: objAppTheme
    }

    Pane{
        id: objContentPlaceHolder

        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0

        Material.primary: objAppTheme.primary
        Material.accent: objAppTheme.accent
        Material.background: objAppTheme.background
        Material.foreground: objAppTheme.foreground
        Material.theme: objAppTheme.theme === "dark"?Material.Dark:Material.Light

        anchors.fill: parent

        TopToolBar{
            id: objTopToolBar
            anchors.top: parent.top
        }

    }
}
