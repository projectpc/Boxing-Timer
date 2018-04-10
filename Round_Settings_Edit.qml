import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    // id:tumbler_1
    title: qsTr("Настройка тайминга")
  //  anchors.fill: parent
    Component.onCompleted:  {
       console.log("----------","Component.onCompleted")

    }
onVisibleChanged: {
    if(visible==false)console.log("----------","visible==false")
    dataRead()
}
    ScrollView {
        anchors.fill: parent
        // ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ListView {
            id:list
            width: parent.width
            model: myWindow.timerSettingDef.length
            delegate: ItemDelegate {
                property alias countR: krug.text
                property alias textName: textName.text

                //                property alias colors: colors.color
                //                property alias textName: textName.text
                // text: "Раунд "+ (index + 1)
               font.pixelSize: Qt.application.font.pixelSize * 1.5
                width: parent.width
                Rectangle{
                    id:colors
                    anchors.fill: parent
                    color: setColor(index)
                    opacity: 0.7
                }
                Label{
                   // id:textName

                    text:setText(index)
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    font.pixelSize: Qt.application.font.pixlSize * 1.5
                }
                Label{
                    id:textName
                    text:index%2?"Отдых":"Раунд"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                   // anchors.leftMargin: 10
                    font.pixelSize: Qt.application.font.pixlSize * 1.5
                }
                Label{
                    id:krug
                    text:myWindow.timerSettingDef[index]
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10
                    font.pixelSize: Qt.application.font.pixelSize * 1.5
                }
                onClicked: {
                    //colorDialog.color("#ffffff")
                    list.currentIndex=index
                    // index>0?tumblerTimes.visible=true:tumblerRoundsCount.visible=true
                    tumblerTimes.visible=true

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
            visible?setIndex(list.contentItem.children[list.currentIndex].countR-1)
                   :list.contentItem.children[list.currentIndex].countR=tumblerMin.currentIndex+1
        }
        onSignalOk:{
            if(visible){
                //                Изменяю текст активного элемента
                list.contentItem.children[list.currentIndex].countR= count+1
                //                Сохраняю в переменные
                myWindow.round_Count=list.contentItem.children[0].countR
                myWindow.round_Time=list.contentItem.children[1].countR
            }
        }
    }

    Tumbler_2{
        id:tumblerTimes
        anchors.centerIn: parent
        visible: false
        property string min: ""
        property string sec: ""
        onVisibleChanged:{
            if(visible){
                list.enabled=false
                min=timerSettingDef[list.currentIndex].split(':')[0]
                sec=timerSettingDef[list.currentIndex].split(':')[1]
                tumbler.setCurrentIndexAt(0,min)
                tumbler.setCurrentIndexAt(1,sec)
            }
            else {
                list.enabled=true
            }
        }

        onSignalMin:{
            if(visible){
                //                Изменяю текст активного элемента
                min=count
                list.contentItem.children[list.currentIndex].countR=min+":"+sec
                timerSettingDef[list.currentIndex]=min+":"+sec
            }
        }

        onSignalSec:{
            if(visible){
                //                Изменяю текст активного элемента
                sec=count
                list.contentItem.children[list.currentIndex].countR=min+":"+sec
                timerSettingDef[list.currentIndex]=min+":"+sec
            }
        }
    }
    function dataRead(){
       for(var i=0;i<list.count;i++){
           if(i!=1)console.log(list.contentItem.children[i].countR);
       }

    }


    function setText(index){
        var intR=1
        if(index%2==0){
            if(index!==0)intR=(index-index/2)+1
            return intR
        }
        else return ""

    }
    function setColor(index){
        if(index%2){
            return dataBase.getColor("colorRest")//myWindow.color_Pause
        }
        else return dataBase.getColor("colorRound")//myWindow.color_Round
    }

}
