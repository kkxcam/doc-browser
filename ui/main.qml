import QtQuick 2.9
import QtQuick.Layouts 1.2
import QtWebEngine 1.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtLocation 5.3

import "./style"
import "main.js" as Logic
import "match.js" as MatchJs
import "tab.js" as TabJs

Window {
    title: "Doc Browser"
    visible: true
    visibility: Window.Maximized

    Shortcut {
        sequence: "/"
        onActivated: searchInput.focus = true
    }

    Shortcut {
        sequence: "y"
        onActivated: {
            var match = matchContainer.model[matchContainer.selected];
            if (match) {
                setClipboard(match.name);
            }
        }
    }

    Shortcut {
        sequence: "Ctrl+/"
        onActivated: google(searchInput.text);
    }

    Shortcut {
        sequence: "Ctrl+i"
        onActivated: {
            if (!searchInput.focus) {
                searchInput.focus = true;
            }
            var len = searchInput.text.length;
            var txt = searchInput.text;
            if (len >= 3) {
                if (txt.startsWith("/")) {
                    searchInput.text = txt.substring(0, 3);
                } else if (txt[len-3] === "/") {
                    searchInput.text = txt.substring(len-3, len);
                } else {
                    searchInput.text = ""
                }
            } else {
                searchInput.text = "";
            }
        }
    }

    readonly property real leftColumnWidthNormal: 400
    readonly property real leftColumnWidthHoogle: 700

    // =====================================================================
    // Shortcuts for navigating matches
    // TODO @incomplete: is this insane?
    // =====================================================================
    Shortcut {sequence: MatchJs.shortcut( 1 - 1); onActivated: Logic.matchOpen( 1 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 2 - 1); onActivated: Logic.matchOpen( 2 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 3 - 1); onActivated: Logic.matchOpen( 3 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 4 - 1); onActivated: Logic.matchOpen( 4 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 5 - 1); onActivated: Logic.matchOpen( 5 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 6 - 1); onActivated: Logic.matchOpen( 6 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 7 - 1); onActivated: Logic.matchOpen( 7 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 8 - 1); onActivated: Logic.matchOpen( 8 - 1)}
    Shortcut {sequence: MatchJs.shortcut( 9 - 1); onActivated: Logic.matchOpen( 9 - 1)}
    Shortcut {sequence: MatchJs.shortcut(10 - 1); onActivated: Logic.matchOpen(10 - 1)}
    Shortcut {sequence: MatchJs.shortcut(11 - 1); onActivated: Logic.matchOpen(11 - 1)}
    Shortcut {sequence: MatchJs.shortcut(12 - 1); onActivated: Logic.matchOpen(12 - 1)}
    Shortcut {sequence: MatchJs.shortcut(13 - 1); onActivated: Logic.matchOpen(13 - 1)}
    Shortcut {sequence: MatchJs.shortcut(14 - 1); onActivated: Logic.matchOpen(14 - 1)}
    Shortcut {sequence: MatchJs.shortcut(15 - 1); onActivated: Logic.matchOpen(15 - 1)}
    Shortcut {sequence: MatchJs.shortcut(16 - 1); onActivated: Logic.matchOpen(16 - 1)}
    Shortcut {sequence: MatchJs.shortcut(17 - 1); onActivated: Logic.matchOpen(17 - 1)}
    Shortcut {sequence: MatchJs.shortcut(18 - 1); onActivated: Logic.matchOpen(18 - 1)}
    Shortcut {sequence: MatchJs.shortcut(19 - 1); onActivated: Logic.matchOpen(19 - 1)}
    Shortcut {sequence: MatchJs.shortcut(20 - 1); onActivated: Logic.matchOpen(20 - 1)}
    Shortcut {sequence: MatchJs.shortcut(21 - 1); onActivated: Logic.matchOpen(21 - 1)}
    Shortcut {sequence: MatchJs.shortcut(22 - 1); onActivated: Logic.matchOpen(22 - 1)}
    Shortcut {sequence: MatchJs.shortcut(23 - 1); onActivated: Logic.matchOpen(23 - 1)}
    Shortcut {sequence: MatchJs.shortcut(24 - 1); onActivated: Logic.matchOpen(24 - 1)}
    Shortcut {sequence: MatchJs.shortcut(25 - 1); onActivated: Logic.matchOpen(25 - 1)}
    Shortcut {sequence: MatchJs.shortcut(26 - 1); onActivated: Logic.matchOpen(26 - 1)}
    Shortcut {sequence: MatchJs.shortcut(27 - 1); onActivated: Logic.matchOpen(27 - 1)}

    Shortcut {sequence: "j"; onActivated: {Logic.matchSelect(matchContainer.selected + 1)}}
    Shortcut {sequence: "k"; onActivated: {Logic.matchSelect(matchContainer.selected - 1)}}


    // =====================================================================
    // Shortcuts for navigating tabs
    // =====================================================================
    Shortcut {sequence: TabJs.keys[ 1 - 1]; onActivated: Logic.tabSelect( 1 - 1)}
    Shortcut {sequence: TabJs.keys[ 2 - 1]; onActivated: Logic.tabSelect( 2 - 1)}
    Shortcut {sequence: TabJs.keys[ 3 - 1]; onActivated: Logic.tabSelect( 3 - 1)}
    Shortcut {sequence: TabJs.keys[ 4 - 1]; onActivated: Logic.tabSelect( 4 - 1)}
    Shortcut {sequence: TabJs.keys[ 5 - 1]; onActivated: Logic.tabSelect( 5 - 1)}
    Shortcut {sequence: TabJs.keys[ 6 - 1]; onActivated: Logic.tabSelect( 6 - 1)}
    Shortcut {sequence: TabJs.keys[ 7 - 1]; onActivated: Logic.tabSelect( 7 - 1)}
    Shortcut {sequence: TabJs.keys[ 8 - 1]; onActivated: Logic.tabSelect( 8 - 1)}
    Shortcut {sequence: TabJs.keys[ 9 - 1]; onActivated: Logic.tabSelect( 9 - 1)}
    Shortcut {sequence: TabJs.keys[10 - 1]; onActivated: Logic.tabSelect(10 - 1)}

    Shortcut {sequence: "Alt+l"; onActivated: {Logic.tabSelect(tabContainer.currentIndex + 1)}}
    Shortcut {sequence: "Alt+h"; onActivated: {Logic.tabSelect(tabContainer.currentIndex - 1)}}

    Shortcut {sequence: "Ctrl+w"; onActivated: {Logic.tabClose(tabContainer.currentIndex)}}


    RowLayout {
        anchors.fill: parent

        ColumnLayout {
            id: leftColumn

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            Layout.fillWidth: false
            Layout.preferredWidth: Logic.isHoogleMode() ? leftColumnWidthHoogle : leftColumnWidthNormal

            spacing: 1

            TextInput {
                id: searchInput

                // when the application started, this field will have focus
                focus: true

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: Style.ewPadding
                anchors.rightMargin: Style.ewPadding

                selectByMouse: true

                font: Style.searchFont

                onTextChanged: {
                    // TODO @incomplete:
                    //
                    // Ideally, matchContainer.selected should be set to -1 when
                    // onMatchesChanged, to reflect the fact that the selection
                    // is no longer correct due to the change of the matches.
                    //
                    // But I haven't found a way to do this, as an approximation,
                    // do it here, which assumes that whenever the text changed,
                    // so does the matches. This assumption is not always true,
                    // when it is false, we suffer from a bad performance, but
                    // the functionality is still correct.
                    if (matchContainer.selected !== -1) matchContainer.selected = -1;

                    search(text);
                }

                onAccepted: Logic.matchSelect(0)

                Keys.onEscapePressed: text = ""
                // TODO @incomplete: press Down key to accept
            }


            ScrollView {
                id: matchContainerFocusScope

                anchors.top: searchInput.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                ColumnLayout {

                    spacing: 1
                    width: matchContainerFocusScope.viewport.width

                    Repeater {
                        id: matchContainer

                        model: matches

                        property int selected: -1

                        Match {
                            isSelected: index === matchContainer.selected
                            onClicked: Logic.matchOpen(index)
                            Keys.onPressed: {
                                if (event.key === Qt.Key_Tab || event.key === Qt.Key_Down) {
                                    Logic.matchSelect(index + 1);
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_Backtab || event.key === Qt.Key_Up) {
                                    Logic.matchSelect(index - 1);
                                    event.accepted = true;
                                }
                            }
                        }

                    }
                }
            }

        }


        TabView {
            id: tabContainer

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: leftColumn.right
            anchors.right: parent.right
        }

    }
}
