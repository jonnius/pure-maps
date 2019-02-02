/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2018 Osmo Salomaa, 2018 Rinigus
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import "platform"

IconButtonPL {
    id: button
    anchors.bottom: parent.bottom
    anchors.bottomMargin: app.styler.themePaddingLarge
    anchors.right: menuButton.left
    anchors.rightMargin: app.styler.themePaddingLarge
    icon.source: app.getIcon("icons/search")
    icon.sourceSize.height: app.styler.themeIconSizeMedium
    opacity: 0.75
    states: [
        State {
            when: hidden
            AnchorChanges {
                target: button
                anchors.bottom: undefined
                anchors.top: parent.bottom
            }
        }
    ]
    transitions: Transition {
        AnchorAnimation { duration: app.conf.animationDuration; }
    }
    visible: app.mode === modes.explore || app.mode === modes.exploreRoute
    z: 500

    property bool hidden: app.infoPanelOpen || (map.cleanMode && !app.conf.mapModeCleanShowGeocode)

    onClicked: app.pushMain(Qt.resolvedUrl("GeocodePage.qml"))
}