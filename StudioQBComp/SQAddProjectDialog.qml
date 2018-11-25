import QtQuick 2.11
import QtQml.Models 2.11

import "../ZeUi" 1.0 as ZeUi


ZeUi.ZDialogUi{
    id: objAddProjectDialog
    title: "Add project"
    enableStatusBar: true
    statusBarButtonText: "ADD"
    onButtonClicked: {

    }

    model: ObjectModel{
        Rectangle { height: 30; width: 80; color: "red" }
    }
}
