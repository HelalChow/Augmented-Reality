//
//  ViewController.swift
//  AugmentedReality
//
//  Created by Helal Chowdhury on 8/27/19.
//  Copyright © 2019 Helal Chowdhury. All rights reserved.
//

import UIKit
import ARKit
import SceneKit


class ViewController: UIViewController {

    
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        
        
    }
    
    func randomFloat(min: Float, max: Float) -> Float{
        return (Float(arc4random()) / 0xFFFFFFFF) * (max-min) + min
    }
    
    @IBAction func addCube(_ sender: Any) {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))

        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    
    }
    
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
        
    }
    
    
    @IBAction func addChair(_ sender: Any) {
        let chairNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        chairNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        guard let virtualObjectScene = SCNScene(named: "chair.scn", inDirectory: "Models.scnassets/chair")
            else{
                return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        chairNode.addChildNode(wrapperNode)
        
        sceneView.scene.rootNode.addChildNode(chairNode)
    }
    
    
    
    
    @IBAction func addCandle(_ sender: Any) {
        let candleNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        candleNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        guard let virtualObjectScene = SCNScene(named: "candle.scn", inDirectory: "Models.scnassets/candle")
            else{
                return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        candleNode.addChildNode(wrapperNode)
        
        sceneView.scene.rootNode.addChildNode(candleNode)
    }
    
    
    @IBAction func addLamp(_ sender: Any) {
        let lampNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        lampNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        guard let virtualObjectScene = SCNScene(named: "lamp.scn", inDirectory: "Models.scnassets/lamp")
            else{
                return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        lampNode.addChildNode(wrapperNode)
        
        sceneView.scene.rootNode.addChildNode(lampNode)
    }
    

    
    @IBAction func addVase(_ sender: Any) {
        let vaseNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        vaseNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        guard let virtualObjectScene = SCNScene(named: "vase.scn", inDirectory: "Models.scnassets/vase")
            else{
                return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        vaseNode.addChildNode(wrapperNode)
        
        sceneView.scene.rootNode.addChildNode(vaseNode)
    }
    
    
}

