import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2


import "./../../ZeUi" as ZeUi

Button{
    id: objControl
    Material.theme: Material.Light
    contentItem: Text {
        text: objControl.text
        font: objControl.font
        opacity: enabled ? 1.0 : 0.5
        color: objControl.down ? ZeUi.ZBTheme.primary : ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    background: Rectangle {
        color: objControl.down?ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80):ZeUi.ZBTheme.primary
        opacity: enabled ? objControl.activeFocus? 1 : 0.5 : 0.1
        border.color: objControl.down ? ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80) : ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
        border.width: 1
        radius: 4
    }
}
