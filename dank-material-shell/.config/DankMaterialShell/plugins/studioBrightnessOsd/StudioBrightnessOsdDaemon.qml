import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string statePath: (Quickshell.env("XDG_STATE_HOME") || (Quickshell.env("HOME") + "/.local/state")) + "/DankMaterialShell/display-brightness.json"
    property string osdTarget: "laptop"
    property int osdValue: 50
    property real osdSequence: 0
    property real lastStateSequence: 0
    property bool stateReadInFlight: false
    property bool suppressNextStateOsd: true

    function parseState(text, showOsd) {
        if (!text || text.length === 0)
            return;

        try {
            const state = JSON.parse(text);
            const sequence = state.sequence || 0;
            const isNewState = sequence !== 0 && sequence !== root.lastStateSequence;
            if (sequence !== 0)
                root.lastStateSequence = sequence;
            if (root.suppressNextStateOsd) {
                root.suppressNextStateOsd = false;
                showOsd = false;
            }

            root.osdTarget = state.target || "laptop";
            root.osdValue = state.value || 0;
            if (showOsd && isNewState)
                root.osdSequence = sequence || Date.now();
        } catch (e) {
            console.warn("StudioBrightnessOsd: failed to parse state:", e);
        }
    }

    function readState(showOsd) {
        if (root.stateReadInFlight)
            return;

        root.stateReadInFlight = true;
        Proc.runCommand("studio-brightness-osd-state", ["cat", root.statePath], (output, exitCode) => {
            root.stateReadInFlight = false;
            if (exitCode !== 0) {
                root.suppressNextStateOsd = false;
                return;
            }
            root.parseState(output, showOsd);
        }, 0);
    }

    Component.onCompleted: {
        console.info("StudioBrightnessOsd: started");
        readState(false);
    }

    Timer {
        interval: 250
        repeat: true
        running: true
        onTriggered: root.readState(true)
    }

    Variants {
        model: SettingsData.getFilteredScreens("osd")

        delegate: StudioBrightnessOSD {
            modelData: item
            target: root.osdTarget
            value: root.osdValue
            requestSequence: root.osdSequence
            targetScreen: ""
        }
    }
}
