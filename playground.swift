// This is a macOS playground that generates a rotating 3D torus
// be sure to enable the 'assistant editor'
// (interlinked circle icon in the upper right of xcode UI)
// to see the live preview of the rotating torus
// tested in XCode 10.1

import Cocoa
import SceneKit
import PlaygroundSupport
import QuartzCore

var scene = SCNScene()
var layer = SCNLayer()
var device = MTLCreateSystemDefaultDevice()
var renderer = SCNRenderer(device: device)
var view = SCNView(frame: NSRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 640, height: 480)))
view.scene = scene
view.autoenablesDefaultLighting = true

var cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.position = SCNVector3(x: 0, y: 0, z: 3)
scene.rootNode.addChildNode(cameraNode)

// a geometry object
var torus = SCNTorus(ringRadius: 1, pipeRadius: 0.35)
var torusNode = SCNNode(geometry: torus)
torusNode.rotation = SCNVector4(x: 1.0, y: 1.0, z: 0.0, w: 0.0)
// animate the rotation of the torus
var spin = CABasicAnimation(keyPath: "rotation.w") // only animate the angle
spin.toValue = 2.0 * Double.pi
spin.duration = 3
spin.repeatCount = HUGE // for infinity
torusNode.addAnimation(spin, forKey: "spin around")

scene.rootNode.addChildNode(torusNode)

// configure the geometry object
torus.firstMaterial?.diffuse.contents  = NSColor.red
torus.firstMaterial?.specular.contents = NSColor.white

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
