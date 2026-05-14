import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string brightnessCommand: "/home/gschier/.local/bin/display-brightness"
    property int laptopBrightness: 50
    property bool laptopAvailable: false
    property int studioBrightness: 50
    property bool studioAvailable: false
    property string osdTarget: "laptop"
    property int osdValue: 50
    property real osdSequence: 0
    property string osdScreen: ""
    property bool stateReloadFromWatch: false
    property string statePath: (Quickshell.env("XDG_STATE_HOME") || (Quickshell.env("HOME") + "/.local/state")) + "/DankMaterialShell/display-brightness.json"

    ccWidgetIcon: "brightness_6"
    ccWidgetPrimaryText: "Brightness"
    ccWidgetSecondaryText: {
        if (laptopAvailable && studioAvailable)
            return `Laptop ${laptopBrightness}% • Studio ${studioBrightness}%`;
        if (laptopAvailable)
            return `Laptop ${laptopBrightness}%`;
        if (studioAvailable)
            return `Studio ${studioBrightness}%`;
        return "Unavailable";
    }
    ccWidgetIsActive: true
    ccWidgetIsToggle: false
    ccDetailHeight: {
        const activeRows = (laptopAvailable ? 1 : 0) + (studioAvailable ? 1 : 0);
        return activeRows <= 1 ? 58 : 124;
    }

    function refresh() {
        Proc.runCommand("", [root.brightnessCommand, "status", "all"], (output, exitCode) => {
            if (exitCode !== 0)
                return;

            try {
                const status = JSON.parse(output);
                root.laptopAvailable = typeof status.laptop === "number";
                if (root.laptopAvailable)
                    root.laptopBrightness = status.laptop;
                root.studioAvailable = typeof status.studio === "number";
                if (root.studioAvailable)
                    root.studioBrightness = status.studio;
            } catch (e) {
                console.warn("StudioBrightness: failed to parse status:", e);
            }
        });
    }

    function setBrightness(target, value) {
        const percent = Math.max(1, Math.min(100, Math.round(value)));
            if (target === "laptop")
                root.laptopBrightness = percent;
            else
                root.studioBrightness = percent;

        Proc.runCommand(`studio-brightness-set-${target}`, [root.brightnessCommand, "set", String(percent), target], (output, exitCode) => {
            if (exitCode !== 0) {
                ToastService.showError("Brightness failed", target);
                refresh();
                return;
            }
            parseState(output, true);
            refresh();
        }, 0);
    }

    function parseState(text, showOsd) {
        if (!text || text.length === 0)
            return;

        try {
            const state = JSON.parse(text);
            if (state.target === "laptop")
                root.laptopBrightness = state.value;
            if (state.target === "studio")
                root.studioBrightness = state.value;
        } catch (e) {
            console.warn("StudioBrightness: failed to parse state:", e);
        }
    }

    Component.onCompleted: refresh()

    Connections {
        target: Quickshell
        function onScreensChanged() {
            root.refresh();
        }
    }

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: root.refresh()
    }

    FileView {
        id: stateFile
        path: root.statePath
        watchChanges: true

        onLoaded: {
            root.parseState(stateFile.text(), root.stateReloadFromWatch);
            root.stateReloadFromWatch = false;
        }

        onFileChanged: {
            root.stateReloadFromWatch = true;
            stateFile.reload();
        }
    }

    ccDetailContent: Component {
        Rectangle {
            id: detailRoot

            implicitHeight: detailColumn.implicitHeight + Theme.spacingM * 2
            height: implicitHeight
            radius: Theme.cornerRadius
            color: Theme.surfaceContainerHigh

            Column {
                id: detailColumn

                anchors.fill: parent
                anchors.margins: Theme.spacingM
                spacing: Theme.spacingM

                BrightnessControlRow {
                    width: parent.width
                    visible: root.laptopAvailable
                    height: visible ? 40 : 0
                    label: "Laptop"
                    iconName: "laptop_chromebook"
                    value: root.laptopBrightness
                    onValueRequested: newValue => root.setBrightness("laptop", newValue)
                }

                BrightnessControlRow {
                    width: parent.width
                    label: "Studio Display"
                    iconName: "desktop_windows"
                    visible: root.studioAvailable
                    height: visible ? 40 : 0
                    value: root.studioBrightness
                    onValueRequested: newValue => root.setBrightness("studio", newValue)
                }
            }
        }
    }
}
