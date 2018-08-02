/* -*- coding: utf-8-unix -*-
 *
 * Copyright (C) 2015 Osmo Salomaa
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
import Sailfish.Silica 1.0

Text {
    id: streetname
    anchors.bottom: app.navigationActive ? (app.portrait ? navigationInfoBlock.top : parent.bottom) : menuButton.top
    anchors.bottomMargin: app.navigationActive ? Theme.paddingSmall : 0
    anchors.left: parent.left
    anchors.leftMargin: Theme.paddingLarge
    anchors.right: parent.right
    anchors.rightMargin: Theme.paddingLarge
    color: app.styler.streetFg
    elide: Text.ElideRight
    //font.bold: true
    font.pixelSize: Theme.fontSizeLarge
    horizontalAlignment: Text.AlignHCenter
    maximumLineCount: 1
    style: Text.Outline
    styleColor: app.styler.streetOutline
    text: gps.streetName
    visible: app.navigationActive && (text !== undefined && text !== null && text.length>0)
    z: 400
    states: [
        State {
            when: app.navigationActive && !app.portrait
            AnchorChanges {
                anchors.left: navigationInfoBlockLandscapeLeftShield.right
                anchors.right: navigationInfoBlockLandscapeRightShield.left
            }
        }
    ]
}
