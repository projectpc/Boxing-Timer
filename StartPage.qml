import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtSensors 5.0

Page {
    id:pageStart
    objectName: "pageStart"
    title: setText(timer.count)
  //  property alias panelColor: panelColor
    property alias timer: timer
    property alias timerRunning: timer.running
    property alias timer_text: timer_text
    property bool worckRound : false

    Rectangle{
        id:panelColor
        anchors.fill: parent
        color:myWindow.color_Fon_Timer

    }


    Label{
        id:timer_text
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -5
        anchors.horizontalCenterOffset: -4
        font.pixelSize: windowSize()//*0.8
        color: myWindow.color_Text_Timer
        font.bold: true
        font.family: openSans.name
        text: timerSettingDef[0]//minSec(parseInt(timerSettingDef[0].split(":")[0]),parseInt(timerSettingDef[0].split(":")[1]))//textMin[3]+":"+textSec[0]
        //   font.family: openSans.name
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
        interval: 1000
        // triggeredOnStart :true
        property int count: 0
        property int min:timer_text.text.split(":")[0]//timerSettingDef[0].split(":")[0]
        property int sec:timer_text.text.split(":")[1]// timerSettingDef[0].split(":")[1]
        //  onSecChanged:  console.log("sec--")
        // onMinChanged: console.log("min--")

        onCountChanged: console.log("///////////////"+count+"//////////////////////")



        onRunningChanged: {
            if(running){
                console.log("------START---------")
                if(worckRound){

                    console.log("++++++++Round_Start_________")
                    panelColor.color=timerFon.Round
                    beep(beepPath[0])
                }
                else {
                    console.log("++++++++++Rest_Start__________")
                    panelColor.color=timerFon.Rest
                    beep(beepPath[2])
                }

            }
        }
        onTriggered: {
            if(worckRound){
                console.log("------Round_Curent_________")
                //Сигнал до окончания раунда +1
                if(timer.min===0&timer.sec==3){
                    beep(beepPath[1])
                    panelColor.color=timerFon.RoundEnd
                }
            }
            else {
                console.log("------Rest_Curent_________")
                //Сигнал до окончания отдыха +1
                if(timer.min===1&timer.sec==3)beep(beepPath[3])
            }
            timer.sec--
            timer_text.text=minSec(timer.min,timer.sec)

            if(timer.min>0&timer.sec==0){timer.min--;timer.sec=60;}

            if(timer.min==0&timer.sec==0){
                timer.stop()
                timer.count++
                timer.min= timerSettingDef[timer.count].split(":")[0]
                timer.sec= timerSettingDef[timer.count].split(":")[1]
                timer_text.text=minSec(timer.min,timer.sec)
                timer.start()
            }
        }

    }

    function time1(){
        if(worckRound){
            console.log("------Round_Curent_________")
            //Сигнал до окончания раунда +1
            if(timer.sec==3)beep(beepPath[1])
        }
        else {
            console.log("------Rest_Curent_________")
            //Сигнал до окончания отдыха +1
            if(timer.sec==3)beep(beepPath[3])
        }
        timer.sec--
        timer_text.text=minSec(timer.min,timer.sec)

        if(timer.min>0&timer.sec==0){timer.min--;timer.sec=60;}

        if(timer.min==0&timer.sec==0){
            timer.stop()
            timer.count++
            timer.min= timerSettingDef[timer.count].split(":")[0]
            timer.sec= timerSettingDef[timer.count].split(":")[1]
            timer_text.text=minSec(timer.min,timer.sec)
            timer.start()
        }

    }

    function minSec(minut,secund){
        var textMin=""
        if(minut>9)textMin=minut
        else textMin="0"+minut
        if(secund>9)return textMin+":"+secund
        else return textMin+":"+"0"+secund

    }
    function windowSize(){
        if(myWindow.width>myWindow.height)return myWindow.height*0.45//2.2//*0.45
        if(myWindow.width<myWindow.height)return myWindow.width*0.45//2.2//*0.45
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
    function setText(index){
        var intR=1
        if(index%2==0){
            if(index!==0)intR=(index-index/2)+1
            worckRound=true
            return qsTr("Раунд "+intR+"/"+myWindow.timerSettingDef.length/2)
        }
        else {worckRound=false ; return "Перерыв"}
    }
    FontLoader {
        id: openSans
        source: "qrc:/font/digital.ttf"
    }
}
