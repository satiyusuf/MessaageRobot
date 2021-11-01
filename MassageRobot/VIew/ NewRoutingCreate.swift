//
//   NewRoutingCreate.swift
//  MassageRobot
//
//  Created by Emp-Mac on 30/10/21.
//

import Foundation
import UIKit

class  NewRoutingCreate : UIView {
    
    let kCONTENT_XIB_NAME = "NewRoutingCreate"
    @IBOutlet weak var txtTime: UnderlineTextField!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var lblLeftTool: UnderlineTextField!
    @IBOutlet var ContenView: UIView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
    
    func commonInit() {
        
        let myCustomView: NewRoutingCreate = UIView.fromNib()
        addSubview(myCustomView)
        ContenView.frame = self.bounds
        ContenView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
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

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
