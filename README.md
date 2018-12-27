# Breath Animation (Smartch Watch App)
A simple approach implementing Breath animation (Apple Watch app).

![alt text](https://media.giphy.com/media/4W1OIQ6hFBUbRtnTac/giphy.gif)

<br>

---

## Flexible

This model is able to receive animation settings as duration, repeat count and autoreverse. Generate your breath animating using <b>`BreathLayerGenerator`</b> choosing the number of circles you want.

<br>

```Swift 
import UIKit

final class BreathViewController: UIViewController {
    
    var generator: BreathLayerGenerator?
    var animator: BreathAnimator?
    lazy var layers = [CAShapeLayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        generator = BreathLayerGenerator(center: view.center)
        animator = BreathAnimator(duration: 4, repeatCount: 3, autoreverse: true)
        
        setupBreath()
    }
    
    private func setupBreath(){
        guard let layers = generator?.generateLayers(numberOfLayers: 6) else { return }
        layers.forEach { view.layer.addSublayer($0) }
        
        animator?.animate(layers: layers)
    }
}
```
