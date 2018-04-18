import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


ToolBar{
    id: objTopToolBar
    width: parent.width
    height: QbCoreOne.os() === "android"?QbCoreOne.scale(75):QbCoreOne.scale(50)
    Column{
        anchors.fill: parent
        Item{
            id: objStatusBarPlaceHolder
            width: parent.width
            height: QbCoreOne.os() === "android"?QbCoreOne.scale(25):0
        }

        Item{
            id: objToolBarPlaceHolder
            width: parent.width
            height: parent.height - objStatusBarPlaceHolder.height
        }
    }
}
