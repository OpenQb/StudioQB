pragma Singleton

import Qb 1.0
import Qb.Core 1.0
import Qb.Core.Private 1.0

import QtQuick 2.11

import "../ZeUi" 1.0 as ZeUi

Item {
    id: objStudioQBOne

    property alias codeEngine: objCodeExecutionEngine

    QbJSEngineEx{
        id: objCodeExecutionEngine
    }

    Component.onCompleted: {
        objCodeExecutionEngine.setAppId(ZeUi.ZBLib.appUi.appId);
    }
}
