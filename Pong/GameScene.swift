//
//  GameScene.swift
//  Pong
//
//  Created by Alejandro on 28/05/17.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var score = [Int]()
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
  
    override func didMove(to view: SKView) {
        
     
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
    
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        
        main = self.childNode(withName: "main") as! SKSpriteNode
         main.position.y = (-self.frame.height / 2) + 50
        
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        // Get label node from scene and store it for use later
        
    
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
           startGame()
        
    }
    
    func startGame(){
        let c = arc4random_uniform(3)
        let d = arc4random_uniform(3)
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: (Int(6 + c)), dy: (Int(6 + d))))
        
        
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        let a = arc4random_uniform(3)
        let b = arc4random_uniform(3)

        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWhoWon == main {
            score[0] += 1
            
            ball.physicsBody?.applyImpulse(CGVector(dx: (Int(6 + a)), dy: (Int(6 + b))))
          

            
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))

        }
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                     enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                     main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        switch currentGameType{
        case .easy :
                 enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.85))
            enemy.setScale(0.9)
                 ball.setScale(1.2)
            break
        case .medium:
            
                 enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.55))
                 
                
            break
        case .hard:
            
                 enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
                 enemy.setScale(1.2)
                 main.setScale(0.9)
                 ball.setScale(0.9)
         break
            
        case.player2:
            enemy.setScale(0.75)
            break
            
        }
        

        
        if ball.position.y <= main.position.y - 35 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 35 {
            addScore(playerWhoWon: main)
            
        }
    }
}
