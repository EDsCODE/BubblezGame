import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    let colors: [String] = ["bubblepink2", "bubblegreen2", "bubbleblue2", "bubblebad2"]
    let sigs: [UInt32] = [0b1, 0b10, 0b11, 0b100]
    var blackcount = 0
    var score = 0
    let label = UILabel(frame:CGRectMake(0, 0, 200, 21))
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self

        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        
        backgroundColor = SKColor.whiteColor()
        
        
        label.center = CGPointMake(320, 30)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Score: 0"
        self.view?.addSubview(label)
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addBubble),
                SKAction.waitForDuration(1.5)
                ])
            ))
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    struct PhysicsCategory {
        static let None : UInt32 = 0
        static let All  : UInt32 = UInt32.max
        static let PinkBubble : UInt32 = 0b1
        static let GreenBubble : UInt32 = 0b10
        static let BlueBubble : UInt32 = 0b11
        static let BlackBubble : UInt32 = 0b100
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.locationInNode(self)
        let touchNode = self.nodeAtPoint(touchLocation)
        touchNode.physicsBody!.velocity.dx *= -1
        touchNode.physicsBody!.velocity.dy *= -1
    }
    
    
    func addBubble(){
        let val: Int = Int(random(min:0, max:3))
        
        let bubble = SKSpriteNode(imageNamed: colors[val])
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.size.width/2)
        bubble.physicsBody!.dynamic = true
        bubble.physicsBody!.categoryBitMask = sigs[val]
        bubble.physicsBody!.contactTestBitMask = PhysicsCategory.All
        
        bubble.physicsBody!.friction = 0
        bubble.physicsBody!.restitution = 1
        bubble.physicsBody!.linearDamping = 0
        bubble.physicsBody!.angularDamping = 0
        var actualX = random(min: 0, max: size.width)
        var actualY = random(min: 0, max: size.height)
        let bitmask = nodeAtPoint(bubble.position).physicsBody?.categoryBitMask
        while(bitmask == 0b1 || bitmask == 0b10 || bitmask == 0b11 || bitmask == 0b100){
            actualX = random(min: 0, max: size.width)
            actualY = random(min: 0, max: size.height)

        bubble.position = CGPoint(x: actualX, y: actualY)
        }
        bubble.setScale(0.3)
        addChild(bubble)
        bubble.physicsBody!.applyImpulse(CGVectorMake(random(min: 100, max: 300)*(random() > 0.5 ? 1 : -1), random(min: 100, max: 300) * (random() > 0.5 ? 1 : -1)))
        

        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let abm = contact.bodyA.categoryBitMask
        let bbm = contact.bodyB.categoryBitMask
        if contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask && contact.bodyA.categoryBitMask != PhysicsCategory.None {
            contact.bodyA.node?.removeFromParent();
            contact.bodyB.node?.removeFromParent();
            score++
            label.text = "Score: \(score)"
            //update scoreboard
        }
            
       
            
        else if (abm == 0b1 || abm == 0b10 || abm == 0b11) && (bbm == 0b1 || bbm == 0b10 || bbm == 0b11) {
        
        let m1x = contact.bodyA.velocity.dx
        let m1y = contact.bodyA.velocity.dy
        let m1 = contact.bodyA.mass
        let m2x = contact.bodyB.velocity.dx
        let m2y = contact.bodyB.velocity.dy
        let m2 = contact.bodyB.mass
        
        
        let bubble = SKSpriteNode(imageNamed: "bubblebad2")
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.size.width/2)
        bubble.physicsBody!.dynamic = true
        bubble.physicsBody!.categoryBitMask = PhysicsCategory.BlackBubble
        bubble.physicsBody!.contactTestBitMask = PhysicsCategory.None
        
        bubble.physicsBody!.friction = 0
        bubble.physicsBody!.restitution = 1
        bubble.physicsBody!.linearDamping = 0
        bubble.physicsBody!.angularDamping = 0
        let actualX = contact.bodyA.node?.position.x
        let actualY = contact.bodyA.node?.position.y
        bubble.position = CGPoint(x: actualX!, y: actualY!)
        bubble.setScale(0.6)
        addChild(bubble)
            contact.bodyA.node?.removeFromParent();
            contact.bodyB.node?.removeFromParent();
        bubble.physicsBody!.applyImpulse(CGVectorMake((m1+m2)/2*(m1x+m2x), (m1+m2)/2*(m1y+m2y)))
        blackcount++
            if (blackcount >= 5) {
                label.removeFromSuperview()
                let transition = SKTransition.revealWithDirection(.Down, duration: 1.0)
                let nextScene = EndScene(size: self.size)
                nextScene.scaleMode = SKSceneScaleMode.AspectFill
                nextScene.score(score)
                self.scene?.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        var counter = 60
        
        while counter >= 0 {
            
            
            
            counter--
        }
    }
    
    func onTouch(){
        
    }
    
    
    
    


}