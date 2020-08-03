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
    
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        registerGestureRecognizers()
        
    }
    
    private func registerGestureRecognizers(){
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
        self.sceneView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func pinched(recognizer :UIPinchGestureRecognizer){
        if recognizer.state == .changed {
            guard let sceneView = recognizer.view as? ARSCNView else{
                return
            }
            // selecting which object to scale
            let touch = recognizer.location(in: sceneView)
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            if let hitTest = hitTestResults.first {
                let object = hitTest.node
                let pinchScaleX = Float(recognizer.scale) * object.scale.x
                let pinchScaleY = Float(recognizer.scale) * object.scale.y
                let pinchScaleZ = Float(recognizer.scale) * object.scale.z
                object.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
                recognizer.scale = 1
            }
        }
    }
    
    @objc func panned(recognizer :UIPanGestureRecognizer){
        if recognizer.state == .changed {
            guard let sceneView = recognizer.view as? ARSCNView else{
                return
            }
            // selecting which object to scale
            let touch = recognizer.location(in: sceneView)
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            if let hitTest = hitTestResults.first {
                let object = hitTest.node
                let translation = recognizer.translation(in: view)
                
                let panX = Float(translation.x) + object.position.x
                let panY = Float(translation.y) + object.position.y
                object.position = SCNVector3(panX, panY, -1.0)
//                object.position.x += Float(translation.x)
//                object.position.y += Float(translation.y)
//                sceneView.center.x += translation.x
//                sceneView.center.y += translation.y
                
                recognizer.setTranslation(.zero, in: view)
            }
        }
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
    
    //Gives random number between to numbers
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
    @IBAction func addChair(_ sender: Any) {
        let chairNode = SCNNode()
        
        // Places object in random positions
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.6, secondNum: -1)
        chairNode.position = SCNVector3(x,y,z)
        
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
        
        // Places object in random positions
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.6, secondNum: -1)
        candleNode.position = SCNVector3(x,y,z)
        
        guard let virtualObjectScene = SCNScene(named: "Models.scnassets/candle/candle.scn")
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
        
        // Places object in random positions
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.6, secondNum: -1)
        lampNode.position = SCNVector3(x,y,z)
        
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
        
        // Places object in random positions
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.6, secondNum: -1)
        vaseNode.position = SCNVector3(x,y,z)
        
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
    
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
        
    // Pause session to stop keeping track of position
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    
}

