//import QtQuick 2.4
//import QtQuick.Controls 1.2
//import QtQuick.Controls.Private 1.0
//import QtQuick.Dialogs 1.0
//import QtQuick.Window 2.1
import "qml"
import QtQuick.Layouts 1.3

import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    id: root
    anchors.fill: parent
    visible: false
    signal signalOk(string color)

    property alias crosshairs: crosshairs
    property alias content: content
    property color colo:"red"
    property real saturation:0.5
    property real lightness:0.5
    property bool __valueSet: true // guard to prevent binding loops
    function setColor(color){
        var hslxy = rgbToHsl(color)
        crosshairs.x=hslxy.x- crosshairs.radius
        crosshairs.y=hslxy.y- crosshairs.radius
        saturation =hslxy.s
        lightness = hslxy.l
        hueSlider.value=hslxy.h
        recLeft.color=color//Qt.hsla(slid, saturation,lightness,1)

    }

    Rectangle{
        id:colorFon
        anchors.fill: parent
        color: myWindow.color
        ColumnLayout{
            anchors.fill: parent
            spacing: 6
            RowLayout{
                //   height: 1
            }
            Rectangle {
                id: content
                implicitHeight:myWindow.height-130//Screen.pixelDensity*29
                implicitWidth:myWindow.width-10
                color:myWindow.color// palette.window
                focus: root.visible
                anchors.horizontalCenter: parent.horizontalCenter

                ShaderEffect {
                    id: map
                    implicitHeight: parent.height
                    implicitWidth: parent.width
                    //  width: parent.width+100
                    // height: parent.height+100

                    //opacity: alphaSlider.value
                    // scale: paletteMap.width / width;
                    layer.enabled: true
                    layer.smooth: true
                    anchors.centerIn: parent
                    property real hue: hueSlider.value

                    fragmentShader: content.OpenGLInfo.profile === OpenGLInfo.CoreProfile ? "#version 150
                    in vec2 qt_TexCoord0;
                    uniform float qt_Opacity;
                    uniform float hue;
                    out vec4 fragColor;

                    float hueToIntensity(float v1, float v2, float h) {
                        h = fract(h);
                        if (h < 1.0 / 6.0)
                            return v1 + (v2 - v1) * 6.0 * h;
                        else if (h < 1.0 / 2.0)
                            return v2;
                        else if (h < 2.0 / 3.0)
                            return v1 + (v2 - v1) * 6.0 * (2.0 / 3.0 - h);

                        return v1;
                    }

                    vec3 HSLtoRGB(vec3 color) {
                        float h = color.x;
                        float l = color.z;
                        float s = color.y;

                        if (s < 1.0 / 256.0)
                            return vec3(l, l, l);

                        float v1;
                        float v2;
                        if (l < 0.5)
                            v2 = l * (1.0 + s);
                        else
                            v2 = (l + s) - (s * l);

                        v1 = 2.0 * l - v2;

                        float d = 1.0 / 3.0;
                        float r = hueToIntensity(v1, v2, h + d);
                        float g = hueToIntensity(v1, v2, h);
                        float b = hueToIntensity(v1, v2, h - d);
                        return vec3(r, g, b);
                    }

                    void main() {
                        vec4 c = vec4(1.0);
                        c.rgb = HSLtoRGB(vec3(hue, 1.0 - qt_TexCoord0.t, qt_TexCoord0.s));
                        fragColor = c * qt_Opacity;
                    }
                    " : "
                    varying mediump vec2 qt_TexCoord0;
                    uniform highp float qt_Opacity;
                    uniform highp float hue;

                    highp float hueToIntensity(highp float v1, highp float v2, highp float h) {
                        h = fract(h);
                        if (h < 1.0 / 6.0)
                            return v1 + (v2 - v1) * 6.0 * h;
                        else if (h < 1.0 / 2.0)
                            return v2;
                        else if (h < 2.0 / 3.0)
                            return v1 + (v2 - v1) * 6.0 * (2.0 / 3.0 - h);

                        return v1;
                    }

                    highp vec3 HSLtoRGB(highp vec3 color) {
                        highp float h = color.x;
                        highp float l = color.z;
                        highp float s = color.y;

                        if (s < 1.0 / 256.0)
                            return vec3(l, l, l);

                        highp float v1;
                        highp float v2;
                        if (l < 0.5)
                            v2 = l * (1.0 + s);
                        else
                            v2 = (l + s) - (s * l);

                        v1 = 2.0 * l - v2;

                        highp float d = 1.0 / 3.0;
                        highp float r = hueToIntensity(v1, v2, h + d);
                        highp float g = hueToIntensity(v1, v2, h);
                        highp float b = hueToIntensity(v1, v2, h - d);
                        return vec3(r, g, b);
                    }

                    void main() {
                        lowp vec4 c = vec4(1.0);
                        c.rgb = HSLtoRGB(vec3(hue, 1.0 - qt_TexCoord0.t, qt_TexCoord0.s));
                        gl_FragColor = c * qt_Opacity;
                    }
                    "
                }

                MouseArea {
                    id: mapMouseArea
                    anchors.fill: parent
                    onPositionChanged: {
                        if (pressed ) {
                            var xx = Math.max(0, Math.min(mouse.x, parent.width))
                            var yy = Math.max(0, Math.min(mouse.y, parent.height))
                            saturation = 1.0 - yy / parent.height
                            lightness = xx / parent.width
                            // TODO if we constrain the movement here, can avoid the containsMouse test
                            if(mouse.x>0&mouse.x<content.width)
                                crosshairs.x = mouse.x - crosshairs.radius
                            if(mouse.y>0&mouse.y<content.height)
                                crosshairs.y = mouse.y - crosshairs.radius
                        }
                    }
                    onPressed: positionChanged(mouse)
                }

                Image {
                    id: crosshairs
                    property int radius: width / 2 // truncated to int
                    source: "images/crosshairs.png"
                }

                BorderImage {
                    anchors.fill: parent
                    anchors.margins: -1
                    anchors.leftMargin: -2
                    source: "images/sunken_frame.png"
                    border.left: 8
                    border.right: 8
                    border.top: 8
                    border.bottom: 8
                }

            }

            RowLayout{
                height: 24
            }
            Row{
                // anchors.horizontalCenter: content.horizontalCenter
                anchors.left: content.left
                // spacing: 30
                Rectangle{
                    id:recLeft
                    width: content.width/2
                    height: 15
                    border.width: 1
                    //color: Qt.hsla(hueSlider.value, saturation, lightness,1)
                    // anchors.right: content.horizontalCenter
                }
                Rectangle{
                    width:content.width/2
                    height: 15
                    border.width: 1
                    color: Qt.hsla(hueSlider.value, saturation, lightness,1)
                    //anchors.left: content.horizontalCenter

                }
            }

                        RowLayout{
                            height: 24
                        }

            ColorSlider {
                id: hueSlider
                value: 0.5
                // text: qsTr("Оттенок")
                implicitWidth:content.width//width: myWindow.width
                anchors.horizontalCenter: parent.horizontalCenter

                trackDelegate: Rectangle {
                    rotation: -90
                    transformOrigin: Item.TopLeft
                    gradient: Gradient {
                        GradientStop {position: 0.000; color: Qt.rgba(1, 0, 0, 1)}
                        GradientStop {position: 0.167; color: Qt.rgba(1, 1, 0, 1)}
                        GradientStop {position: 0.333; color: Qt.rgba(0, 1, 0, 1)}
                        GradientStop {position: 0.500; color: Qt.rgba(0, 1, 1, 1)}
                        GradientStop {position: 0.667; color: Qt.rgba(0, 0, 1, 1)}
                        GradientStop {position: 0.833; color: Qt.rgba(1, 0, 1, 1)}
                        GradientStop {position: 1.000; color: Qt.rgba(1, 0, 0, 1)}
                    }
                }
            }



            ToolBar {
                id:footerBar
                Layout.fillWidth: true
                RowLayout {
                    anchors.fill: parent
                    ToolButton {
                        id: cancelButton
                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                        text: qsTr("Закрыть")
                        onClicked: {

                        }
                        implicitWidth: myWindow.width/2
                    }
                    ToolButton {
                        id: okButton
                        implicitWidth: myWindow.width/2
                        font.pixelSize: Qt.application.font.pixelSize * 1.6
                        text: qsTr("OK")
                        property color col:Qt.hsla(hueSlider.value, saturation, lightness,1)
                        onClicked: {
                            signalOk(Qt.hsla(hueSlider.value, saturation, lightness,1))
                            root.visible=false
                        }
                    }
                }
            }

        }

    }

    function rgbToHsl(color) {
        var max = Math.max(color.r, color.g, color.b), min = Math.min(color.r, color.g, color.b)
        var h, s, l = (max + min) / 2

        if (max == min) {
            h = s = 0
        } else {
            var d = max - min
            s = l > 0.5 ? d / (2 - max - min) : d / (max + min)
            switch (max) {
            case color.r:
                h = (color.g -color.b) / d + (color.g < color.b ? 6 : 0)
                break
            case color.g:
                h = (color.b - color.r) / d + 2
                break
            case color.b:
                h = (color.r - color.g) / d + 4
                break
            }
            h /= 6;
        }

        var y=(1.0 -s) * content.height
        var x = l * content.width
        return {"h":h, "s":s, "l":l,"x":x,"y":y};
    }

}
