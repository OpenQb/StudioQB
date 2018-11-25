import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./../../ZeUi" as ZeUi

Item {
    id: objCTextField

    property string label: "Label"
    property int labelWidth: 20
    property bool isFixedWidthForLabel:false

    property alias text: objTextField.text

    property int fontSize: 15
    property alias font: objTextField.font
    property int radius: 0
    width: 200
    height: 40
    onActiveFocusChanged: {
        if(activeFocus){
            objTextField.forceActiveFocus();
        }
    }


    Rectangle{
        anchors.fill: parent
        //color: ZeUi.ZBTheme.primary
        radius: objCTextField.radius
        color: "transparent"
        Rectangle{
            height: parent.height
            radius: objCTextField.radius
            width: objCTextField.radius*2
            color: ZeUi.ZBTheme.background
        }
        Rectangle{
            x: objMainRow.width - objCTextField.radius
            height: parent.height
            radius: objCTextField.radius
            width: objCTextField.radius*2
            color: ZeUi.ZBTheme.background
        }
        Row{
            id: objMainRow
            x: objCTextField.radius
            height: parent.height
            width: parent.width - objCTextField.radius
            spacing: 0
            clip: true

            Rectangle{
                id: objLabelField
                width: objCTextField.isFixedWidthForLabel?objCTextField.labelWidth:parent.width*(objCTextField.labelWidth/100.0)
                height: parent.height
                clip: true
                color: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                Text{
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    width: parent.width
                    color: ZeUi.ZBTheme.primary
                    text: objCTextField.label
                    font.pixelSize: objCTextField.fontSize
                }
            }
            Rectangle{
                width: parent.width - objLabelField.width - objCTextField.radius
                height: parent.height
                color: ZeUi.ZBTheme.foreground
                Text {
                    id: objTextField
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    clip: true
                    verticalAlignment: TextInput.AlignVCenter
                    color: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                    font.pixelSize: objCTextField.fontSize
                    elide: Text.ElideRight
                }
            }
        }
    }
}
