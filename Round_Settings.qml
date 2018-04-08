import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
     id:roundSeting
    title: qsTr("Настройка тайминга")
    //anchors.fill: parent
    property alias  list: list

    ScrollView {
        anchors.fill: parent
        ListView {
            id:list

            width: parent.width
            model: 6
            delegate: ItemDelegate {
                property alias countR: krug.text
                text: switch(index){
                      case 0:
                          qsTr("Количество раундов")
                          break
                      case 1:
                          qsTr("время раунда")
                          break
                      case 2:
                          qsTr("время отдыха")
                          break
                      case 3:
                          qsTr("сигнал конца раунда")
                          break
                      case 4:
                          qsTr("период сигнала внутри")
                          break
                      case 5:
                          qsTr("время для подготовки")
                          break
                      default :"ERROR"
                          break
                      }
                font.pixelSize: Qt.application.font.pixelSize * 1.3
                width: parent.width

                Label{
                    id:krug
                    text:switch(index){
                         case 0:
                             myWindow.timerSettingDef.length/2
                             break
                         case 1:
                             myWindow.timerSettingDef[0]
                             break
                         case 2:
                             myWindow.timerSettingDef[1]
                             break
                         case 3:
                             myWindow.timerSettingDef[1]
                             break
                         case 4:
                             myWindow.timerSettingDef[1]
                             break
                         case 5:
                             myWindow.timerSettingDef[1]
                             break
                         default :"ERROR"
                             break
                         }
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10

                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                }
                onClicked: {
                    //colorDialog.color("#ffffff")
                    list.currentIndex=index
                    console.log("----------",list.currentIndex)
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

    Tumbler_1{
        id:tumblerRoundsCount
        anchors.centerIn: parent
        visible: false
        onVisibleChanged:{
            //                Сохраняю в переменные
            visible?setIndex(list.contentItem.children[list.currentIndex].countR-1)
                   : myWindow.setTimerDef(tumblerMin.currentIndex+1, timerSettingDef)

        }
        onSignalOk:{
            if(visible){
                //                Изменяю текст активного элемента
                list.contentItem.children[list.currentIndex].countR= count+1
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
                min=list.contentItem.children[list.currentIndex+1].countR.split(':')[0]
                sec=list.contentItem.children[list.currentIndex+1].countR.split(':')[1]
                tumbler.setCurrentIndexAt(0,min)
                tumbler.setCurrentIndexAt(1,sec)
            }
            else {

                timerSettingDef[0]=list.contentItem.children[2].countR
                timerSettingDef[1]=list.contentItem.children[3].countR
                myWindow.setTimerDef(list.contentItem.children[0].countR, timerSettingDef)

            }
        }

        onSignalMin:{
            if(visible){
                //                Изменяю текст активного элемента
                min=count
                list.contentItem.children[list.currentIndex+1].countR=min+":"+sec
            }
        }
        onSignalSec:{
            if(visible){
                //                Изменяю текст активного элемента
                sec=count
                list.contentItem.children[list.currentIndex+1].countR=min+":"+sec
            }
        }

    }
}
