import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0
import "lib.js" as Lib

QbApp {
    id: objAppUi

    onAppClosing: {

    }

    Component.onCompleted: {
        Lib.objAppTheme = objAppTheme;

        Lib.objTopToolBar = objTopToolBar;
        Lib.appToolBarLoader = objTopToolBar.appToolBar;
        Lib.appStatusBarLoader = objTopToolBar.appStatusBar;

        Lib.objMainStack = objMainStack;

        Lib.objBottomToolBar = objBottomToolBar;
        Lib.appBottomBarLoader = objBottomToolBar.appBottomBar;

        Lib.objLeftSideBar = objLeftSideBar;
        Lib.objRightSideBar = objRightSideBar;

        Lib.appLeftSideBarLoader = objLeftSideBar.appSideBar;
        Lib.appRightSideBarLoader = objRightSideBar.appSideBar;

        Lib.setup(objAppUi);
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
            anchors.left: parent.left
            anchors.right: parent.right
            height: QbCoreOne.os() === "android"?QbCoreOne.scale(75):QbCoreOne.scale(50)
            appStatusBarHeight: QbCoreOne.os() === "android"?QbCoreOne.scale(25):0
            z: 10000
        }

        SideBar{
            id: objLeftSideBar
            anchors.left: parent.left
            width: 1
            z: 10000
        }

        SideBar{
            id: objRightSideBar
            anchors.right: parent.right
            width: 1
            z: 10000
        }

        StackView{
            id: objMainStack
            anchors.top: objTopToolBar.bottom
            anchors.bottom: objBottomToolBar.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        BottomToolBar{
            id: objBottomToolBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: QbCoreOne.scale(10)
            z: 10000
        }
    }
}
