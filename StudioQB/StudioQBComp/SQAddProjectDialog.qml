import QtQuick 2.11
import QtQml.Models 2.11

import "./../../ZeUi" as ZeUi

import "./../StudioQBCore" as StudioQBCore


ZeUi.ZDialogUi{
    id: objAddProjectDialog
    title: "Add project"
    enableStatusBar: true
    statusBarButtonText: "ADD"
    signal projectAdded();
    onButtonClicked: {
        if(objNameField.fieldText === ""){
            objAddProjectDialog.statusBarMessage = "Please provide a name.";
        }
        else if(objSourceFolder.fieldText === ""){
            objAddProjectDialog.statusBarMessage = "Please provide source folder.";
        }
        else if(objOutputFolder.fieldText === ""){
            objAddProjectDialog.statusBarMessage = "Please provide output folder.";
        }
        else{
            if(StudioQBCore.StudioQBOne.isProjectExists(objSourceFolder.fieldText))
            {
                objAddProjectDialog.statusBarMessage = objNameField.fieldText+" already exists.";
            }
            else
            {
                if(StudioQBCore.StudioQBOne.addProject(objNameField.fieldText,
                                                       objSourceFolder.fieldText,
                                                       objOutputFolder.fieldText,
                                                       objExportFormat.fieldText
                                                       ))
                {
                    objAddProjectDialog.projectAdded();

                    objAddProjectDialog.statusBarMessage = objNameField.fieldText+" added.";
                }
                else
                {
                    objAddProjectDialog.statusBarMessage = "Failed to add project.";
                }
            }
        }
    }

    function resetFields(){
        objNameField.fieldText = "";
        objSourceFolder.fieldText = "";
        objOutputFolder.fieldText = "";
        objAddProjectDialog.statusBarMessage = "";
    }

    model: ObjectModel{
        SQTextField2 {
            id: objNameField
            label: "Name"
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: false
        }
        SQFolderField {
            id: objSourceFolder
            label: "Source folder"
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: true
            onFieldTextChanged: {
                if(objNameField.fieldText === ""){
                    var name = objSourceFolder.fieldText.split("/");
                    var name1 = name[name.length - 1];
                    if(name1){
                        objNameField.fieldText = name1;
                    }
                }
            }
        }
        SQFolderField {
            id: objOutputFolder
            label: "Output folder"
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: false
        }
        SQComboBox {
            id: objExportFormat
            label: "Export format"
            labelWidth: 30
            width: objAddProjectDialog.dialogWidth
            useAlternateColor: true
            comboBoxModel: ["QAP","QXP"]
        }
    }
}
