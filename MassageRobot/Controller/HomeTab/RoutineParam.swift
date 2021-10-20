//
//  RoutineParam.swift
//  MassageRobot
//
//  Created by Augmenta on 21/07/21.
//

import UIKit

class RoutineParam: UIView {

    class func instanceFromNib() -> RoutineParam {
        let view = UINib(nibName: "RoutineParam", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RoutineParam
        return view
    }
    
    @IBOutlet weak var lblSegmentNo: UILabel!
    @IBOutlet weak var lblSegmentStart: UILabel!
    @IBOutlet weak var lblSegmentEnd: UILabel!
    @IBOutlet weak var viewLeftSpeed: UIView!
    @IBOutlet weak var viewRightSpeed: UIView!
    @IBOutlet weak var viewLeftForce: UIView!
    @IBOutlet weak var viewRightForce: UIView!
    @IBOutlet weak var lblLeftSpeed: UILabel!
    @IBOutlet weak var lblRightSpeed: UILabel!
    @IBOutlet weak var lblLeftForce: UILabel!
    @IBOutlet weak var lblRightForce: UILabel!
    @IBOutlet weak var txtTime: UnderlineTextField!
    @IBOutlet weak var txtLeftTool: UnderlineTextField!
    @IBOutlet weak var txtRightTool: UnderlineTextField!
    @IBOutlet weak var txtLeftPath: UnderlineTextField!
    @IBOutlet weak var txtRightPath: UnderlineTextField!
    @IBOutlet weak var txtLeftLocation: UnderlineTextField!
    @IBOutlet weak var txtRightLocation: UnderlineTextField!
    
    @IBOutlet weak var btnLocationLeft: UIButton!
    @IBOutlet weak var btnLocationRight: UIButton!
    
    @IBOutlet weak var viewTapGesture: UIView!
    
    var triLeftSpeed: TriangleView!
    var triRightSpeed: TriangleView!
    var triLeftForce: TriangleView!
    var triRightForce: TriangleView!
    
    var sliderValue = 0
    var delegate: SliderValueSetDelegate?
    var delegateRuler: RulerSizeDelegate?
    var delegateLocation: LocationDelegate?
    var delegateChangeData: isChangeDataDelegate?
    var delegateCopyData: isSegmentDataCopy?
    
    let picker = UIPickerView()
    
    var currentViewTag = -1
    
    var intStart: Int!
    var intEnd: Int!
    var intDurationMin: Int = 0
    var intStoreValue: Int = 0
    
    var isLSpeed: Float = 0.0
    var isRSpeed: Float = 0.0
    var isLForce: Float = 0.0
    var isRForce: Float = 0.0
    
    var isLinkData: Bool = false
    
    let arrLRLocation = ["none", "Linear", "Circular", "Random", "Point"]
    let arrLRTool = ["none", "Omni", "Inline", "Point", "Kneading","Sport","Precussion","Calibration"]
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewTapGesture.addGestureRecognizer(tap)
        
        lblSegmentNo.text = String(format: "%02d", tag)
        
        intStoreValue = 0
        intDurationMin = 0
        
        if lblSegmentNo.text == "01" {
            UserDefaults.standard.set("0", forKey: SEGMENTSTART)
            UserDefaults.standard.set("1", forKey: SEGMENTEND)
            
            intStart = 0
            intEnd = 1
            
            lblSegmentStart.text = "0"
            lblSegmentEnd.text = "1"
        }else {
            
            let segStart: String = UserDefaults.standard.object(forKey: SEGMENTSTART) as? String ?? ""
            let segEnd: String = UserDefaults.standard.object(forKey: SEGMENTEND) as? String ?? ""
                                
//            let intCS = Int(segStart)
            let intCE = Int(segEnd)
            
            intStart = intCE!
            intEnd = intCE! + 1
            
            UserDefaults.standard.set("\(intStart!)", forKey: SEGMENTSTART)
            UserDefaults.standard.set("\(intEnd!)", forKey: SEGMENTEND)
            
            lblSegmentStart.text = String(intStart)
            lblSegmentEnd.text = String(intEnd)
        }
                
        triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftSpeed.frame.width, height: 33))
        triLeftSpeed.backgroundColor = .white
        triLeftSpeed.setFillValue(value: 0)
        viewLeftSpeed.addSubview(triLeftSpeed)
        
        triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightSpeed.frame.width, height: 33))
        triRightSpeed.backgroundColor = .white
        triRightSpeed.setFillValue(value: 0)
        viewRightSpeed.addSubview(triRightSpeed)
        
        triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftForce.frame.width, height: 33))
        triLeftForce.backgroundColor = .white
        triLeftForce.setFillValue(value: 0)
        viewLeftForce.addSubview(triLeftForce)
        
        triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightForce.frame.width, height: 33))
        triRightForce.backgroundColor = .white
        triRightForce.setFillValue(value: 0)
        viewRightForce.addSubview(triRightForce)
        
        picker.delegate = self
        picker.dataSource = self
        
        txtTime.delegate = self
        txtLeftTool.delegate = self
        txtRightTool.delegate = self
        txtLeftPath.delegate = self
        txtRightPath.delegate = self
        txtLeftLocation.delegate = self
        txtRightLocation.delegate = self
        
        txtTime.inputView = picker
        txtLeftTool.inputView = picker
        txtRightTool.inputView = picker
        txtLeftPath.inputView = picker
        txtRightPath.inputView = picker
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("tep Gesture Work")
        
        txtTime.resignFirstResponder()
        txtLeftTool.resignFirstResponder()
        txtRightTool.resignFirstResponder()
        txtLeftPath.resignFirstResponder()
        txtRightPath.resignFirstResponder()
        txtLeftLocation.resignFirstResponder()
        txtRightLocation.resignFirstResponder()
                
        viewTapGesture.isHidden = true
    }
    
    @IBAction func btnLeftSpeedAction(_ sender: UIButton) {
        sliderValue = 0
        delegate?.sliderValueSet(value: Float(triLeftSpeed.fillValue) * 100, strAction: "LeftSpeed", index: 0)
    }
    
    @IBAction func btnRightSpeedAction(_ sender: UIButton) {

        sliderValue = 1
        delegate?.sliderValueSet(value: Float(triRightSpeed.fillValue) * 100, strAction: "RightSpeed", index: 1)
    }
    
    @IBAction func btnLeftForceAction(_ sender: UIButton) {
        sliderValue = 2
        delegate?.sliderValueSet(value: Float(triLeftForce.fillValue) * 100, strAction: "LeftForce", index: 2)
    }
    
    @IBAction func btnRightForceAction(_ sender: UIButton) {
        sliderValue = 3
        delegate?.sliderValueSet(value: Float(triRightForce.fillValue) * 100, strAction: "RightForce", index: 3)
    }
    
    @IBAction func btnLeftLocationAction(_ sender: UIButton) {
       //let data = RoutineParam[0]
        delegateLocation?.locationViewAnimation(strLRLocation: "Left", strBodyPart: "", currentIndex: 0)
    }
    
    @IBAction func btnRightLocationAction(_ sender: UIButton) {
        //let data = RoutineParam[0]
        delegateLocation?.locationViewAnimation(strLRLocation: "Right", strBodyPart: "", currentIndex: 0 )
    }
}

extension RoutineParam: isSegmentDataCopy {
    
    func setSegmentDataCopy(isLink: Bool, iscopy: Bool) {
        if isLink == true {
            isLinkData = true
            if txtLeftTool.text != "" {
                txtRightTool.text = txtLeftTool.text
                UserDefaults.standard.set(txtLeftTool.text, forKey: RTOOL)
            }else if txtRightTool.text != "" {
                txtLeftTool.text = txtRightTool.text
                UserDefaults.standard.set(txtRightTool.text, forKey: LTOOL)
            }
            
            if txtLeftPath.text != "" {
                txtRightPath.text = txtLeftPath.text
                UserDefaults.standard.set(txtLeftPath.text, forKey: RPATH)
            }else if txtRightPath.text != "" {
                txtLeftPath.text = txtRightPath.text
                UserDefaults.standard.set(txtRightPath.text, forKey: LPATH)
            }
        }else if iscopy == true {
            isLinkData = false
            self.segmentDataSetAuto()
        }
    }
    
    func segmentDataSetAuto() {
        
        
        if txtLeftTool.text != "" {
            txtRightTool.text = txtLeftTool.text
            UserDefaults.standard.set(txtLeftTool.text, forKey: RTOOL)
        }else if txtRightTool.text != "" {
            txtLeftTool.text = txtRightTool.text
            UserDefaults.standard.set(txtRightTool.text, forKey: LTOOL)
        }
        
        if txtLeftPath.text != "" {
            txtRightPath.text = txtLeftPath.text
            UserDefaults.standard.set(txtLeftPath.text, forKey: RPATH)
        }else if txtRightPath.text != "" {
            txtLeftPath.text = txtRightPath.text
            UserDefaults.standard.set(txtRightPath.text, forKey: LPATH)
        }
                            
        if btnLocationLeft.titleLabel?.text != "L. Location" {
            btnLocationRight.setTitle(btnLocationLeft.titleLabel?.text, for: .normal)
            btnLocationRight.setTitleColor(UIColor.black, for: .normal)
            UserDefaults.standard.set(btnLocationLeft.titleLabel?.text, forKey: RLOCATION)
        }else if btnLocationRight.titleLabel?.text != "R. Location" {
            btnLocationLeft.setTitle(btnLocationRight.titleLabel?.text, for: .normal)
            btnLocationLeft.setTitleColor(UIColor.black, for: .normal)
            UserDefaults.standard.set(btnLocationRight.titleLabel?.text, forKey: LLOCATION)
        }
        
        if lblLeftSpeed.text != "0%" {
            lblRightSpeed.text = lblLeftSpeed.text
            self.sliderValueSet(value: isLSpeed, strAction: "", index: 1)
        }else if lblRightSpeed.text != "0%" {
            lblLeftSpeed.text = lblRightSpeed.text
            self.sliderValueSet(value: isRSpeed, strAction: "", index: 0)
        }
                
        if lblLeftForce.text != "0%" {
            lblRightForce.text = lblLeftForce.text
            self.sliderValueSet(value: isLForce, strAction: "", index: 3)
        }else if lblRightForce.text != "0%" {
            lblLeftForce.text = lblRightForce.text
            self.sliderValueSet(value: isRForce, strAction: "", index: 2)
        }
        
        print("SegmentDataCopy")

    }
}

extension RoutineParam: LocationDelegate
{

    func locationViewAnimation(strLRLocation: String, strBodyPart: String, currentIndex: Int) {
        
        
        
         
        let strSegCopyValue: String = UserDefaults.standard.object(forKey: SEGMENTCOPY) as? String ?? "true"
        
        if strSegCopyValue == "false" {
            isLinkData = false
        }else {
            isLinkData = true
        }
        UserDefaults.standard.set(strBodyPart, forKey: LLOCATION)
        UserDefaults.standard.set(strBodyPart, forKey: RLOCATION)
        
        switch currentIndex {
        case 0:
            if strLRLocation == "Left" {
                btnLocationLeft.setTitleColor(UIColor.black, for: .normal)
                UserDefaults.standard.set(strBodyPart, forKey: LLOCATION)
                btnLocationLeft.setTitle(strBodyPart, for: .normal)

                if isLinkData == true {
                    btnLocationRight.setTitleColor(UIColor.black, for: .normal)
                    UserDefaults.standard.set(strBodyPart, forKey: RLOCATION)
                    btnLocationRight.setTitle(strBodyPart, for: .normal)
                }

            }
        case 1:
            btnLocationRight.setTitleColor(UIColor.black, for: .normal)
            UserDefaults.standard.set(strBodyPart, forKey: RLOCATION)
            btnLocationRight.setTitle(strBodyPart, for: .normal)

            if isLinkData == true {
                btnLocationLeft.setTitleColor(UIColor.black, for: .normal)
                UserDefaults.standard.set(strBodyPart, forKey: LLOCATION)
                btnLocationLeft.setTitle(strBodyPart, for: .normal)
            }
        default:
            break
        }
    }
}

extension RoutineParam: SliderValueSetDelegate
{
    func sliderValueSet(value: Float, strAction: String, index: Int) {
        
//        switch sliderValue {
        switch index {
        case 0:
            if triLeftSpeed != nil
            {
                triLeftSpeed.removeFromSuperview()
            }
            
            isLSpeed = value
            triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftSpeed.frame.width, height: 33))
            triLeftSpeed.backgroundColor = .white
            triLeftSpeed.setFillValue(value: CGFloat(value / 100))
            viewLeftSpeed.addSubview(triLeftSpeed)
            
            lblLeftSpeed.text = "\(Int(value))%"
        case 1:
            if triRightSpeed != nil
            {
                triRightSpeed.removeFromSuperview()
            }
            
            isRSpeed = value
            triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightSpeed.frame.width, height: 33))
            triRightSpeed.backgroundColor = .white
            triRightSpeed.setFillValue(value: CGFloat(value / 100))
            viewRightSpeed.addSubview(triRightSpeed)
            
            lblRightSpeed.text = "\(Int(value))%"
        case 2:
            if triLeftForce != nil
            {
                triLeftForce.removeFromSuperview()
            }
            
            isLForce = value
            triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftForce.frame.width, height: 33))
            triLeftForce.backgroundColor = .white
            triLeftForce.setFillValue(value: CGFloat(value / 100))
            viewLeftForce.addSubview(triLeftForce)
            
            lblLeftForce.text = "\(Int(value))%"
        case 3:
            if triRightForce != nil
            {
                triRightForce.removeFromSuperview()
            }
            
            isRForce = value
            triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightForce.frame.width, height: 33))
            triRightForce.backgroundColor = .white
            triRightForce.setFillValue(value: CGFloat(value / 100))
            viewRightForce.addSubview(triRightForce)
            
            lblRightForce.text = "\(Int(value))%"
        default:
            break
        }
        
//        if isLinkData == true {
//            if lblLeftSpeed.text != "0%" {
//                lblRightSpeed.text = lblLeftSpeed.text
//                self.sliderValueSet(value: isLSpeed, strAction: "", index: 1)
//                return
//            }else if lblRightSpeed.text != "0%" {
//                lblLeftSpeed.text = lblRightSpeed.text
//                self.sliderValueSet(value: isRSpeed, strAction: "", index: 0)
//                return
//            }
//
//            if lblLeftForce.text != "0%" {
//                lblRightForce.text = lblLeftForce.text
//                self.sliderValueSet(value: isLForce, strAction: "", index: 3)
//                return
//            }else if lblRightForce.text != "0%" {
//                lblLeftForce.text = lblRightForce.text
//                self.sliderValueSet(value: isRForce, strAction: "", index: 2)
//                return
//            }
//        }
    }
}


extension RoutineParam: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if txtTime.isEditing {
            return 60
        }else if txtLeftTool.isEditing {
            return arrLRTool.count
        }else if txtRightTool.isEditing {
            return arrLRTool.count
        }else if txtLeftPath.isEditing {
            return arrLRLocation.count
        }else if txtRightPath.isEditing {
            return arrLRLocation.count
        }else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtTime.isEditing {
            return "\(row + 1)"
        }else if txtLeftTool.isEditing {
            return arrLRTool[row]
        }else if txtRightTool.isEditing {
            return arrLRTool[row]
        }else if txtLeftPath.isEditing {
            return arrLRLocation[row]
        }else if txtRightPath.isEditing {
            return arrLRLocation[row]
        }else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtTime.isEditing {
            txtTime.text = "\(row + 1)"
                    
            let segEnd: String = UserDefaults.standard.object(forKey: SEGMENTEND) as? String ?? "1"

            let intCE = Int(segEnd)
            
            intEnd = intCE! + (row)
            
            let intDuration = txtTime.text!
            intDurationMin = Int(intDuration)! * 60
            
            intStoreValue = row
            //UserDefaults.standard.set("\(intEnd! - 1)", forKey: SEGMENTSTART)
            UserDefaults.standard.set("\(intEnd!)", forKey: SEGMENTEND)
            
            lblSegmentEnd.text = String(intDurationMin)
            
            UserDefaults.standard.set(lblSegmentEnd.text, forKey: EXTIME)
            delegateRuler?.rulerSize(size: row + 1, index: tag - 1)
        }else if txtLeftTool.isEditing {
            txtLeftTool.text = arrLRTool[row]
            txtLeftTool.tag = row
            let strLeftTool = txtLeftTool.text?.lowercased()
            UserDefaults.standard.set(strLeftTool, forKey: LTOOL)
        }else if txtRightTool.isEditing {
            txtRightTool.text = arrLRTool[row]
            txtRightTool.tag = row
            let strRightTool = txtRightTool.text?.lowercased()
            UserDefaults.standard.set(strRightTool, forKey: RTOOL)
        }else if txtLeftPath.isEditing {
            txtLeftPath.text = arrLRLocation[row]
            txtLeftPath.tag = row
            let strLeftPath = txtLeftPath.text?.lowercased()
            UserDefaults.standard.set(strLeftPath, forKey: LPATH)
        }else if txtRightPath.isEditing {
            txtRightPath.text = arrLRLocation[row]
            txtRightPath.tag = row
            let strRightPath = txtRightPath.text?.lowercased()
            UserDefaults.standard.set(strRightPath, forKey: RPATH)
        }
        
        if isLinkData == true {
            self.setSegmentDataCopy(isLink: isLinkData, iscopy: false)
        }
        
        delegateChangeData?.setChangeSegmentData()
    }
}

extension RoutineParam: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let strSegCopyValue: String = UserDefaults.standard.object(forKey: SEGMENTCOPY) as? String ?? "true"
        
        if strSegCopyValue == "false" {
            isLinkData = false
        }else {
            isLinkData = true
        }
        
        viewTapGesture.isHidden = false
    
        if txtTime.isEditing {
            txtTime.text = "\(1)"
            //lblSegmentEnd.text = "\(1)"
            
            if intStoreValue != 0 {
                intEnd = intEnd - intStoreValue
                
                if intEnd == 0 {
                    intEnd = 1
                }
            }
//            let segEnd: String = UserDefaults.standard.object(forKey: SEGMENTEND) as? String ?? ""
//
//            let intCE = Int(segEnd)! - intEnd
//
//            intEnd = intCE + 1

            UserDefaults.standard.set("\(intEnd!)", forKey: SEGMENTEND)
        }else if txtLeftTool.isEditing {
            txtLeftTool.text = arrLRTool[textField.tag]
            picker.selectRow(txtLeftTool.tag, inComponent: 0, animated: true)
        }else if txtRightTool.isEditing {
            txtRightTool.text = arrLRTool[textField.tag]
            picker.selectRow(txtRightTool.tag, inComponent: 0, animated: true)
        }else if txtLeftPath.isEditing {
            txtLeftPath.text = arrLRLocation[textField.tag]
            picker.selectRow(txtLeftPath.tag, inComponent: 0, animated: true)
        }else if txtRightPath.isEditing {
            txtRightPath.text = arrLRLocation[textField.tag]
            picker.selectRow(txtRightPath.tag, inComponent: 0, animated: true)
        }
        
        if textField == txtLeftTool || textField == txtRightTool || textField == txtLeftLocation || textField == txtRightLocation || textField == txtLeftPath || textField == txtRightPath {
            picker.reloadAllComponents()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        viewTapGesture.isHidden = true
    }
}
