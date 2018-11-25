import Qb 1.0
import Qb.Core 1.0
import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./../../ZeUi" as ZeUi

Item {
    id: objCTextField

    width: 200
    height: 40
    property string label: "Label"
    property int labelWidth: 20
    property bool isFixedWidthForLabel:false
    property bool fieldReadOnly: false
    property int fontSize: 15
    activeFocusOnTab: true

    property alias textEdit: objTextField
    property alias text: objTextField.text
    property int radius: 0
    property alias font: objTextField.font
    property alias inputMethodHints: objTextField.inputMethodHints

    onActiveFocusChanged: {
        if(activeFocus){
            objTextField.forceActiveFocus();
        }
    }

    Rectangle{
        anchors.fill: parent
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
                radius: 0
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

                Flickable {
                    id: objFlickView
                    clip: true
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    anchors.rightMargin: 5
                    pixelAligned: true
                    flickableDirection: Flickable.VerticalFlick
                    function ensureVisible(cursor)
                    {
                        if (objTextField.currentLine === 1)
                            contentY = 0
                        else if (objTextField.currentLine === objTextField.lineCount && objFlickView.visibleArea.heightRatio < 1)
                            contentY = contentHeight - height
                        else
                        {
                            if (contentY >= cursor.y)
                                contentY = cursor.y
                            else if (contentY + height <= cursor.y + cursor.height)
                                contentY = cursor.y + cursor.height - height
                        }
                    }

                    TextEdit {
                        id: objTextField
                        width: parent.width
                        anchors.left: parent?parent.left:undefined
                        anchors.leftMargin: 10
                        activeFocusOnPress: true
                        selectionColor: "lightblue"
                        selectedTextColor: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                        color: ZeUi.ZBTheme.metaTheme.darker(ZeUi.ZBTheme.background,80)
                        font.pixelSize: objCTextField.fontSize
                        readOnly: objCTextField.fieldReadOnly
                        wrapMode: TextEdit.WrapAnywhere
                        property int currentLine: cursorRectangle.y / cursorRectangle.height + 1
                        onCurrentLineChanged: {
                            objFlickView.ensureVisible(cursorRectangle);
                        }
                        onContentHeightChanged: {
                            objFlickView.contentHeight = contentHeight;
                        }
                        Keys.onTabPressed: nextItemInFocusChain().forceActiveFocus(Qt.TabFocusReason)
                        Keys.onReturnPressed: nextItemInFocusChain().forceActiveFocus(Qt.TabFocusReason)
                        Keys.onEnterPressed: nextItemInFocusChain().forceActiveFocus(Qt.TabFocusReason)
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
            }
        }
    }
}
