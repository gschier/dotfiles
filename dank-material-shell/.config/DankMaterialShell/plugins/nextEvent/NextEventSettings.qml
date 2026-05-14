import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "nextEvent"

    Component.onCompleted: {
        if (root.loadValue("lookaheadDays", null) === null)
            root.saveValue("lookaheadDays", 30)
        if (root.loadValue("cacheMinutes", null) === null)
            root.saveValue("cacheMinutes", 10)
    }

    StyledText {
        width: parent.width
        text: "Next Event"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "Paste your private Google Calendar secret iCal URL. The calendar is used read-only."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    StringSetting {
        settingKey: "icsUrl"
        label: "Secret iCal URL"
        description: "Google Calendar Settings > Integrate calendar > Secret address in iCal format"
        placeholder: "https://calendar.google.com/calendar/ical/..."
        defaultValue: ""
    }

    SliderSetting {
        settingKey: "lookaheadDays"
        label: "Look ahead"
        description: "How many days to search for the next event"
        minimum: 1
        maximum: 90
        defaultValue: 30
    }

    SliderSetting {
        settingKey: "cacheMinutes"
        label: "Cache minutes"
        description: "How long to cache the downloaded calendar"
        minimum: 1
        maximum: 60
        defaultValue: 10
    }
}
