import Qb 1.0
import Qb.Core 1.0
import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./../../ZeUi" as ZeUi

Item {
    id: objField

    activeFocusOnTab: true
    width: 200
    height: 40

    property string label: "Label"
    property int labelWidth: 20
    property bool fieldReadOnly: false
    property bool isFixedWidthForLabel:false

    property int radious: 0
    property int borderWidth: 0
    property color borderColor: ZeUi.ZBTheme.accent
    property color backgroundColor: ZeUi.ZBTheme.background

    Rectangle{
        id: objBackground
        anchors.fill: parent
        anchors.centerIn: parent
        radius: objField.radious
        color: objField.backgroundColor
        border.width: objField.borderWidth
        border.color:objField.borderColor
    }
}
