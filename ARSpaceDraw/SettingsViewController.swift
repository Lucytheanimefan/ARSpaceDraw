//
//  SettingsViewController.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/28/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var colorPicker: ColorPicker!
    @IBOutlet weak var nodePicker: UIPickerView!
    
    @IBOutlet weak var sizeSlider: UISlider!
    
    private var _previewNode:SCNNode! = NodeManipulator.createSphere()
    var previewNode:SCNNode{
        get{
            return self._previewNode
        }
        set{
            self._previewNode.removeFromParentNode()
            self._previewNode = newValue
            sceneView.scene?.rootNode.addChildNode(previewNode)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.debugOptions.insert(.showWireframe)
        
        DrawSettings.shared.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadValues()
        
    }
    
    func loadValues(){
        self.sizeSlider.value = DrawSettings.shared.size
        self.nodePicker.selectRow(DrawSettings.shared.drawItem.hashValue, inComponent: 0, animated: false)
        setNode(item: DrawSettings.shared.drawItem)
        self.previewNode.geometry?.setDiffuse(diffuse: DrawSettings.shared.color)
    }
    
    @IBAction func sizeSlider(_ sender: UISlider) {
        let scale = sender.value
        self.previewNode.scale = SCNVector3Make(scale, scale, scale)
        DrawSettings.shared.size = scale

    }
    
    // MARK: PickerView

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DrawItem.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DrawItem.all[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DrawSettings.shared.drawItem = DrawItem.all[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setNode(item:DrawItem){
        if (item == .line){
            
        }
        else if (item == .octahedron){
            self.previewNode = NodeManipulator.createOctahedron()
        }
        else if (item == .sphere){
            self.previewNode = NodeManipulator.createSphere()
        }
    }

}

extension SettingsViewController: ColorDelegate{
    func pickedColor(color: UIColor) {
        DrawSettings.shared.color = color
        self.previewNode.geometry?.setDiffuse(diffuse: color)
    }
}

extension SettingsViewController: DrawSettingsDelegate{
    func onDrawItemChange(item:DrawItem) {
        setNode(item: item)
    }
}


