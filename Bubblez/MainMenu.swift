//
//  MainMenu.swift
//  Bubblez
//
//  Created by Me on 11/8/15.
//  Copyright © 2015 Rice. All rights reserved.
//

import Foundation
import SpriteKit


class MainMenu: SKScene {
    
    override func didMoveToView(view: SKView) {
        self.view?.backgroundColor = UIColor(patternImage: UIImage(named: "home screen")!)
        let bgImage = SKSpriteNode(imageNamed: "home screen")
        bgImage.name = "bg"
        bgImage.size = self.scene!.size
        bgImage.position = CGPointMake(frame.width/2, frame.height/2)
        scene?.addChild(bgImage)
        

    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
        
        
        
            let transition = SKTransition.revealWithDirection(.Down, duration: 1.0)
        let nextScene = GameScene(size: self.size)
            nextScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene?.view?.presentScene(nextScene, transition: transition)
        
    
    }
    
    
    
    
    
    
    
    
    
    
    
}