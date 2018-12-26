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
        
        layers = generateLayers(numberOfLayers: 5)
        animateLayers()
    }
    
    private func animateLayers() {
        layers.enumerated().forEach { i, layer in
            layer.add(expandedAnimation(factor: i), forKey: nil)
        }
    }
    
    private func generateLayers(numberOfLayers: Int) -> [CAShapeLayer] {
        var array = [CAShapeLayer]()
        for _ in 0..<numberOfLayers { array.append(generateLayer()) }
        return array
    }
    
    private func generateLayer() -> CAShapeLayer {
        let size = view.layer.bounds.size
        let rect = CGRect(x: 0, y: 0, width: 25, height: 25)
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
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
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
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = 2*CGFloat.pi - ((2*CGFloat.pi/5) * CGFloat(factor))
        rotationAnimation.duration = 3
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 4
        scaleAnimation.duration = 3
        
        let animationSet = CAAnimationGroup()
        animationSet.animations = [rotationAnimation, scaleAnimation]
        animationSet.duration = 3
        animationSet.repeatCount = 4
        animationSet.fillMode = CAMediaTimingFillMode.forwards
        animationSet.isRemovedOnCompletion = false
        animationSet.autoreverses = true
        
        return animationSet
    }
    
}
