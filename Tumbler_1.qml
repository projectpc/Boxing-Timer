import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Extras 1.4

Rectangle {
    id:frame

    property alias tumblerMin: tumblerMin
    signal signalOk(int count)
    radius: 5
        implicitWidth: tumbler.width
        implicitHeight: tumbler.height
        color: "#303030"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -47
    Tumbler {
        id:tumbler
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -47
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
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Раунды"
            y:7
            color: "#000000"

        }
        TumblerColumn {
            id: tumblerMin

            model: ListModel {
                Component.onCompleted: {
                    for (var i = 1; i < 91; ++i) {
                        append({value: i.toString()})
                    }
                }
            }
            width: myWindow.height>myWindow.width?
                       myWindow.width*0.9:myWindow.height
              onCurrentIndexChanged: signalOk(currentIndex)
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

    function setIndex(index){
        tumbler.setCurrentIndexAt(0,index)
    }

}

