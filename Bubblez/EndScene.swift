//
//  EndScene.swift
//  Bubblez
//
//  Created by Me on 11/8/15.
//  Copyright © 2015 Rice. All rights reserved.
//

import Foundation
import SpriteKit


class EndScene: SKScene {
    
    let label = UILabel(frame:CGRectMake(0, 0, 200, 21))
    
    override func didMoveToView(view: SKView) {
        self.view?.backgroundColor = UIColor(patternImage: UIImage(named: "home screen")!)
        let bgImage = SKSpriteNode(imageNamed: "game over")
        bgImage.name = "bg"
        bgImage.size = self.scene!.size
        bgImage.position = CGPointMake(frame.width/2, frame.height/2)
        scene?.addChild(bgImage)
        self.view?.addSubview(label)

    }
    
    func score(score: Int) {
        
        label.center = CGPointMake(320, 30)
        label.textAlignment = NSTextAlignment.Center
        label.text = "\(score)"
      
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
        
        label.removeFromSuperview()
        
        let transition = SKTransition.revealWithDirection(.Down, duration: 1.0)
        let nextScene = MainMenu(size: self.size)
        nextScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene?.view?.presentScene(nextScene, transition: transition)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}