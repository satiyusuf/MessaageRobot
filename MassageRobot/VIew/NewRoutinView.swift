//
//  NewRoutinView.swift
//  MassageRobot
//
//  Created by Emp-Mac on 01/11/21.
//

import UIKit
import Foundation

class NewRoutinView: UIView {

    class func instanceFromNib() -> NewRoutinView {
        let view = UINib(nibName: "NewRoutine", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NewRoutinView
        return view
    }
    
    //MARK:- Outlet
    let kCONTENT_XIB_NAME = "NewRoutine"
    @IBOutlet var ContenView: UIView!
    @IBOutlet weak var txtTime: UnderlineTextField!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var txtLeftTool: UnderlineTextField!
    @IBOutlet weak var txtRightTool: UnderlineTextField!
    @IBOutlet weak var btnLeftLocation: UIButton!
    @IBOutlet weak var btnRightLocation: UIButton!
    @IBOutlet weak var txtLeftPath: UnderlineTextField!
    @IBOutlet weak var txtRIghtPath: UnderlineTextField!
    @IBOutlet weak var btnRIghtSpeed: UIButton!
    @IBOutlet weak var lblRightSpeed: UILabel!
    @IBOutlet weak var RightSpeedTree: UIView!
    @IBOutlet weak var btnLeftSpeed: UIButton!
    @IBOutlet weak var lblLeftSpeedText: UILabel!
    @IBOutlet weak var LeftSpeedTree: UIView!
    @IBOutlet weak var btnRightForce: UIButton!
    @IBOutlet weak var lblRightForce: UILabel!
    @IBOutlet weak var RightForceTree: UIView!
    @IBOutlet weak var btnLeftForce: UIButton!
    @IBOutlet weak var lblLeftForce: UILabel!
    @IBOutlet weak var LeftForceTree: UIView!
    
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


////MARK:- PickerView Method
//extension NewRoutinView: UIPickerViewDelegate, UIPickerViewDataSource
//{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        if self.Time.isEditing {
//            return 60
//        }else if self.LeftTool.isEditing {
//            return arrTool.count
//        }else if self.RightTool.isEditing {
//            return arrTool.count
//        }else if self.LeftPath.isEditing {
//            return arrPath.count
//        }else if self.RightPath.isEditing {
//            return arrPath.count
//        }else {
//            return 0
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        if self.Time.isEditing {
//            return "\(row + 1)"
//        }else if self.LeftTool.isEditing {
//            return arrTool[row]
//        }else if self.RightTool.isEditing {
//            return arrTool[row]
//        }else if self.LeftPath.isEditing {
//            return arrPath[row]
//        }else if self.RightPath.isEditing {
//            return arrPath[row]
//        }else {
//            return ""
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        if self.isLinkData == true {
//
//            if self.Time.isEditing {
//                self.Time.text = "\(row + 1)"
//            }else if self.LeftTool.isEditing {
//                self.LeftTool.text = arrTool[row]
//            }else if self.RightTool.isEditing {
//                self.RightTool.text = arrTool[row]
//            }else if self.LeftPath.isEditing {
//                self.LeftPath.text = arrPath[row]
//            }else if self.RightPath.isEditing {
//                self.RightPath.text = arrPath[row]
//            }
//        } else {
//
//            if self.Time.isEditing {
//                self.Time.text = "\(row + 1)"
//            }else if self.LeftTool.isEditing {
//                self.LeftTool.text = arrTool[row]
//                self.RightTool.text = arrTool[row]
//            }else if self.RightTool.isEditing {
//                self.LeftTool.text = arrTool[row]
//                self.RightTool.text = arrTool[row]
//            }else if self.LeftPath.isEditing {
//                self.LeftPath.text = arrPath[row]
//                self.RightPath.text = arrPath[row]
//            }else if self.RightPath.isEditing {
//                self.LeftPath.text = arrPath[row]
//                self.RightPath.text = arrPath[row]
//            }
//        }
//    }
//}
//
//MARK:- UITextFieldDelegate Method
//extension NewRoutinView: UITextFieldDelegate
//{
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if textField == self.txtTime || textField == self.txtLeftTool || textField == self.txtRightTool || textField == self.txtLeftPath || textField == self.txtRightPath  {
//            picker.reloadAllComponents()
//        }
//    }
//}
