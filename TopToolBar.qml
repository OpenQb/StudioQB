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
            Loader{
                id: objAppToolBar
                anchors.fill: parent
            }
        }
    }
}
