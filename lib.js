.pragma library

var objAppUi;
var objAppTheme;
var objTopToolBar;
var objMainStack;
var objBottomToolBar;
var objPackageReader;

var appToolBarLoader;
var appStatusBarLoader;
var appBottomBarLoader;


var objLeftSideBar;
var objRightSideBar;

var appLeftSideBarLoader;
var appRightSideBarLoader;

function setup(appUi){
    objAppUi = appUi;

    var themeOne = {};
    themeOne["primary"] = "blue";
    themeOne["secondary"] = "green";
    themeOne["accent"] = "black";
    themeOne["background"] = "white";
    themeOne["foreground"] = "black";
    themeOne["theme"] = "dark";
    objAppTheme.setThemeFromJsonData(JSON.stringify(themeOne));

    pushPage("/pages/TestPage.qml");
}

function pushPage(page){
    objAppUi.pushPage(page);
}
