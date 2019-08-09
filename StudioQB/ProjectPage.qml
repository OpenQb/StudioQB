import Qb 1.0
import Qb.Core 1.0


import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./../ZeUi" 1.0 as ZeUi
import "StudioQBCore" 1.0 as StudioQBCore
import "StudioQBComp" as StudioQBComp


ZeUi.ZSOneAppPage{
    id: objProjectPage
    title: "Project Page"
    contextDock: objContextDock

    property int pid: 0
    property string name: ""
    property string source_dir:""
    property string output_dir:""
    property string export_format: "QBP"
    property string json:""

    property bool isBuildingPack: false;
    property bool showBusyIndicator: false;

    onIsBuildingPackChanged: {
        showBusyIndicator = isBuildingPack;
    }

    onSelectedContextDockItem: {
        //title
        if(title === "Build"){
            objProjectPage.buildQbPack();
        }
    }
    onPageCreated: {
        objQbJSEngineEx.setAppId(ZeUi.ZBLib.appUi.appId);
    }

    /** Declare methods here **/
    function addSpinIcon(){
        objContextDock.insert(0,{"icon":"fa-spinner","title":"Busy"})
    }

    function removeSpinIcon(){
        if(objContextDock.get(0).title === "Busy"){
            objContextDock.remove(0);
        }
    }



    ListModel{
        id: objContextDock
        ListElement{
            icon: "fa-file-archive-o"
            title: "Build"
        }
    }

    QbJSEngineEx{
        id: objQbJSEngineEx
    }


    function buildQbPack(){
        if(!objProjectPage.isBuildingPack){
            var data = {};
            data["pid"] = objProjectPage.pid;
            data["name"] = objProjectPage.name;
            data["source_dir"] = objProjectPage.source_dir;
            data["output_dir"] = objProjectPage.output_dir;
            data["export_format"] = objProjectPage.export_format;
            data["json"] = objProjectPage.json;
            data["version"] = 1;
            objProjectPage.isBuildingPack = true;
            objQbJSEngineEx.addTask("/StudioQB/StudioQBJs/BuildQbPack.js",
                                    buildQbPackCallback,
                                    JSON.stringify(data));
        }
    }

    function buildQbPackCallback(taskStatus,rvalue){
        if(taskStatus === "taskDone"){
            objProjectPage.isBuildingPack = false;
            var jvalue = JSON.parse(rvalue);
            if(jvalue["status"] === 1){
                objDialogBox.title = "Build Success";
                objDialogBox.message = jvalue["message"];
                objDialogBox.open();
            }
            else{
                objDialogBox.title = "Build Failure";
                objDialogBox.message = jvalue["message"];
                objDialogBox.open();
            }
        }
    }

    Rectangle{
        anchors.fill: parent
        color: "white"
        Rectangle{
            id: objTopToolBar
            width: parent.width
            height: 50
            anchors.top: parent.top
            anchors.left: parent.left
            color: ZeUi.ZBTheme.metaTheme.primary

            Text{
                id: objTitlePage
                width: 100
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                text: objProjectPage.title
                color: ZeUi.ZBTheme.metaTheme.textColor(ZeUi.ZBTheme.metaTheme.primary)
                font.pixelSize: 15
                font.bold: true
                verticalAlignment: Text.AlignVCenter
            }

            Text{
                id: objBusyIndicator
                width: 25
                height: parent.height
                anchors.right: parent.right
                anchors.top: parent.top
                text: QbFA.icon("fa-spinner")
                color: ZeUi.ZBTheme.metaTheme.textColor(ZeUi.ZBTheme.metaTheme.primary)
                font.pixelSize: 18
                font.family: QbFA.family
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                visible: objProjectPage.showBusyIndicator
                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    from: 0
                    to: 360
                    direction: RotationAnimation.Clockwise
                    duration: 1000
                }
            }
        }
    }



    StudioQBComp.SQMessageDialog{
        id: objDialogBox;
        anchors.fill: parent
    }
}
