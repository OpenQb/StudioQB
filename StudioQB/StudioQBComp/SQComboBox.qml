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

    property alias fieldText: objComboBox.currentText
    property alias comboBoxModel: objComboBox.model

    property string label: "Label"
    property int labelWidth: 20
    property bool fieldReadOnly: false
    property bool isFixedWidthForLabel:false
    property bool useAlternateColor: false

    property int radious: 0
    property int borderWidth: 0
    property color borderColor: ZeUi.ZBTheme.accent
    property color backgroundColor: ZeUi.ZBTheme.background

    property color labelFieldBackgroundColor: useAlternateColor? ZeUi.ZBTheme.metaTheme.analagousColor(ZeUi.ZBTheme.accent)[0]:ZeUi.ZBTheme.accent
    property color labelFieldColor: ZeUi.ZBTheme.accent
    property color labelFieldTextColor: ZeUi.ZBTheme.metaTheme.textColor(labelFieldBackgroundColor)

    property color comboBoxBackgroundColor: ZeUi.ZBTheme.metaTheme.idarker(labelFieldBackgroundColor,20)
    property color textColor: ZeUi.ZBTheme.accent
    property color comboBoxTextColor: ZeUi.ZBTheme.metaTheme.textColor(comboBoxBackgroundColor)

    onActiveFocusChanged: {
        if(activeFocus){
            objComboBox.forceActiveFocus();
        }
    }

    Rectangle{
        id: objBackground
        anchors.fill: parent
        anchors.centerIn: parent
        radius: objField.radious
        color: objField.backgroundColor
        border.width: objField.borderWidth
        border.color:objField.borderColor


        Row{
            anchors.fill: parent
            spacing: 0

            Rectangle{
                id: objLabelField
                width: objField.isFixedWidthForLabel?objField.labelWidth:parent.width*(objField.labelWidth/100.0)
                height: parent.height
                clip: true
                color: objField.labelFieldBackgroundColor
                border.width: objField.borderWidth
                border.color: objField.borderColor
                Text{
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    width: parent.width
                    color: objField.labelFieldTextColor
                    text: objField.label
                }
            }

            Rectangle{
                width: parent.width - objLabelField.width
                height: parent.height
                color: objField.comboBoxBackgroundColor
                border.width: objField.borderWidth
                border.color: objField.borderColor
                clip: true
                ComboBox{
                    id: objComboBox
                    Material.accent: objField.textColor
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 5
                    activeFocusOnTab: false
                    Keys.onReturnPressed: nextItemInFocusChain().forceActiveFocus(Qt.TabFocusReason)
                    Keys.onEnterPressed: nextItemInFocusChain().forceActiveFocus(Qt.TabFocusReason)
                    background: Rectangle{
                        color: objField.comboBoxBackgroundColor
                    }
                    contentItem: Text {
                        leftPadding: 0
                        rightPadding: objComboBox.indicator.width + objComboBox.spacing

                        text: objComboBox.displayText
                        font: objComboBox.font
                        color: objComboBox.pressed ? "#17a81a" : ZeUi.ZBTheme.metaTheme.textColor(objField.comboBoxBackgroundColor)
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                }
            }
        }
    }
}
