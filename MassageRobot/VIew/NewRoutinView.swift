//
//  NewRoutinView.swift
//  MassageRobot
//
//  Created by Emp-Mac on 01/11/21.
//

import UIKit

class NewRoutinView: UIView {

    let kCONTENT_XIB_NAME = "NewRoutine"
    @IBOutlet var ContenView: UIView!
    @IBOutlet weak var lblSegmentCount: UILabel!
    @IBOutlet weak var txtTimePicker: UnderlineTextField!
    @IBOutlet weak var txtLeftToolPicker: UnderlineTextField!
    @IBOutlet weak var txtRightToolPicker: UnderlineTextField!
    @IBOutlet weak var btnLeftLocation: UIButton!
    @IBOutlet weak var btnRightLocation: UIButton!
    @IBOutlet weak var txtLeftPath: UnderlineTextField!
    @IBOutlet weak var txtRightPath: UnderlineTextField!
    @IBOutlet weak var btnLeftspeed: UIButton!
    @IBOutlet weak var lblLeftSpeedText: UILabel!
    @IBOutlet weak var LeftSpeedTree: UIView!
    @IBOutlet weak var btnRightSpeed: UIButton!
    @IBOutlet weak var lblRightSpeedText: UILabel!
    @IBOutlet weak var RightSpeedTree: UIView!
    @IBOutlet weak var btnLeftForce: UIButton!
    @IBOutlet weak var lblLeftForceText: UILabel!
    @IBOutlet weak var LeftForceTree: UIView!
    @IBOutlet weak var btnRightForce: UIButton!
    @IBOutlet weak var lblRightForceText: UILabel!
    @IBOutlet weak var RightForceTree: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        ContenView.fixInView(self)
    }
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
