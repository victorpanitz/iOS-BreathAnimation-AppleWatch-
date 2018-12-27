import UIKit

final class BreathAnimator {
    
    let duration: Double
    let repeatCount: Float
    let autoreverse: Bool
    
    init(duration: Double, repeatCount: Float, autoreverse: Bool) {
        self.duration = duration
        self.repeatCount = repeatCount
        self.autoreverse = autoreverse
    }
    
    func animate(layers: [CALayer]) {
        layers.enumerated().forEach { i, layer in
            layer.add(generateAnimationSet(factor: i, count: layers.count), forKey: nil)
        }
    }
    
    private func generateAnimationSet(factor: Int, count: Int) -> CAAnimationGroup {
        let rotationFactor = (2*CGFloat.pi/360) * CGFloat(factor)
        let axis = generateAnchorPoint(spherePos: Double(factor), count: Double(count))
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(count)/CGFloat.pi - rotationFactor
        rotationAnimation.duration = duration
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 4
        scaleAnimation.duration = duration
        
        let anchorPointAnimation = CABasicAnimation(keyPath: "anchorPoint")
        anchorPointAnimation.toValue = [axis.x, axis.y]
        anchorPointAnimation.duration = duration
        
        let animationSet = CAAnimationGroup()
        animationSet.animations = [rotationAnimation, scaleAnimation, anchorPointAnimation]
        animationSet.duration = duration
        animationSet.repeatCount = repeatCount
        animationSet.fillMode = CAMediaTimingFillMode.forwards
        animationSet.isRemovedOnCompletion = false
        animationSet.autoreverses = autoreverse
        
        return animationSet
    }
    
    private func generateAnchorPoint(spherePos: Double, count: Double) -> (x: Double, y: Double) {
        let sen = (sin(((360 * spherePos)/count) * Double.pi / 180) + 1) / 2
        let coss = (cos(((360 * spherePos)/count) * Double.pi / 180) + 1) / 2
        return (x: coss, y: sen)
    }
}
