import QtQuick
import qs.Common
import qs.Widgets

DankOSD {
    id: root

    property string target: "laptop"
    property int value: 50
    property real requestSequence: 0
    property string targetScreen: ""
    property real lastShownSequence: 0

    osdWidth: isVerticalLayout ? (40 + Theme.spacingS * 2) : Math.min(260, Screen.width - Theme.spacingM * 2)
    osdHeight: isVerticalLayout ? Math.min(260, Screen.height - Theme.spacingM * 2) : (40 + Theme.spacingS * 2)
    autoHideInterval: 1800

    onRequestSequenceChanged: {
        if (requestSequence === 0 || requestSequence === lastShownSequence)
            return;
        if (targetScreen && screen && screen.name !== targetScreen)
            return;

        lastShownSequence = requestSequence;
        show();
    }

    content: Item {
        anchors.fill: parent

        Row {
            anchors.centerIn: parent
            width: parent.width - Theme.spacingS * 2
            height: 40
            spacing: Theme.spacingS

            DankIcon {
                name: root.target === "studio" ? "desktop_windows" : "laptop_chromebook"
                size: Theme.iconSize
                color: Theme.primary
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: parent.width - Theme.iconSize - valueLabel.width - Theme.spacingS * 2
                height: 10
                radius: height / 2
                color: Theme.outline
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: parent.width * Math.max(0, Math.min(1, root.value / 100))
                    height: parent.height
                    radius: parent.radius
                    color: Theme.primary
                }
            }

            StyledText {
                id: valueLabel

                text: `${root.value}%`
                width: 44
                color: Theme.surfaceText
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignRight
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
