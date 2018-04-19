import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0
import "lib.js" as Lib

QbApp {
    id: objAppUi
    minimumHeight: 400
    minimumWidth: 450
    property string gridState: "xs"
    property int leftSideBarWidth: 0
    property int rightSideBarWidth: 0

    onWidthChanged: {
        appResized();
    }

    onAppClosing: {

    }

    Component.onCompleted: {
        Lib.objAppTheme = objAppTheme;
        Lib.objPackageReader = objPackageReader;

        Lib.objTopToolBar = objTopToolBar;
        Lib.appToolBarLoader = objTopToolBar.appToolBar;
        Lib.appStatusBarLoader = objTopToolBar.appStatusBar;

        Lib.objMainStack = objMainStack;

        Lib.objBottomToolBar = objBottomToolBar;
        Lib.appBottomBarLoader = objBottomToolBar.appBottomBar;

        Lib.objLeftSideBar = objLeftSideBar;
        Lib.objRightSideBar = objRightSideBar;

        Lib.appLeftSideBarLoader = objLeftSideBar.appSideBar;
        Lib.appRightSideBarLoader = objRightSideBar.appSideBar;

        Lib.setup(objAppUi);
    }

    QbMetaTheme{
        id: objAppTheme
    }

    QbAppPackageReader{
        id: objPackageReader
    }

    Pane{
        id: objContentPlaceHolder

        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0

        Material.primary: objAppTheme.primary
        Material.accent: objAppTheme.accent
        Material.background: objAppTheme.background
        Material.foreground: objAppTheme.foreground
        Material.theme: objAppTheme.theme === "dark"?Material.Dark:Material.Light

        anchors.fill: parent

        TopToolBar{
            id: objTopToolBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: QbCoreOne.os() === "android"?QbCoreOne.scale(75):QbCoreOne.scale(50)
            appStatusBarHeight: QbCoreOne.os() === "android"?QbCoreOne.scale(25):0
            z: 10000
            onLeftSideBarClicked: {
                toggleLeftSideBar();
            }
            onRightSideBarClicked: {
                toggleRightSideBar();
            }
        }

        SideBar{
            id: objLeftSideBar
            anchors.top: objTopToolBar.bottom
            anchors.bottom: objBottomToolBar.top
            anchors.left: parent.left
            width: 0
            z: 10000
            onWidthChanged: {
                if(objAppUi.gridState === "md" || objAppUi.gridState === "lg" ||objAppUi.gridState === "xl"){
                    if(objLeftSideBar.width === 0){
                        objMainStack.anchors.left = objTopToolBar.left;
                    }
                    else{
                        objMainStack.anchors.left = objLeftSideBar.right;
                    }
                }
                else{
                    objMainStack.anchors.left = objTopToolBar.left;
                }
            }
            Behavior on width {
                NumberAnimation { duration: 300 }
            }
        }

        SideBar{
            id: objRightSideBar
            anchors.top: objTopToolBar.bottom
            anchors.bottom: objBottomToolBar.top
            anchors.right: parent.right
            width: 0
            z: 10000
            onWidthChanged: {
                if(objAppUi.gridState === "lg" ||objAppUi.gridState === "xl"){
                    if(objRightSideBar.width === 0){
                        objMainStack.anchors.right = objTopToolBar.right;
                    }
                    else{
                        objMainStack.anchors.right = objRightSideBar.left;
                    }
                }
                else{
                    objMainStack.anchors.right = objTopToolBar.right;
                }
            }

            Behavior on width {
                NumberAnimation { duration: 300 }
            }
        }

        StackView{
            id: objMainStack
            anchors.top: objTopToolBar.bottom
            anchors.bottom: objBottomToolBar.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        BottomToolBar{
            id: objBottomToolBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: QbCoreOne.scale(10)
            z: 10000
        }
    }


    function appResized(){

        var w = objAppUi.width;
        if(w<576){
            objAppUi.gridState = "xs";
        }
        else if(w>=576 && w<768){
            objAppUi.gridState = "sm";
        }
        else if(w>=768 && w<960){
            objAppUi.gridState = "md";
        }
        else if(w>=960 && w<1200){
            objAppUi.gridState = "lg";
        }
        else{
            objAppUi.gridState = "xl";
        }

        objTopToolBar.appLeftSiderBarVisible = objLeftSideBar.hasSideBar;
        objTopToolBar.appRightSiderBarVisible = objRightSideBar.hasSideBar;

        if(objAppUi.gridState === "xs" || objAppUi.gridState === "sm"){
            if(objLeftSideBar.hasSideBar){
                objAppUi.leftSideBarWidth = QbCoreOne.scale(200);
                if(objLeftSideBar.width!=0){
                    objLeftSideBar.width = objAppUi.leftSideBarWidth;
                }
            }
            else{
                objAppUi.leftSideBarWidth = 0;
                objLeftSideBar.width = 0;
            }

            if(objRightSideBar.hasSideBar){
                objAppUi.rightSideBarWidth = QbCoreOne.scale(200);
                if(objRightSideBar.width!=0){
                    objRightSideBar.width = objAppUi.rightSideBarWidth;
                }
            }
            else{
                objAppUi.rightSideBarWidth = 0;
                objRightSideBar.width = 0;
            }

            objMainStack.anchors.left = objTopToolBar.left;
            objMainStack.anchors.right = objTopToolBar.right;
        }

        else if(objAppUi.gridState === "md"){
            if(objLeftSideBar.hasSideBar){
                objAppUi.leftSideBarWidth = QbCoreOne.scale(200);
                if(objLeftSideBar.width!=0){
                    objLeftSideBar.width = objAppUi.leftSideBarWidth;
                }
                objMainStack.anchors.left = objLeftSideBar.right;
            }
            else{
                objLeftSideBar.width = 0;
                objAppUi.leftSideBarWidth = 0;
                objMainStack.anchors.left = objTopToolBar.left;
            }

            if(objRightSideBar.hasSideBar){
                objAppUi.rightSideBarWidth = QbCoreOne.scale(200);
                if(objRightSideBar.width!=0){
                    objRightSideBar.width = objAppUi.rightSideBarWidth;
                }
            }
            else{
                objRightSideBar.width = 0;
                objAppUi.rightSideBarWidth = 0;
            }

            objMainStack.anchors.right = objTopToolBar.right;
        }

        else if(objAppUi.gridState === "lg" || objAppUi.gridState === "xl"){
            if(objLeftSideBar.hasSideBar){
                objAppUi.leftSideBarWidth = QbCoreOne.scale(250);
                objMainStack.anchors.left = objLeftSideBar.right;
                if(objLeftSideBar.width!=0){
                    objLeftSideBar.width = objAppUi.leftSideBarWidth;
                }
            }
            else{
                objLeftSideBar.width = 0;
                objAppUi.leftSideBarWidth = 0;
                objMainStack.anchors.left = objTopToolBar.left;
            }

            if(objRightSideBar.hasSideBar){
                objAppUi.rightSideBarWidth = QbCoreOne.scale(250);
                objMainStack.anchors.right = objRightSideBar.left;
                if(objRightSideBar.width!=0){
                    objRightSideBar.width = objAppUi.rightSideBarWidth;
                }
            }
            else{
                objRightSideBar.width = 0;
                objAppUi.rightSideBarWidth = 0;
                objMainStack.anchors.right = objTopToolBar.right;
            }
        }
    }

    function pushPage(page){
        var component = Qt.createComponent(objAppUi.absoluteURL(page));
        var incubator = component.incubateObject(objMainStack);
        if (incubator.status !== Component.Ready) {
            incubator.onStatusChanged = function(status) {
                if (status === Component.Ready) {
                    setupPage(incubator.object);
                }
            }
        } else {
            setupPage(incubator.object);
        }
    }

    function toggleLeftSideBar(){
        if(objLeftSideBar.width === objAppUi.leftSideBarWidth){
            objLeftSideBar.width = 0;
        }
        else{
            objLeftSideBar.width = objAppUi.leftSideBarWidth;
        }
    }

    function toggleRightSideBar(){
        if(objRightSideBar.width === objAppUi.rightSideBarWidth){
            objRightSideBar.width = 0;
        }
        else{
            objRightSideBar.width = objAppUi.rightSideBarWidth;
        }
    }

    function setupPage(objPage){
        var cpage = objPage;
        objTopToolBar.appToolBar.sourceComponent = cpage.topBar;
        objBottomToolBar.appBottomBar.sourceComponent = cpage.bottomBar;
        objLeftSideBar.appSideBar.sourceComponent = cpage.leftBar;
        objRightSideBar.appSideBar.sourceComponent = cpage.rightBar;
        objMainStack.push(cpage);
    }
}
