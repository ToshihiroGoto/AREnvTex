//
//  ViewController.swift
//  AREnvTex
//
//  Created by Toshihiro Goto on 2018/06/26.
//  Copyright © 2018年 Toshihiro Goto. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var envTexture1: UIImageView!
    @IBOutlet weak var envTexture2: UIImageView!
    @IBOutlet weak var envTexture3: UIImageView!
    @IBOutlet weak var envTexture4: UIImageView!
    @IBOutlet weak var envTexture5: UIImageView!
    @IBOutlet weak var envTexture6: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/sphere.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.environmentTexturing = .automatic
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for case let envAnchor as AREnvironmentProbeAnchor in anchors {
            let textureSlice1 = envAnchor.environmentTexture?.makeTextureView(pixelFormat: .bgra8Unorm, textureType: .type2D, levels: 0 ..< 1, slices: 0..<1)
            let textureSlice2 = envAnchor.environmentTexture?.makeTextureView(pixelFormat: .bgra8Unorm, textureType: .type2D, levels: 0 ..< 1, slices: 1..<2)
            let textureSlice3 = envAnchor.environmentTexture?.makeTextureView(pixelFormat: .bgra8Unorm, textureType: .type2D, levels: 0 ..< 1, slices: 2..<3)
            let textureSlice4 = envAnchor.environmentTexture?.makeTextureView(pixelFormat: .bgra8Unorm, textureType: .type2D, levels: 0 ..< 1, slices: 3..<4)
            let textureSlice5 = envAnchor.environmentTexture?.makeTextureView(pixelFormat: .bgra8Unorm, textureType: .type2D, levels: 0 ..< 1, slices: 4..<5)
            let textureSlice6 = envAnchor.environmentTexture?.makeTextureView(pixelFormat: .bgra8Unorm, textureType: .type2D, levels: 0 ..< 1, slices: 5..<6)
            
            let ciImage1 = CIImage(mtlTexture: textureSlice1!, options: nil)
            let ciImage2 = CIImage(mtlTexture: textureSlice2!, options: nil)
            let ciImage3 = CIImage(mtlTexture: textureSlice3!, options: nil)
            let ciImage4 = CIImage(mtlTexture: textureSlice4!, options: nil)
            let ciImage5 = CIImage(mtlTexture: textureSlice5!, options: nil)
            let ciImage6 = CIImage(mtlTexture: textureSlice6!, options: nil)
            
            envTexture1.image = UIImage(ciImage: ciImage1!)
            envTexture2.image = UIImage(ciImage: ciImage2!)
            envTexture3.image = UIImage(ciImage: ciImage3!)
            envTexture4.image = UIImage(ciImage: ciImage4!)
            envTexture5.image = UIImage(ciImage: ciImage5!)
            envTexture6.image = UIImage(ciImage: ciImage6!)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

//-----
