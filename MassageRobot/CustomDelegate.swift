//
//  CustomDelegate.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 04/02/21.
//

import UIKit
import Foundation

protocol AllTouchDelegate {
    
    func touchFound()
}

protocol SliderValueSetDelegate {
    func sliderValueSet(value: Float, strAction: String, index: Int)
}

protocol RulerSizeDelegate {
    func  rulerSize(size: Int, index: Int)
}

protocol LocationDelegate {
    func locationViewAnimation(strLRLocation: String, strBodyPart: String, currentIndex: Int)
}

protocol isChangeDataDelegate {
    func setChangeSegmentData()
}

protocol isSegmentDataCopy {
    func setSegmentDataCopy(isLink: Bool, iscopy: Bool)
}


