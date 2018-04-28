//
//  NodeManipulator.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/28/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

//import UIKit
import SceneKit

class NodeManipulator: NSObject {

    static func createSphere()->SCNNode{
        let sphere = SCNSphere(radius: 0.05)
        sphere.setDiffuse(diffuse: UIColor(red: 0, green: 0, blue: 0, alpha: 1))
        let node = SCNNode(geometry: sphere)
        return node
    }
}
