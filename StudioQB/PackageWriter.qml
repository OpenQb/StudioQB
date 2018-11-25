import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0
import Qb.Core.Private 1.0

import "../lib.js" as Lib

StudioQBPage {
    id: objPage
    property int version: 1

    Component.onCompleted: {
        objPWSettings.setAppId(objPage.appId);
    }

    QbAppPackageWriter{
        id: objWriter
    }

    QbSettings{
        id: objPWSettings
        name: "PackageWriter"
        property alias projectDir: objProjectDir.text
        property alias buildDir: objBuildDir.text
        property alias projectVariant: objPackageVariant.value
        property alias encryptionVersion: objPage.version
    }

    Flickable{
        clip: true
        anchors.fill: parent
        contentHeight: objContentContainer.childrenRect.height+QbCoreOne.scale(50)
        contentWidth: parent.width
        Column{
            id: objContentContainer
            width: parent.width
            spacing: QbCoreOne.scale(10)

            Pane{
                Material.elevation: 2
                width: parent.width
                height: QbCoreOne.scale(150)
                Column{
                    anchors.fill: parent
                    spacing: QbCoreOne.scale(5)
                    Label{
                        id: lblProjectDir
                        width: parent.width
                        text: "Project directory"
                    }
                    Rectangle{
                        width: parent.width
                        height: QbCoreOne.scale(2)
                        color: "grey"
                    }
                    Label{
                        id: lblDragAndDropMessageP
                        width: parent.width
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        text: "Drag & Drop Project directoy"
                        elide: Label.ElideMiddle
                        color: "lightgrey"
                    }

                    Label{
                        id: objProjectDir
                        width: parent.width
                        height: parent.height - lblProjectDir.height - QbCoreOne.scale(2) - lblDragAndDropMessageP.height
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        elide: Label.ElideMiddle
                        color: "lightgrey"
                    }
                }

                DropArea{
                    anchors.fill: parent
                    onDropped: {
                        if (drop.hasUrls){
                            var url = String(drop.urls[0]);
                            //console.log(url)
                            if(Qt.platform.os === "windows"){
                                objProjectDir.text = url.substring(8,url.length);
                            }
                            else{
                                objProjectDir.text = url.substring(7,url.length);
                            }
                            drop.acceptProposedAction();
                        }
                    }
                }
            }


            Pane{
                Material.elevation: 2
                width: parent.width
                height: QbCoreOne.scale(150)
                Column{
                    anchors.fill: parent
                    spacing: QbCoreOne.scale(5)
                    Label{
                        id: lblBuildDir
                        width: parent.width
                        text: "Build directory"
                    }
                    Rectangle{
                        width: parent.width
                        height: QbCoreOne.scale(2)
                        color: "grey"
                    }
                    Label{
                        id: lblDragAndDropMessage
                        width: parent.width
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        text: "Drag & Drop Build directoy"
                        elide: Label.ElideMiddle
                        color: "lightgrey"
                    }
                    Label{
                        id: objBuildDir
                        width: parent.width
                        height: parent.height - lblBuildDir.height - QbCoreOne.scale(2) - lblDragAndDropMessage.height
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        elide: Label.ElideMiddle
                        color: "lightgrey"
                    }
                }

                DropArea{
                    anchors.fill: parent
                    onDropped: {
                        if (drop.hasUrls){
                            var url = String(drop.urls[0]);
                            //console.log(url)
                            if(Qt.platform.os === "windows"){
                                objBuildDir.text = url.substring(8,url.length);
                            }
                            else{
                                objBuildDir.text = url.substring(7,url.length);
                            }
                            drop.acceptProposedAction();
                        }
                    }
                }
            }

            Pane{
                width: parent.width
                height: QbCoreOne.scale(50)

                Label{
                    id: objMessageBox
                    anchors.left: parent.left
                    anchors.right: objPackageVariant.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }

                SpinBox {
                    id: objPackageVersion
                    anchors.right: objPackageVariant.left
                    from: 1
                    to: 3
                    value: 1
                    onValueChanged: {
                        objPage.version = value;
                    }
                }

                SpinBox {
                    id: objPackageVariant
                    anchors.right: objBuildButton.left
                    from: 0
                    to: items.length - 1
                    value: 0
                    property var items: ["QAP", "QXP"]
                    validator: RegExpValidator {
                        regExp: new RegExp("(QAP|QXP)", "i")
                    }

                    textFromValue: function(value) {
                        return items[value];
                    }

                    valueFromText: function(text) {
                        for (var i = 0; i < items.length; ++i) {
                            if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return sb.value
                    }
                }

                Button{
                    id: objBuildButton
                    Material.background: Material.accent
                    Material.foreground: "white"
                    anchors.top: parent.top
                    anchors.right: parent.right
                    text: "BUILD"
                    onClicked: {
                        var pv = objPackageVariant.textFromValue(objPackageVariant.value);
                        if(objBuildDir.text.length>0 && objProjectDir.text.length>0){
                            objWriter.setVersion(objPage.version);
                            objWriter.setPackageVariant(pv);
                            objWriter.resetPublicKey();
                            if(objWriter.createPackage(objProjectDir.text,objBuildDir.text)){
                                objMessageBox.text = "Package created";
                            }
                            else{
                                objMessageBox.text = "Failed to create package";
                            }
                        }
                    }
                }

            }
        }
    }
}
