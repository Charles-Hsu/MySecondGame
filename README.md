# MySecondGame
Refernece [How to implement a space shooter with SpriteKit and SWIFT](http://stefansdevplayground.blogspot.de/2014/11/how-to-implement-space-shooter-with.html)

```swift
// Detect the screen size
let sizeRect = UIScreen.mainScreen().applicationFrame
let width = sizeRect.size.width * UIScreen.mainScreen().scale
let height = sizeRect.size.height * UIScreen.mainScreen().scale

// Scene should be shown in fullscreen mode
let scene = GameScene(size: CGSize(width: width, height: height))
```

```swift
// Limit the supported screen orientation to LandscapeLeft
override func supportedInterfaceOrientations() -> Int {
  return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
}
```

How ever, you alos need to change the Device Orientation of Deployment Info in the General Tab of the TARGETS, and modified the Info.plist to remove the items of the Supported interface orientations(iPad).

So far so good, 

degree to radians

[](http://www.teacherschoice.com.au/Maths_Library/Angles/Angles14.gif)

radians to degree

[](http://www.teacherschoice.com.au/Maths_Library/Angles/Angles15.gif)