//
//  NewCreateSegmentVC.swift
//  MassageRobot
//
//  Created by Emp-Mac on 01/11/21.
//

import UIKit

class NewCreateSegmentVC: UIViewController {

    //MARK:- Outlet
    @IBOutlet weak var RoutinDataView: NewRoutinView!
    @IBOutlet weak var btnIsLink: UIButton!
    @IBOutlet weak var ImgImage: UIImageView!
    @IBOutlet weak var ImgLeft: UIImageView!
    @IBOutlet weak var ImgRight: UIImageView!
    
    //SegmentCreateViewOutlet
    @IBOutlet weak var SegmentCreateView: UIView!
    @IBOutlet weak var btnMinesh: UIButton!
    @IBOutlet weak var btnPlush: UIButton!
    
    //BodySelectionOutlet
    @IBOutlet weak var btnBodyPartSelectionView: UIView!
    @IBOutlet weak var ImgBodyPartImage: UIImageView!
    
    
    
    //MARK:- Variable
    let arrPath = ["none", "Linear", "Circular", "Random", "Point"]
    let arrTool = ["none", "Omni", "Inline", "Point", "Kneading","Sport","Precussion","Calibration"]
    var arrSegmentList = [[String: Any]]()
    let picker = UIPickerView()
    
    var IsLink:Bool = false
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.SetUpVC()
    }
    
    //MARK:- Action
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnReset(_ sender: Any) {
    }
    @IBAction func btnIsLink(_ sender: Any) {
        
        if btnIsLink.isSelected == false {
            self.btnIsLink.isSelected = true
            print("isSelected true")
        } else if btnIsLink.isSelected == true {
            self.btnIsLink.isSelected = false
            print("isSelected false")
        }
    }
    @IBAction func btnFirstSegment(_ sender: Any) {
    }
    @IBAction func btnPreviSegment(_ sender: Any) {
    }
    @IBAction func btnMinesh(_ sender: Any) {
    }
    @IBAction func btnPlush(_ sender: Any) {
    }
    @IBAction func btnNextSegment(_ sender: Any) {
    }
    @IBAction func btnLastSegment(_ sender: Any) {
    }
    
    //MARK:- Action
    // **************************************  Action Body Part Select  **************************************
    //FrontRightSide
    @IBAction func btnFrontRightPectoralis(_ sender: Any) {
    }
    @IBAction func btnFrontRightIliotibalTract(_ sender: Any) {
    }
    @IBAction func btnFrontRightQuadracepts(_ sender: Any) {
    }
    @IBAction func btnFrontRightBodyparam(_ sender: Any) {
    }
    @IBAction func btnFrontRightTibalisAnterior(_ sender: Any) {
    }
    //FrontLeftSide
    @IBAction func btnFrontLeftPectoralis(_ sender: Any) {
    }
    @IBAction func btnFrontLeftIliotibalTract(_ sender: Any) {
    }
    @IBAction func btnFrontLeftQuadracepts(_ sender: Any) {
    }
    @IBAction func btnFrontLeftBodyparam(_ sender: Any) {
    }
    @IBAction func btnFrontLeftTibalisAnterior(_ sender: Any) {
    }
    //BackRightSide
    @IBAction func btnBackRightDeltoid(_ sender: Any) {
    }
    @IBAction func btnBackRightUpperback(_ sender: Any) {
    }
    @IBAction func btnBackRightLowerback(_ sender: Any) {
    }
    @IBAction func btnBackRIghtGastrocnemius(_ sender: Any) {
    }
    @IBAction func btnBackRightHamstring(_ sender: Any) {
    }
    @IBAction func btnBackRightGlutiusmaximus(_ sender: Any) {
    }
    
    //BackLeftSide
    @IBAction func btnBackLeftDeltoid(_ sender: Any) {
    }
    @IBAction func btnBackLeftUpperback(_ sender: Any) {
    }
    @IBAction func btnBackLeftLowerback(_ sender: Any) {
    }
    @IBAction func btnBackLeftGastrocnemius(_ sender: Any) {
    }
    @IBAction func btnBackLeftHamstring(_ sender: Any) {
    }
    @IBAction func btnBackLeftGlutiusmaximus(_ sender: Any) {
    }
    
    @IBAction func btnBodyLocationSectionHide(_ sender: Any) {
        self.btnBodyPartSelectionView.isHidden = true
    }
    
    
    
    
}
//MARK:- Call Api Function
extension NewCreateSegmentVC
{
   private func NewSegmentCreateApiCAll()
   {
     let Time = RoutinDataView.txtTimePicker.text!
     let LeftTool = RoutinDataView.txtLeftToolPicker.text!
     let RightTool = RoutinDataView.txtRightToolPicker.text!
     let LeftLocation = RoutinDataView.btnLeftLocation.titleLabel?.text!.lowercased()
     let RightLocation = RoutinDataView.btnRightLocation.titleLabel?.text!.lowercased()
     let LeftPath = RoutinDataView.txtLeftPath.text!
     let RightPath = RoutinDataView.txtRightPath.text!
     let LeftSpeed = RoutinDataView.lblLeftSpeedText.text!
     let RightSpeed = RoutinDataView.lblRightSpeedText.text!
     let LeftForce = RoutinDataView.lblLeftForceText.text!
     let RightForce = RoutinDataView.lblRightForceText.text!
    
     let now = Date()

     let formatter = DateFormatter()
     formatter.dateFormat = "yyyy-MM-dd HH:mm"

     let datetime = formatter.string(from: now)
     print(datetime)

     let timeAndDate = datetime.components(separatedBy: " ")

     let strDate: String = String(format: "%@", timeAndDate[0])
     let strTime: String = String(format: "%@", timeAndDate[1])
   }
}
//MARK:- SetUpVC Private Function
extension NewCreateSegmentVC
{
    private func NewSegmentCreate()
    {
        if RoutinDataView.txtLeftToolPicker.text?.isEmpty == true {
            showToast(message: "Please insert left tool.")
            return
        } else if RoutinDataView.txtRightToolPicker.text?.isEmpty == true {
            showToast(message: "Please insert right tool.")
            return
        } else if RoutinDataView.btnLeftLocation.titleLabel?.text == "L. Location" {
            showToast(message: "Please insert left loction.")
            return
        } else if RoutinDataView.btnRightLocation.titleLabel?.text == "R. Location" {
            showToast(message: "Please insert right loction.")
            return
        } else if RoutinDataView.txtLeftPath.text?.isEmpty == true {
            showToast(message: "Please insert left path.")
            return
        } else if RoutinDataView.txtRightPath.text?.isEmpty == true {
            showToast(message: "Please insert right path.")
            return
        } else if RoutinDataView.lblLeftSpeedText.text?.isEmpty == true {
            showToast(message: "Please insert left Speed.")
            return
        } else if RoutinDataView.lblRightSpeedText.text?.isEmpty == true {
            showToast(message: "Please insert right Speed.")
            return
        } else if RoutinDataView.lblLeftForceText.text?.isEmpty == true {
            showToast(message: "Please insert left Force.")
            return
        } else if RoutinDataView.lblRightForceText.text?.isEmpty == true {
            showToast(message: "Please insert right Force.")
            return
        } else {
            
        }
    }
   private func SetUpVC()
   {
     picker.delegate = self
     picker.dataSource = self
    
    RoutinDataView.btnLeftLocation.addTarget(self, action: #selector(LeftLocationSelection(sender:)), for: .touchUpInside)
    RoutinDataView.btnLeftLocation.addTarget(self, action: #selector(RightLocationSelection(sender:)), for: .touchUpInside)
    
     RoutinDataView.txtTimePicker.inputView = picker
     RoutinDataView.txtLeftPath.inputView = picker
     RoutinDataView.txtRightPath.inputView = picker
     RoutinDataView.txtLeftToolPicker.inputView = picker
     RoutinDataView.txtRightToolPicker.inputView = picker
    
    RoutinDataView.txtTimePicker.delegate = self
    RoutinDataView.txtLeftPath.delegate = self
    RoutinDataView.txtRightPath.delegate = self
    RoutinDataView.txtLeftToolPicker.delegate = self
    RoutinDataView.txtRightToolPicker.delegate = self
   }
    
    @objc func LeftLocationSelection(sender: UIButton){
        let buttonTag = sender.tag
    }
    @objc func RightLocationSelection(sender: UIButton){
        let buttonTag = sender.tag
    }
}


//MARK:- PickerView Method
extension NewCreateSegmentVC: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if RoutinDataView.txtTimePicker.isEditing {
            return 60
        }else if RoutinDataView.txtLeftToolPicker.isEditing {
            return arrTool.count
        }else if RoutinDataView.txtRightToolPicker.isEditing {
            return arrTool.count
        }else if RoutinDataView.txtLeftPath.isEditing {
            return arrPath.count
        }else if RoutinDataView.txtRightPath.isEditing {
            return arrPath.count
        }else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if RoutinDataView.txtTimePicker.isEditing {
            return "\(row + 1)"
        }else if RoutinDataView.txtLeftToolPicker.isEditing {
            return arrTool[row]
        }else if RoutinDataView.txtRightToolPicker.isEditing {
            return arrTool[row]
        }else if RoutinDataView.txtLeftPath.isEditing {
            return arrPath[row]
        }else if RoutinDataView.txtRightPath.isEditing {
            return arrPath[row]
        }else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if btnIsLink.isSelected == true {
            
            if RoutinDataView.txtTimePicker.isEditing {
                RoutinDataView.txtTimePicker.text = "\(row + 1)"
            }else if RoutinDataView.txtLeftToolPicker.isEditing {
                RoutinDataView.txtLeftToolPicker.text = arrTool[row]
            }else if RoutinDataView.txtRightToolPicker.isEditing {
                RoutinDataView.txtRightToolPicker.text = arrTool[row]
            }else if RoutinDataView.txtLeftPath.isEditing {
                RoutinDataView.txtLeftPath.text = arrPath[row]
            }else if RoutinDataView.txtRightPath.isEditing {
                RoutinDataView.txtRightPath.text = arrPath[row]
            }
        } else {
            
            if RoutinDataView.txtTimePicker.isEditing {
                RoutinDataView.txtTimePicker.text = "\(row + 1)"
            }else if RoutinDataView.txtLeftToolPicker.isEditing {
                RoutinDataView.txtLeftToolPicker.text = arrTool[row]
                RoutinDataView.txtRightToolPicker.text = arrTool[row]
            }else if RoutinDataView.txtRightToolPicker.isEditing {
                RoutinDataView.txtRightToolPicker.text = arrTool[row]
                RoutinDataView.txtLeftToolPicker.text = arrTool[row]
            }else if RoutinDataView.txtLeftPath.isEditing {
                RoutinDataView.txtLeftPath.text = arrPath[row]
                RoutinDataView.txtRightPath.text = arrPath[row]
            }else if RoutinDataView.txtRightPath.isEditing {
                RoutinDataView.txtRightPath.text = arrPath[row]
                RoutinDataView.txtLeftPath.text = arrPath[row]
            }
        }
       
    }
}
//MARK:- UITextFieldDelegate Method
extension NewCreateSegmentVC: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        if textField == RoutinDataView.txtTimePicker || textField == RoutinDataView.txtLeftToolPicker || textField == RoutinDataView.txtRightToolPicker || textField == RoutinDataView.txtLeftPath || textField == RoutinDataView.txtRightPath  {
            picker.selectRow(textField.tag, inComponent: 0, animated: true)
            picker.reloadAllComponents()
        }
    }
}
