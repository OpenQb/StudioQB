import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


ToolBar{
    id: objTopToolBar
    property alias appLogo: objLogo.source
    property alias appToolBar: objAppToolBar
    property alias appStatusBar: objAppStatusBar
    property alias appStatusBarHeight: objStatusBarPlaceHolder.height
    property bool appLeftSiderBarVisible: false
    property bool appRightSiderBarVisible: false
    property bool appBackButtonVisible: false

    signal leftSideBarClicked();
    signal rightSideBarClicked();
    signal backClicked();
    Material.elevation: 5

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
            Item{
                id: objLogoPlaceHolder
                width: objBackButton.visible?parent.height*2:parent.height
                height: parent.height
                Image{
                    id: objLogo
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    width: parent.height
                    height: parent.height
                    smooth: true
                    mipmap: true
                    fillMode: Image.Image.PreserveAspectFit
                }
                ToolButton{
                    id: objBackButton
                    anchors.right: parent.right
                    anchors.top: parent.top
                    height: parent.height
                    width: height
                    visible: appBackButtonVisible
                    text: QbMF3.icon("mf-keyboard_arrow_left")
                    font.family: QbMF3.family
                    onClicked: {
                        backClicked();
                    }
                }
            }

            ToolButton{
                id: objLeftSideBarButton
                anchors.left: objLogoPlaceHolder.right
                anchors.top: parent.top
                height: parent.height
                width: height
                text: QbMF3.icon("mf-menu")
                font.family: QbMF3.family
                visible: appLeftSiderBarVisible
                onClicked: {
                    leftSideBarClicked();
                    if(rotation == 0){
                        rotation = 90;
                    }
                    else{
                        rotation = 0;
                    }
                }
                Behavior on rotation{
                    NumberAnimation{duration: 150}
                }
            }

            ToolButton{
                id: objRightSideBarButton
                anchors.right: parent.right
                anchors.top: parent.top
                height: parent.height
                width: height
                text: QbMF3.icon("mf-menu")
                font.family: QbMF3.family
                visible: appRightSiderBarVisible
                onClicked: {
                    rightSideBarClicked();
                    if(rotation == 0){
                        rotation = 90;
                    }
                    else{
                        rotation = 0;
                    }
                }
                Behavior on rotation{
                    NumberAnimation{duration: 150}
                }
            }

            Loader{
                id: objAppToolBar
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: objLeftSideBarButton.visible?objLeftSideBarButton.right:objLogoPlaceHolder.right
                anchors.right: objRightSideBarButton.visible?objRightSideBarButton.left:parent.right
            }
        }
    }
}
