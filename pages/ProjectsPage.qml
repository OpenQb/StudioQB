import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "../ZeUi" 1.0 as ZeUi
import "../StudioQBCore" 1.0 as StudioQBCore

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
    onPageCreated: {
        StudioQBCore.StudioQBOne.dbPath();
        console.log(StudioQBCore.StudioQBOne.removeProjectFromProjectListById(1));
        StudioQBCore.StudioQBOne.searchInProjectListModel("name");
        //StudioQBCore.StudioQBOne.refreshProjectListModel();

        //console.log(StudioQBCore.StudioQBOne.getProjectById(1));
    }
}
