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
    
    static var octahedronIndices: [Int] = [
        0, 1, 2,
        2, 3, 0,
        3, 4, 0,
        4, 1, 0,
        1, 5, 2,
        2, 5, 3,
        3, 5, 4,
        4, 5, 1
    ]
    
    static var octahedronVertices: [SCNVector3] = [
        SCNVector3(0, 1, 0),
        SCNVector3(-0.5, 0, 0.5),
        SCNVector3(0.5, 0, 0.5),
        SCNVector3(0.5, 0, -0.5),
        SCNVector3(-0.5, 0, -0.5),
        SCNVector3(0, -1, 0),
    ]
    
    
    static func createOctahedron()->SCNNode{
        let source = SCNGeometrySource(vertices: NodeManipulator.octahedronVertices)
        let element = SCNGeometryElement(indices: NodeManipulator.octahedronIndices, primitiveType: .triangles)
        let geometry = SCNGeometry(sources: [source], elements: [element])
        let node = SCNNode(geometry: geometry)
        //node.scale = SCNVector3Make(Float(DrawSettings.shared.size), Float(DrawSettings.shared.size), Float(DrawSettings.shared.size))
        return node
    }

    static func createSphere()->SCNNode{
        let sphere = SCNSphere(radius: DrawSettings.sphereRadius)
        sphere.setDiffuse(diffuse: DrawSettings.shared.color)
        let node = SCNNode(geometry: sphere)
        //node.scale = SCNVector3Make(Float(DrawSettings.shared.size), Float(DrawSettings.shared.size), Float(DrawSettings.shared.size))
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
