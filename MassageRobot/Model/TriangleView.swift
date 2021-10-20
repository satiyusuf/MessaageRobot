//
//  TriangleView.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 18/02/21.
//

import UIKit

class TriangleView: UIView {

    var fillValue: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 200))
        //    let context = UIGraphicsGetCurrentContext()!
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 33))
        context.addLine(to: CGPoint(x: frame.width, y: 0))
        context.addLine(to: CGPoint(x: frame.width, y: 33))
        context.closePath()
        let path = context.path!
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
        context.addPath(path)
        context.clip()
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 50, height: 15))
        context.setFillColor(#colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1))
        context.fill(CGRect(x: 0, y: 0, width: frame.width * fillValue, height: 50))
        _ = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func setFillValue(value: CGFloat)
    {
        fillValue = value
    }
}

