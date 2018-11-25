import Qb 1.0
import Qb.Core 1.0
import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./../../ZeUi" as ZeUi

Item {
    id: objCTextField

    property string label: "Label"
    property int labelWidth: 20
    property bool fieldReadOnly: false
    property bool isFixedWidthForLabel:false

    property alias textInput: objTextField
    property alias text: objTextField.text
    property alias validator: objTextField.validator
    property alias inputMask: objTextField.inputMask
    property alias inputMethodHints: objTextField.inputMethodHints

    property int fontSize: 15
    property int radius: 0
    property alias font: objTextField.font
    activeFocusOnTab: true
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
                clip: true

                TextInput {
                    id: objTextField
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 5
                    //clip: true
                    verticalAlignment: TextInput.AlignVCenter
                    activeFocusOnPress: true
                    selectionColor: "lightblue"
                    selectedTextColor: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                    color: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                    font.pixelSize: objCTextField.fontSize
                    readOnly: objCTextField.fieldReadOnly
                    Keys.onReturnPressed: nextItemInFocusChain().forceActiveFocus(Qt.TabFocusReason)
                    Keys.onEnterPressed: nextItemInFocusChain().forceActiveFocus(Qt.TabFocusReason)
                    MouseArea{
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            var startPosition = objTextField.positionAt(mouse.x, mouse.y);
                            objTextField.cursorPosition = startPosition;
                            objTextField.forceActiveFocus();
                            if (mouse.button === Qt.RightButton){
                                objContextMenu.popup(mouse.x,mouse.y);
                            }
                        }
                        onPressed: {
                            var startPosition = objTextField.positionAt(mouse.x, mouse.y);
                            objTextField.cursorPosition = startPosition;
                            objTextField.forceActiveFocus();
                        }

                    }
                    Menu{
                        id: objContextMenu
                        //x: parent.width - width
                        MenuItem {
                            text: "Paste"
                            onTriggered: {
                                objTextField.text = QbCoreOne.textFromClipboard();
                            }
                        }
                        MenuItem {
                            text: "Copy"
                            onTriggered: {
                                QbCoreOne.copyTextToClipboard(objTextField.text);
                            }
                        }
                        MenuItem {
                            text: "Close"
                            onTriggered: {
                                objContextMenu.close();
                            }
                        }
                    }
                }
            }
        }
    }
}
