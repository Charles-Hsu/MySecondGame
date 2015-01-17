//
//  GameScene.swift
//  MySecondGame
//
//  Created by Charles Hsu on 1/17/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

  let heroSprite = SKSpriteNode(imageNamed: "Spaceship")
  let invisibleControllerSprite = SKSpriteNode()
  
  var enemySprites = EnemySpriteController()
  
  var lastShootTime: CFTimeInterval = 1

  override func didMoveToView(view: SKView) {
    
    /* Setup your scene here */
    heroSprite.xScale = 0.15
    heroSprite.yScale = 0.15
    heroSprite.position = CGPoint(x: frame.width/2, y: frame.height/2)
    addChild(heroSprite)
    
    // Define invisible sprite for rotating and steering behavior without trigonometry
    invisibleControllerSprite.size = CGSizeMake(0, 0)
    addChild(invisibleControllerSprite)
    
    // Define a constraint for the orientation behavior
    let rangeForOrientation = SKRange(constantValue: CGFloat(M_2_PI * 7))
    // But, why ???
    
    // M_2_PI == 2 / π == 0.636619772367581
    
    heroSprite.constraints = [SKConstraint.orientToNode(
      invisibleControllerSprite, offset: rangeForOrientation)]
    
    // Add enemy sprites
    for var i=0; i<3; i++ {
      addChild(enemySprites.spawnEnemy(heroSprite))
    }
    
    
    
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    /* Called when a touch begins */
    
    for touch: AnyObject in touches {
      
      // Determine the new position for the invisible sprite:
      // The calculation is needed to ensure the position of both sprites
      // are nearly the same, but different. Otherwise, the hero sprite rotates
      // back to it's original orientation after reaching the location of 
      // the invisible sprite.
      
      var xOffset: CGFloat = 1.0
      var yOffset: CGFloat = 1.0
      
      var location = touch.locationInNode(self)
      
      if location.x > heroSprite.position.x {
        xOffset = -1.0
      }
      
      if location.y > heroSprite.position.y {
        yOffset = -1.0
      }
      
      // Create an action to move the invisibleControllerSprite.
      // This will cause automatic orientation changes for the hero sprite
      
      let actionMoveInvisibleNode = SKAction.moveTo(
        CGPointMake(location.x - xOffset, location.y - yOffset),
        duration: 0.2)
      
      invisibleControllerSprite.runAction(actionMoveInvisibleNode)
      
      // Create an action to move the hero sprite to the touch location
      
      let actionMove = SKAction.moveTo(location, duration: 1)
      heroSprite.runAction(actionMove)
      
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    
    if currentTime - lastShootTime >= 1 {
      enemySprites.shoot(heroSprite)
      lastShootTime = currentTime
    }
    
    
    
  }
}
