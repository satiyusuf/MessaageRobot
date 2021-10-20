//
//  FilledColorView.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 16/02/21.
//

import UIKit
import Foundation

class FilledColorView: UIImageView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
            
        let startLocations = [0, 0]
        let endLocations = [0.1, 0.1]

        let layer = CAGradientLayer()
        layer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        layer.frame = bounds
        layer.locations = endLocations as [NSNumber]
        layer.startPoint = CGPoint(x: 0.0, y: 1.0)
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.addSublayer(layer)
//        self.layer.insertSublayer(layer, at: UInt32(self.layer.sublayers!.count))
        
//        let anim = CABasicAnimation(keyPath: "locations")
//        anim.fromValue = startLocations
//        anim.toValue = endLocations
//        anim.duration = 2.0
//        layer.add(anim, forKey: "loc")
//        layer.locations = endLocations as [NSNumber]
    }
    
}
