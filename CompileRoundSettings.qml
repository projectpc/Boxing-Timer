import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    // id:tumbler_1
    title: qsTr("Настройка раунда")
    anchors.fill: parent

    Component.onCompleted:{
        list.contentItem.children[0].text = qsTr("Время раунда")
        list.contentItem.children[0].countR = myWindow.timerSettingDef.length/2

        list.contentItem.children[1].text = qsTr("Время сигнала до конца раунда")

        list.contentItem.children[1].countR = myWindow.timerSettingDef[0]

        list.contentItem.children[2].text = qsTr("Время периода")
        list.contentItem.children[2].countR = myWindow.timerSettingDef[1]

        list.contentItem.children[3].text = qsTr("сигнал конца раунда")
        list.contentItem.children[3].countR = myWindow.timerSettingDef[1]

        list.contentItem.children[4].text = qsTr("период сигнала внутри")
        list.contentItem.children[4].countR = myWindow.timerSettingDef[1]

        list.contentItem.children[5].text = qsTr("время для подготовки")
        list.contentItem.children[5].countR = myWindow.timerSettingDef[1]

    }

    ScrollView {
        anchors.fill: parent
        ListView {
            id:list

            width: parent.width
            model: 6
            delegate: ItemDelegate {
                property alias countR: krug.text
                text: "Item "
                font.pixelSize: Qt.application.font.pixelSize * 1.3
                width: parent.width

                Label{
                    id:krug
                    text:""
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10

                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                }
                onClicked: {
                    //colorDialog.color("#ffffff")
                    list.currentIndex=index
                    index>0?tumblerTimes.visible=true:tumblerRoundsCount.visible=true


                }
                Rectangle{
                    width: parent.width
                    height: 1
                    color: "#000000"
                    anchors.bottom: parent.bottom
                }
            }

        }
    }
    Tumbler_2{
        id:tumblerTimes
        anchors.centerIn: parent
        visible: false
        property string min: ""
        property string sec: ""
       // var tex="%1:%2";

        onVisibleChanged:{
            if(visible){
                min=list.contentItem.children[list.currentIndex].countR.split(':')[0]
                sec=list.contentItem.children[list.currentIndex].countR.split(':')[1]
                tumbler.setCurrentIndexAt(0,min)
                tumbler.setCurrentIndexAt(1,sec)
            }
            else {
                timerSettingDef[0]=list.contentItem.children[1].countR
                timerSettingDef[1]=list.contentItem.children[2].countR
                myWindow.setTimerDef(list.contentItem.children[0].countR, timerSettingDef)
            }
        }

        onSignalMin:{
            if(visible){
                //                Изменяю текст активного элемента
                min=count
                list.contentItem.children[list.currentIndex].countR=min+":"+sec
            }
        }
        onSignalSec:{
            if(visible){
                //                Изменяю текст активного элемента
                sec=count
                list.contentItem.children[list.currentIndex].countR=min+":"+sec
            }
        }

    }
}
