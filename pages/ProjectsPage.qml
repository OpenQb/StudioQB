import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "../ZeUi" 1.0 as ZeUi
import "../StudioQBCore" 1.0 as StudioQBCore
import "../StudioQBComp" as StudioQBComp

ZeUi.ZSOneAppPage{
    id: objProjectsPage
    title: "Projects"

    ListView{
        anchors.fill: parent
        model: StudioQBCore.StudioQBOne.projectListModel
        delegate: Rectangle{
            width: objProjectsPage.width
            height: 30
            color: index%2?"lightgrey":"lightyellow"

            Text{
                anchors.fill: parent
                text: name
            }
        }
    }

    StudioQBComp.SQAddProjectDialog{
        id: objAddProjectDialog
        anchors.fill: parent
    }


    onPageCreated: {
        StudioQBCore.StudioQBOne.refreshProjectListModel();
        objAddProjectDialog.open();
    }
}
