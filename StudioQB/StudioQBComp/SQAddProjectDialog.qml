import QtQuick 2.11
import QtQml.Models 2.11

import "./../../ZeUi" as ZeUi


ZeUi.ZDialogUi{
    id: objAddProjectDialog
    title: "Add project"
    enableStatusBar: true
    statusBarButtonText: "ADD"
    onButtonClicked: {

    }

    model: ObjectModel{
        SQTextField2 {
            label: "Name"
            width: objAddProjectDialog.dialogWidth
        }
    }
}
