import UIKit

final class BreathLayerGenerator: CALayer {
    
    let center: CGPoint
    
    init(center: CGPoint) {
        self.center = center
        
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    func generateLayers(numberOfLayers: Int) -> [CAShapeLayer] {
        var array = [CAShapeLayer]()
        for i in 0..<numberOfLayers { array.append(generateLayer(pos: i+1, count: numberOfLayers)) }
        return array
    }
    
    private func generateLayer(pos: Int, count: Int) -> CAShapeLayer {
        let rect = CGRect(x: 0, y: 0, width: 25, height: 25)
        let path = UIBezierPath(ovalIn: rect)
        
        let layer = CAShapeLayer()
        layer.fillColor = generateColor(alpha: 0.5)
        layer.path = path.cgPath
        
        layer.bounds = rect
        layer.position = center
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        return layer
    }
    
    private func generateColor(alpha: CGFloat) -> CGColor {
        return UIColor(
            red: CGFloat.random(in: 0.95..<1),
            green: CGFloat.random(in: 0.9..<1),
            blue: CGFloat.random(in: 0.9..<1),
            alpha: alpha
            ).cgColor
    }
    
}
