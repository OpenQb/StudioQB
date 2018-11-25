import Qb 1.0
import Qb.Core 1.0
import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2


import "./../../ZeUi" as ZeUi


Item {
    id: objCTextField

    property bool fieldReadOnly: false
    property alias textInput: objTextField
    property alias text: objTextField.text
    property alias validator: objTextField.validator
    property alias inputMask: objTextField.inputMask
    activeFocusOnTab: true

    property int fontSize: 15
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
            color: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
        }
        Rectangle{
            x: objMainRow.width - objCTextField.radius
            height: parent.height
            radius: objCTextField.radius
            width: objCTextField.radius*2
            color: ZeUi.ZBTheme.primary
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
                width: parent.height
                height: parent.height
                clip: true
                color: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                Text{
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    height: parent.height
                    width: parent.width
                    color: ZeUi.ZBTheme.primary
                    text: QbMF3.icon("mf-search")
                    font.pixelSize: parent.height*0.50
                    font.family: QbMF3.family
                }
            }
            Rectangle{
                width: parent.width - objLabelField.width - objCTextField.radius
                height: parent.height
                color: ZeUi.ZBTheme.primary
                TextInput {
                    id: objTextField
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    clip: true
                    verticalAlignment: TextInput.AlignVCenter
                    activeFocusOnPress: true
                    selectionColor: "lightblue"
                    selectedTextColor: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                    color: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                    font.pixelSize: objCTextField.fontSize
                    readOnly: objCTextField.fieldReadOnly
                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            objTextField.forceActiveFocus();
                        }
                        onClicked: {
                            objTextField.forceActiveFocus();
                        }
                    }
                }
            }
        }
    }
}
