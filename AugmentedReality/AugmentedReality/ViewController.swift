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
    
    
    @IBAction func addCube(_ sender: Any) {
        var cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        cubeNode.position = SCNVector3(0,0,-0.2) // in meters
        sceneView.scene.rootNode.addChildNode(cubeNode)
    
    }


    @IBAction func addCup(_ sender: Any) {
    }
    
}

