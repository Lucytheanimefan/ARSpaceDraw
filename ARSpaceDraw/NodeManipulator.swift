//
//  NodeManipulator.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/28/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

//import UIKit
import SceneKit
import SpriteKit

class NodeManipulator: NSObject {

    static func createSphere()->SCNNode{
        let sphere = SCNSphere(radius: DrawSettings.shared.size)
        sphere.setDiffuse(diffuse: DrawSettings.shared.color)
        let node = SCNNode(geometry: sphere)
        return node
    }
    
    static func createLine(path:CGMutablePath, newPoint:CGPoint)->SKShapeNode{
        path.move(to: newPoint)
        let node = SKShapeNode.init(path: path)
        node.strokeColor = DrawSettings.shared.color
        node.lineWidth = 30
        return node
    }
}

extension SCNGeometry{
    func setDiffuse(diffuse:Any){
        self.firstMaterial?.diffuse.contents = diffuse
    }
}
