//
//  ScoreNode.swift
//  ARSpaceDraw
//
//  Created by Lucy Zhang on 4/29/18.
//  Copyright © 2018 Lucy Zhang. All rights reserved.
//

import UIKit
import SpriteKit

class ScoreNode: SKNode {
    private let scoreKey = "ARSPACEDRAW_HIGHSCORE"
    private let scoreNode = SKLabelNode(fontNamed: "PixelDigivolve")
    private(set) var score : Float = 0
    private var highScore : Float = 0
    private var showingHighScore = false
    
    /// Set up HUD here.
    public func setup(size: CGSize) {
        let defaults = UserDefaults.standard
        
        highScore = defaults.float(forKey: scoreKey)
        
        scoreNode.text = "Score: \(score)"
        scoreNode.fontSize = 40
        scoreNode.position = CGPoint(x: size.width / 2, y: size.height - 60)
        scoreNode.zPosition = 1
        
        addChild(scoreNode)
    }
    
    /// Add point.
    /// - Increments the score.
    /// - Saves to user defaults.
    /// - If a high score is achieved, then enlarge the scoreNode and update the color.
    @objc public func addPoint() {
        print("Add point: \(score)")
        score += 1
        
        updateScoreboard()
        
        if score > highScore {
            
            let defaults = UserDefaults.standard
            
            defaults.set(score, forKey: scoreKey)
            
            if !showingHighScore {
                showingHighScore = true
                
                scoreNode.run(SKAction.scale(to: 1.5, duration: 0.25))
                scoreNode.fontColor = SKColor(red:0.99, green:0.92, blue:0.55, alpha:1.0)
            }
        }
    }
    
    @objc public func addPoints(points:Float) {
        print("Add point: \(score)")
        score += points
        
        updateScoreboard()
        
//        if score > highScore {
//
//            let defaults = UserDefaults.standard
//
//            defaults.set(score, forKey: scoreKey)
//
//            if !showingHighScore {
//                showingHighScore = true
        
                scoreNode.run(SKAction.scale(to: 1.5, duration: 0.25))
                scoreNode.fontColor = SKColor(red:0.99, green:0.92, blue:0.55, alpha:1.0)
            //}
        //}
    }
    
    /// Reset points.
    /// - Sets score to zero.
    /// - Updates score label.
    /// - Resets color and size to default values.
    public func resetPoints() {
        score = 0
        
        updateScoreboard()
        
        if showingHighScore {
            showingHighScore = false
            
            scoreNode.run(SKAction.scale(to: 1.0, duration: 0.25))
            scoreNode.fontColor = SKColor.white
        }
    }
    
    /// Updates the score label to show the current score.
    private func updateScoreboard() {
        scoreNode.text = "Score: \(score)"
    }
}
