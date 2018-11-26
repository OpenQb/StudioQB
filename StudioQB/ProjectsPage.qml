import Qb 1.0
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

    onWidthChanged: {
        objProjectsPage.state = ZeUi.ZBLib.getGridState(width);
    }
    onFocusChanged: {
        if(focus){
            objProjectsListView.forceActiveFocus();
        }
    }
    activeFocusOnTab: true

    Keys.forwardTo: [objProjectsListView,objProjectsDetailsPlaceHolder]


    states: [
        State {
            name: "xs"
            PropertyChanges {
                target: objProjectsListViewPlaceHolder;
                width: objProjectsPage.width
            }
            PropertyChanges {
                target: objProjectsDetailsPlaceHolder;
                visible: false
            }
        },
        State {
            name: "sm"
            PropertyChanges {
                target: objProjectsListViewPlaceHolder;
                width: 300
            }
            PropertyChanges {
                target: objProjectsDetailsPlaceHolder;
                visible: true
            }
        }
        ,
        State {
            name: "md"
            PropertyChanges {
                target: objProjectsListViewPlaceHolder;
                width: 300
            }
            PropertyChanges {
                target: objProjectsDetailsPlaceHolder;
                visible: true
            }
        },
        State {
            name: "lg"
            PropertyChanges {
                target: objProjectsListViewPlaceHolder;
                width: 300
            }
            PropertyChanges {
                target: objProjectsDetailsPlaceHolder;
                visible: true
            }
        }
        ,
        State {
            name: "xl"
            PropertyChanges {
                target: objProjectsListViewPlaceHolder;
                width: 300
            }
            PropertyChanges {
                target: objProjectsDetailsPlaceHolder;
                visible: true
            }
        }
    ]

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

    Item{
        anchors.fill: parent
        Rectangle{
            id: objProjectsListViewPlaceHolder
            color: "transparent"
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            height: parent.height
            ListView{
                id: objProjectsListView
                width: parent.width - 2
                height: parent.height
                model: StudioQBCore.StudioQBOne.projectListModel
                activeFocusOnTab: true
                currentIndex: 0
                onActiveFocusChanged: {
                    if(activeFocus){
                        if(objProjectsListView.currentItem){
                            objProjectsListView.currentItem.forceActiveFocus();
                            objProjectsListView.currentItem.focus = true;
                        }
                    }
                }
                onCurrentIndexChanged: {
                    if(objProjectsListView.currentItem){
                        objProjectsListView.currentItem.forceActiveFocus();
                        objProjectsListView.currentItem.focus = true;
                    }
                }
                delegate: Item{
                    id: objDelegate
                    width: objProjectsListView.width
                    height: 75
                    property color itemBgColor: index%2?
                                                    ZeUi.ZBTheme.metaTheme.computeColorList(ZeUi.ZBTheme.metaTheme.primary)[0]:
                                                    ZeUi.ZBTheme.metaTheme.computeColorList(ZeUi.ZBTheme.metaTheme.secondary)[0]

                    property color barColor: index%2?
                                                 ZeUi.ZBTheme.metaTheme.computeColorList(ZeUi.ZBTheme.metaTheme.primary)[6]:
                                                 ZeUi.ZBTheme.metaTheme.computeColorList(ZeUi.ZBTheme.metaTheme.secondary)[6]
                    property color itemSelectedColor: ZeUi.ZBTheme.metaTheme.computeColorList(ZeUi.ZBTheme.metaTheme.accent)[9]
                    property bool isSelected: objProjectsListView.currentIndex === index

                    Keys.onReturnPressed: {
                        event.accepted = true;
                        StudioQBCore.StudioQBOne.openProject(pid,name,source_dir,output_dir,export_format,json);
                    }
                    Keys.onEnterPressed: {
                        event.accepted = true;
                        StudioQBCore.StudioQBOne.openProject(pid,name,source_dir,output_dir,export_format,json);
                    }
                    Rectangle{
                        id: objDelegateBackground
                        anchors.fill: parent
                        color: objDelegate.itemBgColor
                        Rectangle{
                            width: 5
                            height: parent.height
                            color: objDelegate.isSelected && objDelegate.activeFocus?objDelegate.itemSelectedColor:objDelegate.barColor
                        }
                        Column{
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 5
                            Text{
                                width: parent.width
                                height: parent.height/2.0
                                text: name
                                wrapMode: Text.NoWrap
                                elide: Text.ElideMiddle
                                color: ZeUi.ZBTheme.metaTheme.textColor(objDelegate.itemBgColor)
                                font.bold: true
                                font.family: height*0.70
                            }
                            Text{
                                width: parent.width
                                height: parent.height/2.0
                                text: source_dir
                                wrapMode: Text.NoWrap
                                elide: Text.ElideMiddle
                                font.family: height*0.70
                                color: ZeUi.ZBTheme.metaTheme.ilighter(ZeUi.ZBTheme.metaTheme.textColor(objDelegate.itemBgColor),50)
                            }
                        }


                        MouseArea{
                            id: objDelegateMouseArea
                            anchors.fill: parent
                            onPressed: {
                                objProjectsListView.currentIndex = index;
                            }
                            onDoubleClicked: {
                                objProjectsListView.currentIndex = index;
                                StudioQBCore.StudioQBOne.openProject(pid,name,source_dir,output_dir,export_format,json);
                            }
                            onPressAndHold: {
                                objProjectsListView.currentIndex = index;
                            }
                        }

                        Button{
                            id: objDelegateMenuButton
                            anchors.top: parent.top
                            anchors.right: parent.right
                            text: QbMF3.icon("mf-more_vert")
                            font.family: QbMF3.family
                            font.pixelSize: height*0.80
                            height: 30
                            width: 30
                            Material.theme: Material.Light
                            contentItem: Text {
                                text: objDelegateMenuButton.text
                                font: objDelegateMenuButton.font
                                opacity: enabled ? 1.0 : 0.3
                                color: ZeUi.ZBTheme.metaTheme.textColor(objDelegate.itemBgColor)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }

                            background: Rectangle {
                                color: objDelegateMenuButton.down?ZeUi.ZBTheme.metaTheme.primary:"transparent"
                            }
                            onClicked: {
                                objDelegateMenu.open();
                            }
                            Menu {
                                id: objDelegateMenu
                                y: objDelegateMenuButton.height
                                onClosed: {
                                    objDelegate.forceActiveFocus();
                                    objDelegate.focus = true;
                                }
                                MenuItem {
                                    text: "Open"
                                    onTriggered: {
                                        StudioQBCore.StudioQBOne.openProject(pid,name,source_dir,output_dir,export_format,json);
                                    }
                                }
                                MenuItem {
                                    text: "Remove"
                                    onTriggered: {
                                        StudioQBCore.StudioQBOne.removeProject(pid,name,source_dir,output_dir,export_format,json);
                                    }
                                }
                                MenuItem {
                                    text: "Close"
                                    onTriggered: {
                                        StudioQBCore.StudioQBOne.closeProject(pid,name,source_dir,output_dir,export_format,json);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Rectangle{
                width: 2
                height: parent.height
                anchors.right: parent.right
                color: ZeUi.ZBTheme.metaTheme.idarker(ZeUi.ZBTheme.metaTheme.accent,50)
            }
        }

        Rectangle{
            id: objProjectsDetailsPlaceHolder
            color: "lightgrey"
            anchors.top: parent.top
            anchors.right: parent.right
            height: parent.height
            width: parent.width - objProjectsListViewPlaceHolder.width
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
        objProjectsPage.state = "xs";
        StudioQBCore.StudioQBOne.refreshProjectListModel();
    }
}
