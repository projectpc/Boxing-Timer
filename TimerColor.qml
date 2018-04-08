import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id:timerColor
    title: qsTr("Настройка цвета")
    property alias colorDialog: colorDialog
    property alias list:list

    ScrollView {
        anchors.fill: parent
        id:scrol
        ListView {
            id:list
            width: parent.width
            model: 6
            delegate: ItemDelegate {
                text: switch(index){
                      case 0:
                          qsTr("Цвет таймера")
                          break
                      case 1:
                          qsTr("Фон таймера")
                          break
                      case 2:
                          qsTr("Фон раунда")
                          break
                      case 3:
                          qsTr("Фон конца раунда")
                          break
                      case 4:
                          qsTr("Фон в перерыве")
                          break
                      case 5:
                          qsTr("Цвет панелей")
                          break
                      default :"ERROR"+index
                          break
                      }

                font.pixelSize: Qt.application.font.pixelSize * 1.3
                width: parent.width
                property alias color: krug.color

                Rectangle{
                    id:krug
                    color:  switch(index){
                            case 0:
                                color=myWindow.color_Text_Timer
                                break
                            case 1:
                                myWindow.color_Fon_Timer
                                break
                            case 2:
                                timerFon.Round
                                break
                            case 3:
                                timerFon.RoundEnd
                                break
                            case 4:
                                timerFon.Rest
                                break
                            case 5:
                                topBarColor.color
                                break
                            default :"ERROR"
                                break
                            }
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10
                    width: 24
                    height: 24
                    radius: 100
                    border.color: "#000"
                }
                onClicked: {


                    colorDialog.setColor(color)
                    colorDialog.visible=true
                    console.log("==index===",index)
list.currentIndex=index

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

    ColorDialog{
        id:colorDialog

        onSignalOk:{

            list.currentIndex===0?list.contentItem.children[0].color = color
                                 :list.contentItem.children[list.currentIndex+1].color = color


if(list.currentIndex==0){
            myWindow.color_Text_Timer=""+list.contentItem.children[0].color
}

            myWindow.color_Fon_Timer=""+list.contentItem.children[2].color
            timerFon.Round=""+list.contentItem.children[3].color
            timerFon.RoundEnd=""+list.contentItem.children[4].color
            timerFon.Rest=""+list.contentItem.children[5].color
            topBarColor.color=""+list.contentItem.children[6].color

        }



        onVisibleChanged: {

            visible?myWindow.topBar.visible=false:myWindow.topBar.visible=true
        }
    }

}
