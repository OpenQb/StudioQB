.pragma library

var objAppUi;
var objAppTheme;
var objTopToolBar;
var objMainStack;
var objBottomToolBar;

var appToolBar;
var appStatusBar;
var appBottomBar;

function setup(appUi){
    objAppUi = appUi;

    var themeOne = {};
    themeOne["primary"] = "blue";
    themeOne["secondary"] = "green";
    themeOne["accent"] = "black";
    themeOne["background"] = "white";
    themeOne["foreground"] = "black";
    themeOne["theme"] = "light";
    objAppTheme.setThemeFromJsonData(JSON.stringify(themeOne));

    objMainStack.push(appUi.absoluteURL("/pages/PageInterface.qml"))
}
