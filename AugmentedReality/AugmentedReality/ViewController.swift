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
        //let zCoords = randomFloat(min:-2, max:-0.2)
        
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        //cubeNode.position = SCNVector3(0,0,zCoords) // in meters

        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    
    }


    @IBAction func addCup(_ sender: Any) {
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
    
}

