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
                          qsTr("Цвет циферблата")
                          break
                      case 1:
                          qsTr("Цвет экрана")
                          break
                      case 2:
                          qsTr("Цвет панелей")
                          break
                      case 3:
                          qsTr("Фон раунда")
                          break
                      case 4:
                          qsTr("Фон конца раунда")
                          break
                      case 5:
                          qsTr("Фон в перерыве")
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
                                dataBase.getColor("colorTimerFont")
                                break
                            case 1:
                                dataBase.getColor("colorScreen")
                                break
                            case 2:
                                dataBase.getColor("colorPanel")
                                break
                            case 3:
                                dataBase.getColor("colorRound")
                                break
                            case 4:
                                dataBase.getColor("colorRoundEnd")
                                break
                            case 5:
                                dataBase.getColor("colorRest")
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
                // timerFon.colorScreen=""+list.contentItem.children[0].color
                dataBase.setColor("colorTimerFont",list.contentItem.children[0].color)
            }

            dataBase.setColor("colorScreen",list.contentItem.children[2].color)
            dataBase.setColor("colorPanel",list.contentItem.children[3].color)
            dataBase.setColor("colorRound",list.contentItem.children[4].color)
            dataBase.setColor("colorRoundEnd",list.contentItem.children[5].color)
            dataBase.setColor("colorRest",list.contentItem.children[6].color)


//            dataBase.setColor("colorRound",list.contentItem.children[3].color)
//            dataBase.setColor("colorRoundEnd",list.contentItem.children[4].color)
//            dataBase.setColor("colorRest",list.contentItem.children[5].color)
//            dataBase.setColor("colorPanel",list.contentItem.children[6].color)


            var itm=stackView.find (function (item) {return item.objectName === "pageStart"})
            console.log(itm)
            itm.updatePanel();
            //Ищем страниу находящуюся в стеке с objectName= "pageStart"
            //и возвращаем обьект страницы если не нашли то null .Дальше можно обращатся к элементам
        }



        onVisibleChanged: {

            visible?myWindow.topBar.visible=false:myWindow.topBar.visible=true
        }
    }

}
