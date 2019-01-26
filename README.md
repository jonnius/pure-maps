# Pure Maps

Pure Maps is an application for Sailfish OS and Linux to display
vector and raster maps, places, routes, and provide navigation
instructions with a flexible selection of data and service providers.

Pure Maps is free software released under the GNU General Public
License (GPL), see the file [`COPYING`](COPYING) for details. Pure
Maps is a fork of [WhoGo Maps](https://github.com/otsaloma/whogo-maps)
that was made to continue its development.


## Platforms

To support multiple platforms, QML code is split into
platform-specific and platform-independent parts. Platform-independent
part is in `qml` folder with the platform-dependent code under
`qml/<platform-id>`. To switch between platforms, one has to make a
symbolic link from the corresponding `qml/<platform-id>` to
`qml/platform`. This can be done by running 

```
make platform-qtcontrols
```

for example. Current platforms are 

* platform.kirigami -> make target `platform-kirigami`
* platform.qtcontrols -> make target `platform-qtcontrols`
* platform.silica -> make target `platform-silica`

Within platform-independent code, platform is included allowing to
access platform-specific implementations of page stack, file dialog,
and other specific aspects. For this approach to work, API in the
platform specific implementation has to be the same for all platforms. 

To add new platform, add new directory under `qml`, new Makefile
target to set it, and implement all the required QML items. Take a
look under other platforms for examples.

For testing purposes you can just run `qmlscene qml/pure-maps.qml`,
after setting the platform.


## Dependencies

In addition to common dependencies for QML applications, the following
are needed:

* Nemo DBus https://git.merproject.org/mer-core/nemo-qml-plugin-dbus
* PyOtherSide https://github.com/thp/pyotherside
* PyXDG https://www.freedesktop.org/wiki/Software/pyxdg/
* Mapbox GL Native, Qt version, use the packaged version at https://github.com/rinigus/pkg-mapbox-gl-native
* Mapbox GL QML, unofficial QML bindings, https://github.com/rinigus/mapbox-gl-qml
* [flatpak only] QML runner https://github.com/rinigus/qmlrunner

When developing with Kirigami using flatpak builder, dependencies will
be pulled and installed in flatpak. See instructions regarding
Kirigami below.


## Packaging

At present, Sailfish OS version is packaged as RPM and Linux version
is packaged using Flatpak.

For packaging, please copy `tools/apikeys_dummy.py` to
`tools/apikeys.py` and fill missing API keys for the services that you
plan to use.

For installation on Sailfish, you can build the RPM package with
command `make rpm`. You don't need an SDK to build the RPM, only basic
tools: `make`, `rpmbuild`, `gettext` and `qttools`.

Flatpak specific instructions are available under `packaging/flatpak`.


## User feedback

There are two main communication channels with the users: Github and a
thread at
[TMO](https://talk.maemo.org/showthread.php?t=100442). 

Please use Github issues to address specific problems and development
requests. General discussion is expected either through corresponding
issues opened by maintainer or TMO thread. Please note that users from
all platforms are welcome at TMO, not only current Sailfish OS users.


## Platform specific notes

### Kirigami

Kirigami platform may require latest platform SDK available as
flatpaks. See instructions at
https://docs.plasma-mobile.org/AppDevelopment.html for local
development. From these instructions, only SDK install is
needed. After that, building and running can be performed by

```
make flatpak-build flatpak-run
```


## Development

### General

Throughout QML and Python code, all the same type items (properties,
signals, functions), are ordered alphabetically. 

Its possible that some of the implemented code does not fully comply
with the outlined order. Then it should be fixed eventually.

### QML

To simplify development, there are few simple rules regarding QML file
organization. QML files are organized as follows (use the needed
components):

```
import A
import B
import "."

import "js/util.js" as Util

Item {
    id: item
    
    // base class defined properties in alphabetic order
    prop_a: val_a
    prop_b: val_b
    
    // new properties in alphabetic order
    property         var  np_a: default_a
    default property bool np_b: default_b
    
    // readonly properties
    readonly property var images: QtObject {
        readonly property string pixel:         "pure-image-pixel"
        readonly property string poi:           "pure-image-poi"
        readonly property string poiBookmarked: "pure-image-poi-bookmarked"
    }
    
    // signals
    signal mySignal

    // local unexported properties
    property bool _locked: false

    // behavior
    Behavior on bearing {
        RotationAnimation {
            direction: RotationAnimation.Shortest
            duration: map.ready ? 500 : 0
            easing.type: Easing.Linear
        }
    }
    
    // new sub-items following the same principles
    Item {
        id: subitem
    }
    
    // connections
    Connections {
    }

    // signal handlers
    Component.onCompleted: init()
    onActivated: doSomething()
    
    // functions 
    function a() {
        return 10;
    }
}
```
