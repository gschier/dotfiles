import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string title: "Calendar"
    property string timeText: ""
    property string relativeText: ""
    property string locationText: ""
    property string eventUrl: ""
    property string errorText: ""
    property bool isEmpty: false

    ccWidgetIcon: root.errorText ? "event_busy" : "event"
    ccWidgetPrimaryText: "Next Event"
    ccWidgetSecondaryText: {
        if (root.errorText)
            return root.errorText;
        if (root.isEmpty)
            return "No upcoming events";
        return root.relativeText + " · " + root.title;
    }
    ccWidgetIsActive: !root.errorText && !root.isEmpty
    ccWidgetIsToggle: false
    ccDetailHeight: 150

    function refresh() {
        fetchNextEvent.running = true
    }

    function openEvent() {
        if (!root.eventUrl)
            return
        openEventProcess.command = ["xdg-open", root.eventUrl]
        openEventProcess.running = true
    }

    Component.onCompleted: refresh()

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Process {
        id: fetchNextEvent
        command: ["dms-next-event"]
        running: false

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const line = data.trim()
                if (!line)
                    return

                try {
                    const parsed = JSON.parse(line)
                    if (!parsed.ok) {
                        root.title = "Calendar"
                        root.timeText = ""
                        root.relativeText = ""
                        root.locationText = ""
                        root.eventUrl = ""
                        root.errorText = parsed.error || "Unable to load event"
                        root.isEmpty = false
                        return
                    }

                    root.errorText = ""
                    root.isEmpty = parsed.empty || false
                    root.title = parsed.empty ? parsed.label : parsed.title
                    root.timeText = parsed.time || ""
                    root.relativeText = parsed.relative || ""
                    root.locationText = parsed.location || ""
                    root.eventUrl = parsed.url || ""
                } catch (e) {
                    root.errorText = "Invalid event data"
                }
            }
        }
    }

    Process {
        id: openEventProcess
        running: false
    }

    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingS
            height: parent.widgetThickness

            DankIcon {
                name: root.errorText ? "event_busy" : "event"
                size: Theme.fontSizeLarge
                color: root.errorText ? Theme.error : Theme.primary
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: root.errorText ? root.errorText : (root.isEmpty ? "No events" : root.relativeText + " · " + root.title)
                color: Theme.surfaceText
                font.pixelSize: Theme.fontSizeSmall
                elide: Text.ElideRight
                width: Math.min(280, implicitWidth)
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    verticalBarPill: Component {
        DankIcon {
            name: root.errorText ? "event_busy" : "event"
            size: Theme.fontSizeLarge
            color: root.errorText ? Theme.error : Theme.primary
        }
    }

    popoutContent: Component {
        PopoutComponent {
            headerText: "Next Event"
            detailsText: root.errorText ? root.errorText : (root.isEmpty ? "No upcoming events" : root.timeText + " · " + root.relativeText)
            showCloseButton: true

            Column {
                width: parent.width
                spacing: Theme.spacingM

                StyledText {
                    width: parent.width
                    text: root.title
                    color: Theme.surfaceText
                    font.pixelSize: Theme.fontSizeLarge
                    font.weight: Font.Bold
                    wrapMode: Text.WordWrap
                }

                StyledText {
                    visible: root.locationText.length > 0
                    width: parent.width
                    text: root.locationText
                    color: Theme.surfaceVariantText
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                }

                Row {
                    spacing: Theme.spacingS

                    DankActionButton {
                        visible: root.eventUrl.length > 0
                        iconName: "open_in_new"
                        buttonSize: 28
                        iconSize: 16
                        backgroundColor: Theme.surfaceContainerHighest
                        tooltipText: "Open event"
                        onClicked: root.openEvent()
                    }

                    DankActionButton {
                        iconName: "refresh"
                        buttonSize: 28
                        iconSize: 16
                        backgroundColor: Theme.surfaceContainerHighest
                        tooltipText: "Refresh"
                        onClicked: root.refresh()
                    }
                }
            }
        }
    }

    ccDetailContent: Component {
        Rectangle {
            implicitHeight: detailColumn.implicitHeight + Theme.spacingM * 2
            height: implicitHeight
            radius: Theme.cornerRadius
            color: Theme.surfaceContainerHigh

            Column {
                id: detailColumn

                anchors.fill: parent
                anchors.margins: Theme.spacingM
                spacing: Theme.spacingM

                StyledText {
                    width: parent.width
                    text: root.errorText ? root.errorText : root.title
                    color: root.errorText ? Theme.error : Theme.surfaceText
                    font.pixelSize: Theme.fontSizeLarge
                    font.weight: Font.Bold
                    wrapMode: Text.WordWrap
                }

                StyledText {
                    visible: !root.errorText && !root.isEmpty
                    width: parent.width
                    text: root.timeText + " · " + root.relativeText
                    color: Theme.surfaceVariantText
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                }

                StyledText {
                    visible: root.locationText.length > 0
                    width: parent.width
                    text: root.locationText
                    color: Theme.surfaceVariantText
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                }

                Row {
                    spacing: Theme.spacingS

                    DankActionButton {
                        visible: root.eventUrl.length > 0
                        iconName: "open_in_new"
                        buttonSize: 28
                        iconSize: 16
                        backgroundColor: Theme.surfaceContainerHighest
                        tooltipText: "Open event"
                        onClicked: root.openEvent()
                    }

                    DankActionButton {
                        iconName: "refresh"
                        buttonSize: 28
                        iconSize: 16
                        backgroundColor: Theme.surfaceContainerHighest
                        tooltipText: "Refresh"
                        onClicked: root.refresh()
                    }
                }
            }
        }
    }

    popoutWidth: 360
    popoutHeight: 220
}
