import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Extras 1.4

Rectangle {
    id:frame
    signal returnTime(int m,int s)
    property alias tumblerMin: tumblerMin
    property alias tumblerSec: tumblerSec
    property alias tumbler: tumbler
    signal signalMin(string count)
    signal signalSec(string count)
radius: 5
    implicitWidth: tumbler.width
    implicitHeight: tumbler.height
    color: "#303030"
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -47

    Tumbler {
        id:tumbler
        anchors.centerIn: parent
        //  anchors.verticalCenterOffset: -47
        height: myWindow.height>myWindow.width?
                    myWindow.width*0.5:myWindow.height*0.5
        Rectangle{
            color: myWindow.color
            width: parent.width-2
            height: 40
            anchors.centerIn: parent
            opacity: 0.3
        }
        Label{
            text: "Мин"
            x:tumblerMin.width/2-10
            y:7
            color: "#000000"

        }
        Label{
            text: "Сек"
            x:tumblerMin.width + tumblerSec.width/2+4
            y:7
            color: "#000000"
        }
        TumblerColumn {
            id: tumblerMin
            // model: 91
            onCurrentIndexChanged: {
                if(currentIndex<10)signalMin("0"+currentIndex)
                else signalMin(currentIndex)

            }
            width: myWindow.height>myWindow.width?
                       (myWindow.width*0.9)/2:myWindow.height/2
            model: ListModel {
                Component.onCompleted: {
                    for (var i = 0; i < 91; ++i) {
                        i<10?append({value: 0+i.toString()})
                            :append({value: i.toString()})
                    }
                }
            }

        }
        TumblerColumn {
            id: tumblerSec
            onCurrentIndexChanged: {
                if(currentIndex<10)signalSec("0"+currentIndex)
                else signalSec(currentIndex)
            }
            width: myWindow.height>myWindow.width?
                       (myWindow.width*0.9)/2:myWindow.height/2

            model: ListModel {
                Component.onCompleted: {
                    for (var i = 0; i < 60; ++i) {
                        i<10?append({value: 0+i.toString()})
                            :append({value: i.toString()})
                    }
                }
            }
        }
    }


    Rectangle{
        width: parent.width
        height: 33
        radius: 5
        // border.width: 1
        y:tumbler.y+tumbler.height+5
        x:tumbler.x
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#303030"//"transparent"
    }

    Button{
        text: "OK"
        width: parent.width
        height: 46
        //anchors.top: parent.bottom
        y:tumbler.y+tumbler.height-1
        x:tumbler.x+1
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            frame.visible=false
        }
    }


}

