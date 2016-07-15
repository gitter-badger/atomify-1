import QtQuick 2.5
import QtQuick.Controls 1.4
import SimVis 1.0
import Atomify 1.0

Item {
    id: atomifyVisualizerRoot
    property Visualizer visualizer: visualizer
    property AtomifySimulator simulator
    property real scale: 0.23
    property Light light: light
    // property Slice slice: mySlice
    property Slice slice
    property Camera camera: camera
    property bool addPeriodicCopies: false

    function animateCameraTo(position, upVector, viewCenter, duration) {
        console.log("Starting animation ? ")
        animateCamera.duration = 1000
        animateCameraPosition.from = camera.position
        animateCameraPosition.to = position
        animateCameraUpVector.from = camera.upVector
        animateCameraUpVector.to = upVector
        animateCameraViewCenter.from = camera.viewCenter
        animateCameraViewCenter.to = viewCenter
        animateCamera.running = true
        console.log("Yep, starting animation")
    }

    Visualizer {
        id: visualizer
        property Spheres spheres: spheres
        width: parent.width
        height: parent.height
        simulator: atomifyVisualizerRoot.simulator
        camera: camera
        backgroundColor: "#111"
        navigator: navigator
        onTouched: {
            atomifyVisualizerRoot.focus = true
        }

//        SkyBox {
//            id: skybox
//            camera: camera
//            texture: ":/1024.png"
//        }

        TrackballNavigator {
            id: navigator
            anchors.fill: parent
            camera: camera
        }
//        FlyModeNavigator {
//            id: navigator
//            anchors.fill: parent
//            camera: camera
//        }

        Spheres {
            id: spheres
            // scale: atomifyVisualizerRoot.scale
            color: "white"
            visible: parent.visible

            Light {
                id: light1
                ambientColor: spheres.color
                specularColor: "white"
                diffuseColor: spheres.color
                ambientIntensity: 0.05
                diffuseIntensity: 1.0
                specularIntensity: 2.0
                specular: true
                shininess: 30.0
                attenuation: 0.0
                position: camera.position
            }
        }

        Bonds {
            id: bonds
            color: "white"
            visible: parent.visible

            Light {
                id: light
                ambientColor: bonds.color
                specularColor: "white"
                diffuseColor: bonds.color
                ambientIntensity: 0.05
                diffuseIntensity: 1.0
                specularIntensity: 2.0
                specular: true
                shininess: 30.0
                attenuation: 0.0
                position: camera.position
            }
        }
    }

    Camera {
        id: camera
        nearPlane: 0.1
        farPlane: 100000
        position: Qt.vector3d(0,0,5)
//        onPositionChanged: {
//            console.log("Pos: "+ position + "    up: "+ upVector + "    viewCenter: " + viewCenter)
//        }
    }

    ParallelAnimation {
        id: animateCamera
        property int duration: 1000

        Vector3dAnimation {
            id: animateCameraPosition
            target: camera
            property: "position"
            duration: animateCamera.duration
            easing.type: Easing.InOutQuad
        }
        Vector3dAnimation {
            id: animateCameraUpVector
            target: camera
            property: "upVector"
            duration: animateCamera.duration
            easing.type: Easing.InOutQuad
        }
        Vector3dAnimation {
            id: animateCameraViewCenter
            target: camera
            property: "viewCenter"
            duration: animateCamera.duration
            easing.type: Easing.InOutQuad
        }
    }
}
