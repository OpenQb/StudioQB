import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "./../ZeUi" 1.0 as ZeUi
import "StudioQBCore" 1.0 as StudioQBCore
import "StudioQBComp" as StudioQBComp

ZeUi.ZSOneAppPage{
    id: objProjectsPage
    title: "Projects"
    contextDock: objContextDock

    ListModel{
        id: objContextDock
        ListElement{
            icon: "mf-library_add"
            title: "Add"
        }
        ListElement{
            icon: "mf-refresh"
            title: "Refresh"
        }
    }

    onSelectedContextDockItem: {
        //title
        if(title === "Add"){
            objAddProjectDialog.resetFields();
            objAddProjectDialog.open();
        }
        else if(title === "Refresh"){
            StudioQBCore.StudioQBOne.refreshProjectListModel();
        }
    }

    Rectangle{
        anchors.centerIn: parent
        width: parent.width*0.80
        height: parent.height*0.80
        color: "transparent"
        border.width: 5
        border.color: "blue"
        ListView{
            id: objProjectsListView
            width: parent.width - parent.border.width*2
            height: parent.height - parent.border.width*2
            anchors.centerIn: parent
            model: StudioQBCore.StudioQBOne.projectListModel
            delegate: Rectangle{
                width: objProjectsListView.width
                height: 30
                color: index%2?"lightgrey":"lightyellow"
                Text{
                    anchors.fill: parent
                    text: name
                }
            }
        }
    }


    StudioQBComp.SQAddProjectDialog{
        id: objAddProjectDialog
        anchors.fill: parent
        onProjectAdded: {
            StudioQBCore.StudioQBOne.refreshProjectListModel();
            objAddProjectDialog.close();
        }
    }


    onPageCreated: {
        StudioQBCore.StudioQBOne.refreshProjectListModel();
    }
}
