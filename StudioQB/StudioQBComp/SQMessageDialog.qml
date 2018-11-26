import QtQuick 2.11
import QtQml.Models 2.11

import "./../../ZeUi" as ZeUi

import "./../StudioQBCore" as StudioQBCore


ZeUi.ZDialogUi{
    id: objMessageDialog
    title: "Message Dialog"
    enableStatusBar: true
    statusBarButtonText: "CLOSE"
    interactive: false
    onButtonClicked: {
        objMessageDialog.close();
    }
    property string message: ""

    model: ObjectModel{
        Rectangle {
            width: objMessageDialog.dialogWidth
            height: objMessageDialog.availableHeight
            color: ZeUi.ZBTheme.metaTheme.computeColorList(ZeUi.ZBTheme.metaTheme.primary)[0]
            Text{
                anchors.fill: parent
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: objMessageDialog.message
                wrapMode: Text.WordWrap
                color: ZeUi.ZBTheme.metaTheme.textColor(parent.color)
                font.bold: true
                font.pixelSize: 18
            }
        }

    }
}
