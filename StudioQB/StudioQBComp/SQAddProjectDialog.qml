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
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: false
            labelFieldBackgroundColor: ZeUi.ZBTheme.background
        }
        SQTextField2 {
            label: "Source folder"
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: true
        }
        SQTextField2 {
            label: "Output folder"
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: false
        }
        SQTextField2 {
            label: "Export format"
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: true
        }
    }
}
