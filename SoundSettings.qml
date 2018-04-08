import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id:pageSound
    objectName: "pageSound"
    title: qsTr("Настройка звуков")
    property alias list: list

    ScrollView {
        anchors.fill: parent

        ListView {
            id:list
            objectName: "list"
            width: parent.width
            model: 5
            delegate: ItemDelegate {
                property alias name: name.text
                property alias title: title.text
                property alias tit: title.text
                width: parent.width


                Label{
                    id:title
                    text: switch(index){
                          case 0:
                              qsTr("Начало Раунда")
                              break
                          case 1:
                              qsTr("Перед концом раунд")
                              break
                          case 2:
                              qsTr("Начало Перерыва")
                              break
                          case 3:
                              qsTr("Перед концом перерыва")
                              break
                          case 4:
                              qsTr("Сигнал внутри раунда")
                              break
                          default :"ERROR"
                              break
                          }
                    anchors.bottom: parent.verticalCenter
                    font.bold: true
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    opacity: 0.9
                    font.pixelSize: Qt.application.font.pixelSize * 1.3
                }
                Label{
                    id:name
                    anchors.top: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    opacity: 0.8
                    font.pixelSize: Qt.application.font.pixelSize * 1.2
                    text:beepName[index]
                }

                Rectangle{
                    width: parent.width
                    height: 1
                    color: "#000000"
                    anchors.bottom: parent.bottom
                }

                onClicked: {
                    list.currentIndex=index
                    stackView.push("SoungDialog.qml",{title:title.text,iter:list.currentIndex})
                }
            }
        }
    }

}
