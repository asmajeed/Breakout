//
//  GameScene.swift
//  breakout
//
//  Created by Amer Majeed on 3/9/17.
//  Copyright © 2017 Carter Bischof. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    var ball: SKSpriteNode!
    var paddle: SKSpriteNode!
    var brick: SKSpriteNode!
    
    
    override func didMove(to view: SKView)
    {
        physicsWorld.contactDelegate = self
        
        //Constraint around edge of view so that ball doesn't fall off of the screen
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        createBackground()
        
        makeBall()
        
        makePaddle()
        
        makeBrick()
        
        makeLoseZone()
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5)) //This puts the ball into motion
        
        ball.physicsBody?.isDynamic = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            paddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
       {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            paddle.position.x = location.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if contact.bodyA.node?.name = "brick" || contact.bodyB.node?.name = "brick"
        {
            print("brick hit")
        }
        else if contact.bodyA.node?.name = "LoseZone" || contact.bodyB.node?.name = "LoseZone"
        {
            print("You Lose")
        }
    }
    
    func createBackground()
    {
        
        let stars = SKTexture(imageNamed: "starsBackground")
        
        for i in 0...1
        {
            
            let starsBackground = SKSpriteNode(texture: stars)
            
            starsBackground.zPosition = -1
            
            //Anchor point means when you referance where the background is coming from
            starsBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            starsBackground.position = CGPoint(x: 0, y: (starsBackground.size.height * CGFloat(i) - CGFloat(1*i)))

            addChild(starsBackground)
            
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            
            let moveLoop = SKAction.sequence([moveDown,moveReset])
            
            let moveForever = SKAction.repeatForever(moveLoop)
            
            starsBackground.run(moveForever)
        }
        
    }
    
    
    func makeBall()
    {
        let ballDiameter = frame.width / 20
        
        ball = SKSpriteNode(color: UIColor.green, size: CGSize(width: ballDiameter, height: ballDiameter))
        
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        
        ball.name = "ball"
        
        //This adds a physics frame around the ball.
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        
        ball.physicsBody?.isDynamic = false
        
        //This is used for the square
        ball.physicsBody?.usesPreciseCollisionDetection = true
        
        ball.physicsBody?.friction = 0
        
        ball.physicsBody?.allowsRotation = false
        
        ball.physicsBody?.restitution = 1
        
        ball.physicsBody?.angularDamping = 0
        
        ball.physicsBody?.linearDamping = 0
        
        ball.physicsBody?.affectedByGravity = false
        
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball)
        
        
    }
    
    
    
    func makePaddle()
    {
     
        
        paddle = SKSpriteNode(color: UIColor.green, size: CGSize(width: frame.width/5, height: frame.height/25))
        
        paddle.position = CGPoint(x: frame.midX, y: frame.minY+125)
        
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        
        paddle.physicsBody?.isDynamic = false
        
       addChild(paddle)
        
    }
    
    
    func makeBrick()
    {
        
    brick = SKSpriteNode(color: UIColor.green, size: CGSize(width: frame.width/3, height: frame.height/25))
    
    //Set the location of the brick
    brick.position = CGPoint(x: frame.midX, y: frame.maxY-30)
    
    brick.name = "brick"
        
    brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
    
    brick.physicsBody?.isDynamic = false
    
    addChild(brick)
        
    }
    
    
    func makeLoseZone()
    {
        
        let loseZone = SKSpriteNode(color: UIColor.red, size: CGSize(width: frame.width, height: 50))
        
        //Set the location of the Lose Zone
        loseZone.position = CGPoint(x: frame.midX, y: frame.minY + 25)
        
        loseZone.name = "LoseZone"
        
        loseZone.physicsBody? = SKPhysicsBody(rectangleOf: loseZone.size)
        
        loseZone.physicsBody?.isDynamic = false
        
        addChild(loseZone)
        
    }
    
    
    
}









