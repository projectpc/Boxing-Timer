import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtSensors 5.0
Page {
    id:startPage
    title: qsTr("Раунд "+round_Curent+"/"+myWindow.round_Count)

    property alias panelColor: panelColor.color
    property alias timer: timer
    property alias tumblerMin: tumblerMin.currentIndex
    property alias tumblerSec: tumblerSec.currentIndex
    property bool roundWork: false
    onVisibleChanged: {
        // updateValue()

        //if(visible===false)tumblerMin=setingValue[0][0].split(':')[0]

        //   stackView.currentItem.tumblerSec=setingValue[0][0].split(':')[1]

    }

    Rectangle{
        id:panelColor
        anchors.fill: parent
        color:dataBase.getColor("colorScreen")//myWindow.color_Fon_Timer
    }


    Tumbler {
        id: tumblerMin
        anchors.right: razdelitel.left
        anchors.verticalCenter: razdelitel.verticalCenter
        anchors.verticalCenterOffset: +20
        implicitWidth: windowSize3()
        //  Layout.fillWidth: true
        //  Layout.fillHeight: true
        implicitHeight:windowSize3()// tumblerSec.width
        font.pixelSize:textSize()//parent.width*0.56// Qt.application.font.pixelSize * 16
        model: 91
        // wrap: false
        currentIndex: myWindow.timerSettingDef.split(':')[0]//setingValue[0][0].split(':')[0]
        //myWindow.round_Time.split(':')[0]//myWindow.round_Min//count-1
        visibleItemCount: 1
        font.family: openSans.name

        MouseArea{
            anchors.fill: parent
            focus: true
        }
        delegate:Label {
            text: formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: dataBase.getColor("colorTimerFont")

        }
    }

    ColumnLayout{
        id:razdelitel
        spacing: textSize()/4
        anchors.centerIn: parent
        Rectangle{
            color: dataBase.getColor("colorTimerFont")
            radius: 100
            implicitWidth: windowSize3()/10
            implicitHeight: windowSize3()/10
        }
        Rectangle{
            color: dataBase.getColor("colorTimerFont")
            radius: 100
            implicitWidth: windowSize3()/10
            implicitHeight: windowSize3()/10
        }
    }

    Tumbler {
        id: tumblerSec

        anchors.left: razdelitel.right
        anchors.verticalCenter: razdelitel.verticalCenter
        anchors.verticalCenterOffset: +20
        implicitWidth: windowSize3()
        //  Layout.fillWidth: true
        implicitHeight: windowSize3()//windowSize3()
        font.pixelSize: textSize()//textSize()
        font.family: openSans.name
        model: 60
        currentIndex: myWindow.timerSettingDef.split(':')[1]//setingValue[0][0].split(':')[1]//myWindow.round_Time.split(':')[1]//myWindow.round_Sec//count-1
        visibleItemCount: 1

        MouseArea{
            anchors.fill: parent
            focus: true
        }

        //        onCurrentIndexChanged: {
        //            if(currentIndex==0&&tumblerMin.currentIndex>0)tumblerMin.currentIndex--
        //            if(currentIndex==0&&tumblerMin.currentIndex==0){

        //                timer.stop()
        //                if(round_Curent<round_Count&roundWork){
        //                    startPage.title=qsTr("Раунд "+round_Curent+"/"+myWindow.round_Count)


        //                    tumblerMin.currentIndex=timerSettingDef[round_Curent].split(':')[0]
        //                    tumblerSec.currentIndex=timerSettingDef[round_Curent].split(':')[1]
        //                    round_Curent++
        //                    roundWork=false
        //                    timer.start()

        //                }
        //                else{


        //                    startPage.title=qsTr("Перерыв")
        //                    tumblerMin.currentIndex=timerSettingDef[round_Curent].split(':')[0]
        //                    tumblerSec.currentIndex=timerSettingDef[round_Curent].split(':')[1]
        //                    round_Curent++
        //                    roundWork=true


        //                    timer.start()

        //                }
        //            }
        //        }

        delegate:Label {
            id:lab
            text: formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: dataBase.getColor("colorTimerFont")
        }

    }

    Tumbler {
        id: restSec
        visible: false
        anchors.left: razdelitel.right
        anchors.verticalCenter: razdelitel.verticalCenter
        anchors.verticalCenterOffset: +20
        implicitWidth: windowSize3()
        implicitHeight: windowSize3()//windowSize3()
        font.pixelSize: textSize()//textSize()
        font.family: openSans.name
        model: 60
        currentIndex: myWindow.timerSettingDef.split(':')[1]//setingValue[0][0].split(':')[1]//myWindow.round_Time.split(':')[1]//myWindow.round_Sec//count-1
        visibleItemCount: 1
        MouseArea{
            anchors.fill: parent
            focus: true
        }
        delegate:Label {
            text: formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: dataBase.getColor("colorTimerFont")
        }

    }

    ProximitySensor {
        id: proxi
        active: false//true
        property int val: 0
        property bool pusk: false
        onReadingChanged: {
            if(!reading.near&val==1){
                val=0;
                pusk?pusk=false:pusk=true
            }
            if(reading.near)val++
        }
    }

    Timer {
        id:timer
        running:  proxi.pusk ? true:false
        repeat: true
        interval: 500
        property int count: 0
        property int min: timerSettingDef[0].split(":")[0]
        property int sec: timerSettingDef[0].split(":")[1]

        onRunningChanged: {
            tumblerMin.currentIndex--
            if(running){
                //  count= timerSettingDef.length
                //  test.color="#303030"
                min= timerSettingDef[count].split(":")[0]
                sec= timerSettingDef[count].split(":")[1]
                restSec.currentIndex=30
            }
            // else test.color="red"
        }
        onTriggered: {
            if(min>0&sec==0){
                min--
                sec=59
                tumblerMin.currentIndex=min//--
                tumblerSec.currentIndex=tumblerSec.count-1

            }

            else if(min>=0&sec>0) {
                sec--
                tumblerSec.currentIndex=sec//--
            }

            if(min==0&sec==0){
                tumblerSec.visible=false
                timer.stop()
                if(count<timerSettingDef.length){
                    count++
                    min= timerSettingDef[count].split(":")[0]
                    sec= timerSettingDef[count].split(":")[1]
                    timer.start()
                }
            }
        }

    }

    function formatText(count, modelData) {
        var data = count === 12 ? modelData + 1 : modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function proximitySensor(){
        var types = QmlSensors.sensorTypes();
        if(types.length<1)return false
        for (var i = 0; i < types.length-1; i++) {
            if(types[i]==="QProximitySensor"){
                return true
            }
        }
    }
    function windowSize3(){
        if(myWindow.width>myWindow.height)return myWindow.height*0.45//-50
        if(myWindow.width<myWindow.height)return myWindow.width*0.45//-50
    }
    function textSize(){
        if(myWindow.width>myWindow.height){
            return myWindow.height*0.4
        }
        if(myWindow.width<myWindow.height)return myWindow.width*0.4
    }
    FontLoader {
        id: openSans
        source: "qrc:/qml/111.otf"
    }
}
