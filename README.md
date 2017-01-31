This is an example code for a [stackoverflow question][0]

While a storyboard file looks like

![storyboard][storyboard]

the app will show the buttons as

![triangle][triangles]

The shape of the button is set by proving a path which will mask the button.

```swift
var shape: UIBezierPath = UIBezierPath() {
    didSet{
        let l = CAShapeLayer()
        l.path = shape.cgPath
        self.layer.mask = l
    }
}
```
The hit testing is done by determining if an event was triggered at a
point that lays in the given shape path, there-for a touch will only be recognize at the visible parts of the button.

```swift
override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    return  shape.cgPath.contains(point)
}

```

[0]: http://stackoverflow.com/questions/41955044/uibutton-shape-according-to-image-frame/41960398#41960398
[triangles]: ./images/triangles.png
[storyboard]: ./images/triangles_storyboard.png
