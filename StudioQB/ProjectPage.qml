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
    property string sourceDir:""
    property string outputDir:""
    property string exportFormat: "QAP"


    ListModel{
        id: objContextDock
    }
}
