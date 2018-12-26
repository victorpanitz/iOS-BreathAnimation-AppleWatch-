//
//  ViewController.swift
//  teste
//
//  Created by Victor Magalhaes on 26/12/18.
//  Copyright © 2018 iOSCookBookChannel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var layers = [CAShapeLayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        layers = generateLayers(numberOfLayers: 6)
        
        animateLayers()
    }
    
    private func animateLayers() {
        layers.enumerated().forEach { i, layer in
            layer.add(expandedAnimation(factor: i), forKey: nil)
        }
    }
    
    private func generateLayers(numberOfLayers: Int) -> [CAShapeLayer] {
        var array = [CAShapeLayer]()
        for i in 0..<numberOfLayers { array.append(generateLayer(pos: i+1, count: numberOfLayers)) }
        return array
    }
    
    private func generateLayer(pos: Int, count: Int) -> CAShapeLayer {
        let size = view.layer.bounds.size
        let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
        let path = UIBezierPath(ovalIn: rect)
        
        let layer = CAShapeLayer()
        layer.fillColor = generateColor()
        layer.path = path.cgPath
        
        view.layer.addSublayer(layer)
        
        layer.bounds = rect
        layer.position = CGPoint(
            x: size.width/2,
            y: size.height/2
        )
        
        let dCount = Double(count)
        let dPos = Double(pos)
        
        print("POS \(pos)")
        
        let seno = (sin(((360 * dPos)/dCount) * Double.pi / 180) + 1) / 2
        let cosseno = (cos(((360 * dPos)/dCount) * Double.pi / 180) + 1) / 2
        
        print("cos \(seno)")
        print("sen \(cosseno)")
        
        print("anchorPoint \(CGPoint(x: 1 - cosseno, y: seno))")
        
        layer.anchorPoint = CGPoint(x: 1 - cosseno, y: seno)
        
        return layer
    }
    
    private func generateColor() -> CGColor {
        return UIColor(
            red: CGFloat.random(in: 0..<1),
            green: CGFloat.random(in: 0..<1),
            blue: CGFloat.random(in: 0..<1),
            alpha: 0.7
            ).cgColor
    }
    
    private func expandedAnimation(factor: Int) -> CAAnimationGroup {
        let rotationFactor = (2*CGFloat.pi/360) * CGFloat(factor)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = 6/CGFloat.pi - rotationFactor
        rotationAnimation.duration = 3
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 4
        scaleAnimation.duration = 3
        
        let anchorPointAnimation = CABasicAnimation(keyPath: "anchorPoint")
        anchorPointAnimation.toValue = [0.5, 0.5]
        anchorPointAnimation.duration = 3
        
        let animationSet = CAAnimationGroup()
        animationSet.animations = [rotationAnimation, scaleAnimation, anchorPointAnimation]
        animationSet.duration = 3
        animationSet.repeatCount = 1
        animationSet.fillMode = CAMediaTimingFillMode.forwards
        animationSet.isRemovedOnCompletion = false
        animationSet.autoreverses = true
        
        return animationSet
    }
    
}
