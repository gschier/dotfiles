import QtQuick
import qs.Common
import qs.Widgets

Row {
    id: root

    property string label: ""
    property string iconName: "brightness_6"
    property int value: 50

    signal valueRequested(int newValue)

    height: 40
    spacing: Theme.spacingS

    DankIcon {
        name: root.iconName
        size: Theme.iconSize
        color: Theme.primary
        anchors.verticalCenter: parent.verticalCenter
    }

    StyledText {
        text: root.label
        width: 112
        color: Theme.surfaceText
        font.pixelSize: Theme.fontSizeMedium
        anchors.verticalCenter: parent.verticalCenter
        elide: Text.ElideRight
    }

    DankSlider {
        id: slider

        width: parent.width - Theme.iconSize - 112 - valueText.width - Theme.spacingS * 4
        anchors.verticalCenter: parent.verticalCenter
        minimum: 1
        maximum: 100
        showValue: false
        unit: "%"
        thumbOutlineColor: Theme.surfaceContainer
        trackColor: Theme.ccSliderTrackColor
        trackOpacity: Theme.ccSliderTrackOpacity
        onSliderValueChanged: newValue => root.valueRequested(newValue)

        Binding on value {
            value: root.value
            when: !slider.isDragging
        }
    }

    StyledText {
        id: valueText

        text: `${Math.round(root.value)}%`
        width: 42
        color: Theme.surfaceVariantText
        font.pixelSize: Theme.fontSizeSmall
        horizontalAlignment: Text.AlignRight
        anchors.verticalCenter: parent.verticalCenter
    }
}
