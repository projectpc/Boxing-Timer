// var itm=stackView.find (function (item) {return item.objectName === "pageStart"})

//Ищем страниу находящуюся в стеке с objectName= "pageStart"
//и возвращаем обьект страницы если не нашли то null .Дальше можно обращатся к элементам
//----------------------------------------------------------------------------------
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import QtMultimedia 5.8
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0

ApplicationWindow {
    id: myWindow
    visible: true
    width:  368
    height: 731
    property alias stackView: stackView
    property alias topBarColor: topBarColor

    property alias player: player
    property var timerSettingDef: setTimerDef2(6,"00:06","00:03")
    property var timerFon: {
        "Round": "green",
                "RoundEnd": "red",
                "Rest": "yellow"
    }
/////////
    property var beepPath: [
        "qrc:/signal/Alert.mp3",    // 0 - Round
        "qrc:/signal/Gong2.mp3",    // 1 - RoundEnd
        "qrc:/signal/Alert.mp3",    // 2 - Rest
        "qrc:/signal/Restend.mp3",  // 3 - RestEnd
        "qrc:/signal/Alert.mp3"     // 4 - Period
    ]
    //Round RoundEnd Rest RestEnd Period
    property var beepName: [
        "Alert","Gong2","Alert","Restend","Alert"
    ]
    property string startButtonText: startButton.text
    property bool pause: startButton.text=="Пауза"?true:false


    property string myWindowColor:myWindow.color
    property alias myWindow:myWindow
    property alias footerBar: footerBar

    property color color_Text_Timer:"#fff"
    property color color_Fon_Timer:"#303030"
    property alias topBar: topBar
    Settings {
        property alias colorPanel:myWindow.color_Text_Timer
        property alias colorTextTimer:myWindow.color_Fon_Timer
        property alias colorBar: topBarColor.color
    }

    onActiveChanged:{
        setTimerDef(6, timerSettingDef)
    }

    function setTimerDef2(count, roundTime,restTime) {
        var mass=[]
        for(var i=0;i<count*2;i++){
            if(i%2){
                mass[i]=restTime
            }
            else mass[i]=roundTime
        }
        return mass
    }

    function setTimerDef(count, timerSettingDef) {
        for(var i=0;i<count*2;i++){
            if(i%2){
                timerSettingDef[i]=timerSettingDef[1]
            }
            else timerSettingDef[i]=timerSettingDef[0]
        }

    }

    header: ToolBar {
        id:topBar
        contentHeight: toolButton.implicitHeight
        Rectangle{
            id:topBarColor
            anchors.fill: parent
            color: "transparent"
            Settings {
                  property alias colorBar:topBarColor.color
                }
        }

        ToolButton {
            id: toolButton
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: stackView.depth > 1 ? "images/back.png" : "images/drawer.png"
            }
            //            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            //            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: myWindow.width * 0.66
        height: myWindow.height
        onAboutToShow:{

            var itm=stackView.find (function (item) {return item.objectName === "pageStart"})
//           console.log("-------------",itm)
//            itm!==null&stackView.currentItem.timer.running?
//                          stackView.currentItem.timer.stop():""
            if(itm!==null&itm.timer.running){
                        itm.timer.stop()}
        }
        dragMargin: 0
        Column {
            anchors.fill: parent

            Rectangle{
                width: parent.width
                height: nameDrawer.height+1

                anchors.horizontalCenter: parent.horizontalCenter
                // opacity: 0.3
                color: myWindow.color
                Label{
                    id:nameDrawer
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                    text: "Настройки"
                }
            }
            ItemDelegate {
                text: qsTr("Цвет")
                font.pixelSize:Qt.application.font.pixelSize * 1.3
                width: parent.width
                onClicked: {
                    stackView.push("TimerColor.qml")
                    drawer.close()
                }
                Rectangle{
                    width: parent.width
                    height: 1
                    color: "#000"
                    anchors.bottom: parent.bottom
                }
            }
            ItemDelegate {
                text: qsTr("Раунд")
                font.pixelSize:Qt.application.font.pixelSize * 1.3
                width: parent.width
                onClicked: {
                    stackView.push("Round_Settings.qml")
                    drawer.close()

                }
                Rectangle{
                    width: parent.width
                    height: 1
                    color: "#000"
                    anchors.bottom: parent.bottom
                }
            }
            ItemDelegate {
                text: qsTr("Ручное Время")
                font.pixelSize:Qt.application.font.pixelSize * 1.3
                width: parent.width
                onClicked: {
                    stackView.push("Round_Settings_Edit.qml")
                    drawer.close()

                }
                Rectangle{
                    width: parent.width
                    height: 1
                    color: "#000"
                    anchors.bottom: parent.bottom
                }
            }
            //
            ItemDelegate {
                text: qsTr("Звук")
                font.pixelSize:Qt.application.font.pixelSize * 1.3
                width: parent.width
                onClicked: {
                    stackView.push("SoundSettings.qml")
                    drawer.close()

                }
                Rectangle{
                    width: parent.width
                    height: 1
                    color: "#000"
                    anchors.bottom: parent.bottom
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "StartPage.qml"//"StartPage.qml"
        anchors.fill: parent

        onCurrentItemChanged:{
            stackView.depth > 1
                    ? footerBar.visible=false
                    : footerBar.visible=true
            if(stackView.depth === 1){
                stackView.currentItem.timer_text.text=timerSettingDef[0]
                //   stackView.currentItem.tumblerMin=timerSettingDef[0].split(':')[0]
                //  stackView.currentItem.tumblerSec=timerSettingDef[0].split(':')[1]
            }
            else{
                stackView.get(0).timer.stop()
                //stackView.currentItem.timer.stop()
            }

        }
    }

    footer:ToolBar {
        id:footerBar
        visible: false
        // contentHeight: toolButton.implicitHeight
        Rectangle{
            id:footerBarColor
            anchors.fill: parent
            color: topBarColor.color//"transparent"
        }
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: resetButton
                implicitWidth: myWindow.width/2
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                // Layout.fillWidth: true
                text: qsTr("Сброс")
                property int clic: 1
                onClicked: {
                    console.log(timerSettingDef)
                    topBarColor.color="#000"
                   // cppClass.scrinDimLuck()
                    ///     stackView.currentItem.tumblerSec=59//tumbler.currentIndex=1
                    ///     stackView.currentItem.tumblerMin=80

                    //  console.log(stackView.get(1))
                    //    console.log(stackView.currentItem.title)
                    //myWindow.color="transparent"//settings.color_EndRound
                    //  stackView.currentItem.panelColor=myWindow.color

                }
            }

            ToolButton {
                id: startButton
                implicitWidth: myWindow.width/2
                //  property int click: 1
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                text:stackView.currentItem.timerRunning?  qsTr("Пауза") :qsTr("Старт")
                //stackView.currentItem.timer.running?  qsTr("Пауза") :qsTr("Старт")//click? qsTr("Старт"): qsTr("Пауза")
                onClicked: {

                    //cppClass.scrinFullLuck()
                    if(stackView.currentItem.timer.running){

                      //  stackView.currentItem.timer.stoped=true
                        stackView.currentItem.timer.stop()
                    }
                    else{
                        //stackView.currentItem.timer.stoped=false
                        stackView.currentItem.timer.start()
                    }

                    //                    stackView.currentItem.timer.running?
                    //                                stackView.currentItem.timer.stop()
                    //                              :stackView.currentItem.timer.start()

                }

            }
        }
    }



    Audio {
        id: player;
        autoPlay: true
        volume: 1.0
    }
    function beep(path){
        player.source=path
        player.play()
    }
}
