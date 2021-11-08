//
//  SegmentCreate.swift
//  MassageRobot
//
//  Created by Emp-Mac on 08/11/21.
//

import UIKit

class SegmentCreate: UICollectionViewCell {

    @IBOutlet weak var SegmentCount: UILabel!
    @IBOutlet weak var txtTime: UnderlineTextField!
    @IBOutlet weak var txtLeftTool: UnderlineTextField!
    @IBOutlet weak var txtRightTool: UnderlineTextField!
    @IBOutlet weak var btnLeftLocation: UIButton!
    @IBOutlet weak var btnRightLocation: UIButton!
    @IBOutlet weak var txtLeftPath: UnderlineTextField!
    @IBOutlet weak var txtRightPath: UnderlineTextField!
    @IBOutlet weak var LeftSpeedTree: UIView!
    @IBOutlet weak var LeftSpeedText: UILabel!
    @IBOutlet weak var btnLeftSpeed: UIButton!
    @IBOutlet weak var RightSpeedTree: UIView!
    @IBOutlet weak var RightSpeedText: UILabel!
    @IBOutlet weak var btnRightSpeed: UIButton!
    @IBOutlet weak var LeftForceTree: UIView!
    @IBOutlet weak var LeftForceText: UILabel!
    @IBOutlet weak var btnLeftForce: UIButton!
    @IBOutlet weak var RightForceTree: UIView!
    @IBOutlet weak var RightForceText: UILabel!
    @IBOutlet weak var btnRightForce: UIButton!
    
    let picker = UIPickerView()
    let arrPath = ["none", "Linear", "Circular", "Random", "Point"]
    let arrTool = ["none", "Omni", "Inline", "Point", "Kneading","Sport","Precussion","Calibration"]   
    var IsLink:Bool = false
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        txtTime.inputView = picker
        txtLeftTool.inputView = picker
        txtRightTool.inputView = picker
        txtLeftPath.inputView = picker
        txtRightPath.inputView = picker
        
        picker.delegate = self
        picker.dataSource = self
        
        txtTime.delegate = self
        txtLeftTool.delegate = self
        txtRightTool.delegate = self
        txtLeftPath.delegate = self
        txtRightPath.delegate = self
        
        
        let triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
        triLeftSpeed.backgroundColor = .white
        triLeftSpeed.setFillValue(value: 0)
        LeftSpeedTree.addSubview(triLeftSpeed)
        
        let triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
        triRightSpeed.backgroundColor = .white
        triRightSpeed.setFillValue(value: 0)
        RightSpeedTree.addSubview(triRightSpeed)
        
        let triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
        triLeftForce.backgroundColor = .white
        triLeftForce.setFillValue(value: 0)
        LeftForceTree.addSubview(triLeftForce)
        
        let triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
        triRightForce.backgroundColor = .white
        triRightForce.setFillValue(value: 0)
        RightForceTree.addSubview(triRightForce)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        let Data = notification.userInfo! as NSDictionary
        let IsLink = Data["Islink"] as? String ?? ""
        print(IsLink)
        if IsLink == "true" {
            self.IsLink = true
        } else {
            self.IsLink = false
        }
    }
}

//MARK:- PickerView Method
extension SegmentCreate: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if self.txtTime.isEditing {
            return 60
        }else if self.txtLeftTool.isEditing {
            return arrTool.count
        }else if self.txtRightTool.isEditing {
            return arrTool.count
        }else if self.txtLeftPath.isEditing {
            return arrPath.count
        }else if self.txtRightPath.isEditing {
            return arrPath.count
        }else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if self.txtTime.isEditing {
            return "\(row + 1)"
        }else if self.txtLeftTool.isEditing {
            return arrTool[row]
        }else if self.txtRightTool.isEditing {
            return arrTool[row]
        }else if self.txtLeftPath.isEditing {
            return arrPath[row]
        }else if self.txtRightPath.isEditing {
            return arrPath[row]
        }else {
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if self.IsLink == true {

            if self.txtTime.isEditing {
                self.txtTime.text = "\(row + 1)"
                NotificationCenter.default.post(name: Notification.Name("Time"), object: nil, userInfo: ["Time":"\(row + 1)"])
            }else if self.txtLeftTool.isEditing {
                self.txtLeftTool.text = arrTool[row]
            }else if self.txtRightTool.isEditing {
                self.txtRightTool.text = arrTool[row]
            }else if self.txtLeftPath.isEditing {
                self.txtLeftPath.text = arrPath[row]
            }else if self.txtRightPath.isEditing {
                self.txtRightPath.text = arrPath[row]
            }
        } else {

            if self.txtTime.isEditing {
                self.txtTime.text = "\(row + 1)"
                NotificationCenter.default.post(name: Notification.Name("Time"), object: nil, userInfo: ["Time":"\(row + 1)"])
            }else if self.txtLeftTool.isEditing {
                self.txtLeftTool.text = arrTool[row]
                self.txtRightTool.text = arrTool[row]
            }else if self.txtRightTool.isEditing {
                self.txtRightTool.text = arrTool[row]
                self.txtLeftTool.text = arrTool[row]
            }else if self.txtLeftPath.isEditing {
                self.txtLeftPath.text = arrPath[row]
                self.txtRightPath.text = arrPath[row]
            }else if self.txtRightPath.isEditing {
                self.txtLeftPath.text = arrPath[row]
                self.txtRightPath.text = arrPath[row]
            }
        }
    }
}

//MARK:- UITextFieldDelegate Method
extension SegmentCreate: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.txtTime || textField == self.txtLeftTool || textField == self.txtRightTool || textField == self.txtLeftPath || textField == self.txtRightPath  {
            picker.reloadAllComponents()
        }
    }
}

