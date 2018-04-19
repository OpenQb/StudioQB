import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

import Qb 1.0
import Qb.Core 1.0


Page{
    id: objPage
    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    property Component leftBar: null
    property Component rightBar: null
    property Component topBar: null
    property Component bottomBar: null
}
