//
//  ViewController.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/27/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var gestureNode:SCNNode!
    
    var lastPoint = CGPoint.zero
    
    var currentTransform:matrix_float4x4!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions.insert(.showWireframe)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.session.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    
    // MARK: touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches began")
        
        guard let transformCols = touchesToTransform(touches: touches) else {
            print("-No transform columns")
            return
        }
        // Keep track of where the user started (aka when finger hits the "canvas")
        //let lastPoint = touch.location(in: self.view)
        //print(lastPoint)
        let node = createSphere()
        node.position = SCNVector3.init(transformCols.3.x, transformCols.3.y, transformCols.3.z)
        //print(node.position)
        self.gestureNode = node
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches moved")
        
        guard let transformCols = touchesToTransform(touches: touches), self.gestureNode != nil else {
            return
        }

//        print(currentPoint)
        let newPosition = SCNVector3.init(transformCols.3.x, transformCols.3.y, transformCols.3.z)
        let action = SCNAction.move(to: newPosition, duration: 0.5)
        self.gestureNode.runAction(action)

        
    }
    
    func touchesToTransform(touches:Set<UITouch>) -> (simd_float4, simd_float4, simd_float4, simd_float4)?{
        guard let touch = touches.first else{
            print("No touches or no gesture node")
            return nil
            
        }
        
        let hitResults = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        
        guard let hitResult = hitResults.first else {
            print("No hit results")
            return nil
        }
        
        print("Touches moved")
        
        return hitResult.worldTransform.columns
    }
    
    func createSphere()->SCNNode{
        let sphere = SCNSphere(radius: 0.05)
        sphere.setDiffuse(diffuse: UIColor(red: 0, green: 0, blue: 0, alpha: 1))
        let node = SCNNode(geometry: sphere)
        return node
    }


    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
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

extension ViewController: ARSessionDelegate{
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        self.currentTransform = frame.camera.transform
    }
}

extension SCNGeometry{
    func setDiffuse(diffuse:Any){
        self.firstMaterial?.diffuse.contents = diffuse
    }
}
