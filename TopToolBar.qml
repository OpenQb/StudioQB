import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


ToolBar{
    id: objTopToolBar
    property alias appToolBar: objAppToolBar
    property alias appStatusBar: objAppStatusBar
    property alias appStatusBarHeight: objStatusBarPlaceHolder.height
    property bool appLeftSiderBarVisible: false
    property bool appRightSiderBarVisible: false

    signal leftSideBarClicked();
    signal rightSideBarClicked();

    Column{
        anchors.fill: parent
        Item{
            id: objStatusBarPlaceHolder
            width: parent.width
            Loader{
                id: objAppStatusBar
                anchors.fill: parent
            }
        }

        Item{
            id: objToolBarPlaceHolder
            width: parent.width
            height: parent.height - objStatusBarPlaceHolder.height

            ToolButton{
                id: objLeftSideBarButton
                anchors.left: parent.left
                anchors.top: parent.top
                height: parent.height
                width: height
                text: "L"
                visible: appLeftSiderBarVisible
                onClicked: {
                    leftSideBarClicked();
                }
            }

            ToolButton{
                id: objRightSideBarButton
                anchors.right: parent.right
                anchors.top: parent.top
                height: parent.height
                width: height
                text: "R"
                visible: appRightSiderBarVisible
                onClicked: {
                    rightSideBarClicked();
                }
            }

            Loader{
                id: objAppToolBar
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: objLeftSideBarButton.visible?objLeftSideBarButton.right:parent.left
                anchors.right: objRightSideBarButton.visible?objRightSideBarButton.left:parent.right
            }
        }
    }
}
