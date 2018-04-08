import QtQuick 2.9
import QtQuick.Controls 2.2
import Qt.labs.folderlistmodel 2.1

Page {
    id:root
    property alias list2: list2
    property int iter:0
    property string nameText:""

    ScrollView {
        //anchors.fill: parent
        id:scrol
        width: parent.width
        //  height: parent.height-90-bar.height
        height: parent.height-85
        // anchors.top: bar.bottom

        ListView {
            id:list2
            // displayMarginBeginning:-20
            // displayMarginEnd:-10
            anchors.fill: parent
            FolderListModel {
                id:dataModel
                nameFilters: [ "*"]
                folder: "signal/"
            }
            model: dataModel
            delegate: RadioDelegate {
                text: fileBaseName
                width: parent.width
                property string path: "qrc"+filePath
                checked: text===beepName[iter]?true:false
                onClicked: {
                    player.source="qrc"+filePath
                    player.play()
                    list2.currentIndex=index
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


    Button{
        id:ok
        text: "ok"
        width: parent.width-14
        height: 48
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        property string nameX: ""
        onClicked: {
          var itm2=stackView.find (function (item) {return item.objectName === "pageSound"})

            beepName[iter]=list2.contentItem.children[list2.currentIndex].text
           iter==0 ? itm2.list.contentItem.children[iter].name=list2.contentItem.children[list2.currentIndex].text
                   :itm2.list.contentItem.children[iter+1].name=list2.contentItem.children[list2.currentIndex].text
            beepPath[iter]=list2.contentItem.children[list2.currentIndex].path
            stackView.pop()
        }
    }

    //Ищем страниу находящуюся в стеке с objectName= "pageStart"
    //и возвращаем обьект страницы если не нашли то null
    // var itm=stackView.find (function (item) {return item.objectName === "pageSound"})

}
