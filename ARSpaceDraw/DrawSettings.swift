//
//  DrawSettings.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/28/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

enum DrawItem:String {
    case line = "line"
    case sphere = "sphere"
    case octahedron = "octahedron"
    
    static let all = [line, sphere, octahedron]
    static var count: Int { return DrawItem.octahedron.hashValue + 1}
}

protocol DrawSettingsDelegate{
    func onDrawItemChange(item:DrawItem)
}

class DrawSettings: NSObject {
    
    static let shared = DrawSettings()
    
    var color:UIColor! = .black
    
    var delegate:DrawSettingsDelegate?
    
    private var _drawItem:DrawItem = .sphere
    var drawItem:DrawItem{
        get{
            return self._drawItem
        }
        set{
            self._drawItem = newValue
            self.delegate?.onDrawItemChange(item:self._drawItem)
        }
    }
    
    var size:Float = 1
    
    static let sphereRadius:CGFloat = 0.05
    static let bounds:Float = 0.1

}
