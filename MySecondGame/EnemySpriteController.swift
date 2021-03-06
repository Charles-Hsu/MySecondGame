//
//  EnemySpriteController.swift
//  MySecondGame
//
//  Created by Charles Hsu on 1/17/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import SpriteKit

// Controller class for
// - creating / destroying enemies
// - shooting
// - animations

class EnemySpriteController {
  var enemySprites: [SKSpriteNode] = []
  
  func spawnEnemy(targetSprite: SKNode) -> SKSpriteNode {
    
    let newEnemy = SKSpriteNode(imageNamed: "Spaceship")
    enemySprites.append(newEnemy)
    
    newEnemy.xScale = 0.08
    newEnemy.yScale = 0.08
    newEnemy.color = UIColor.redColor()
    newEnemy.colorBlendFactor = 0.4
    
    // position new sprite at a random position on the screen
    let sizeRect = UIScreen.mainScreen().applicationFrame
    let posX = arc4random_uniform(UInt32(sizeRect.size.width))
    let posY = arc4random_uniform(UInt32(sizeRect.size.height))
    newEnemy.position = CGPointMake(CGFloat(posX), CGFloat(posY))
    
    // Define constrains for orientation/targeting behavior
    let i = enemySprites.count - 1
    let rangeForOrienation = SKRange(constantValue: CGFloat(M_2_PI*7))
    let orientConstraint = SKConstraint.orientToNode(targetSprite,
      offset: rangeForOrienation)
    let rangeToSprite = SKRange(lowerLimit: 80, upperLimit: 90)
    var distanceConstraint: SKConstraint
    
    // First enemy has to follow spriteToFollow, 
    // second enemy has to follow enemy ...
    
    if enemySprites.count - 1 == 0 {
      distanceConstraint = SKConstraint.distance(rangeToSprite,
        toNode: targetSprite)
    } else {
      distanceConstraint = SKConstraint.distance(rangeToSprite,
        toNode: enemySprites[i-1])
    }
    newEnemy.constraints = [orientConstraint, distanceConstraint]
    
    return newEnemy
  }
  
  // Shoot in direction of spriteToShoot
  func shoot(targetSprite: SKNode) {
    for enemy in enemySprites {
      
      // Create the bullet sprite
      let bullet = SKSpriteNode()
      bullet.color = UIColor.greenColor()
      bullet.size = CGSize(width: 5, height: 5)
      bullet.position = CGPointMake(enemy.position.x, enemy.position.y)
      targetSprite.parent?.addChild(bullet)
      
      // Determine vector to targetSprite
      let vector = CGVectorMake(
        targetSprite.position.x - enemy.position.x,
        targetSprite.position.y - enemy.position.y)
      
      // Create the action to move the bullet. Don't forget to remove the bullet.
      let bulletAction = SKAction.sequence([
        SKAction.repeatAction(SKAction.moveBy(vector, duration: 1), count: 10),
        SKAction.waitForDuration(30.0/60.0),
        SKAction.removeFromParent()
        ])
      bullet.runAction(bulletAction)
    }
  }
  
}

