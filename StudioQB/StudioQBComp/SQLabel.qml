import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2


import "./../../ZeUi" as ZeUi


Rectangle{
    id: objLabel
    color: "#3E2723"
    property string bubbleText: ""
    property string tooltipText: ""
    property color textColor: "#FAFAFA"
    property alias font : objOLabel.font

    ToolTip{
        id: objToolTip
        text: objLabel.tooltipText
        delay: 2000
    }

    Label{
        id: objOLabel
        anchors.fill: parent
        anchors.centerIn: parent
        text: objLabel.bubbleText
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter
        color: objLabel.textColor
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            objToolTip.visible = true;
        }
        onExited: {
            objToolTip.visible = false;
        }
    }
}

