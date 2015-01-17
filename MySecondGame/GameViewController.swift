//
//  GameViewController.swift
//  MySecondGame
//
//  Created by Charles Hsu on 1/17/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Detect the screen size
    let sizeRect = UIScreen.mainScreen().applicationFrame
    let width = sizeRect.size.width * UIScreen.mainScreen().scale
    let height = sizeRect.size.height * UIScreen.mainScreen().scale
    
    // Scene should be shown in fullscreen mode
    let scene = GameScene(size: CGSize(width: width, height: height))
    
    // Configure the view.
    let skView = self.view as SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = true
    
    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = .AspectFill
    
    skView.presentScene(scene)
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  // Limit the supported screen orientation to LandscapeLeft
  override func supportedInterfaceOrientations() -> Int {
    return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
