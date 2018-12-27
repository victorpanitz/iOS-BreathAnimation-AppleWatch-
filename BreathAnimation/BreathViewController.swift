//
//  ViewController.swift
//  teste
//
//  Created by Victor Magalhaes on 26/12/18.
//  Copyright © 2018 iOSCookBookChannel. All rights reserved.
//

import UIKit

class BreathViewController: UIViewController {
    
    var generator: BreathLayerGenerator?
    var animator: BreathAnimator?
    
    lazy var layers = [CAShapeLayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        generator = BreathLayerGenerator(center: view.center)
        animator = BreathAnimator(duration: 2, repeatCount: 3, autoreverse: true)
        
        setupBreath()
    }
    
    private func setupBreath(){
        guard let layers = generator?.generateLayers(numberOfLayers: 6) else { return }
        layers.forEach { view.layer.addSublayer($0) }
        
        animator?.animate(layers: layers)
    }
}
