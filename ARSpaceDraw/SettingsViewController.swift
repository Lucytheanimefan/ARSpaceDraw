//
//  SettingsViewController.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/28/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SceneKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var colorPicker: ColorPicker!
    
    @IBOutlet weak var colorView: UIView!
    
    var previewNode:SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.debugOptions.insert(.showWireframe)
        
        // Gestures
        addGestureRecognizer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.previewNode = NodeManipulator.createSphere()
        sceneView.scene?.rootNode.addChildNode(previewNode)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Gestures
    
    func addGestureRecognizer(){
        let zoomGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(gesture:)))
        self.view.addGestureRecognizer(zoomGesture)
    }
    
    @objc func handlePinchGesture(gesture:UIPinchGestureRecognizer){
        guard let sphere = self.previewNode.geometry as? SCNSphere else {return}
        
        let action = SCNAction.scale(by: gesture.scale.squareRoot(), duration: 0.5)
        self.previewNode.runAction(action) {
            DrawSettings.shared.size = sphere.radius
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: ColorDelegate{
    func pickedColor(color: UIColor) {
        DrawSettings.shared.color = color
        colorView.backgroundColor = color
        //colorPicker.backgroundColor = color
    }
}
