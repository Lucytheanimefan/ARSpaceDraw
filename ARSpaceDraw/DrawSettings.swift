//
//  DrawSettings.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/28/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit

enum DrawItem {
    case line, shape
}

class DrawSettings: NSObject {
    
    static let shared = DrawSettings()
    
    var color:UIColor! = .black
    
    var drawItem:DrawItem! = .shape
    
    var size:Float = 1
    
    static let sphereRadius:CGFloat = 0.05

}
