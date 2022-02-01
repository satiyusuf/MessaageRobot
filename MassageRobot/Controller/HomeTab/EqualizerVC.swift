//
//  EqualizerVC.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 21/08/21.
//

import UIKit

class EqualizerVC: UIViewController {

    @IBOutlet weak var pickerKG: UIPickerView!
    @IBOutlet weak var pickerRabbit: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.pickerKG.delegate = self
//        self.pickerKG.dataSource = self
//            
//        self.pickerRabbit.delegate = self
//        self.pickerRabbit.dataSource = self
    }
    
    @IBAction func btnBodyTopAction(_ sender: UIButton) {
        self.getRoutineMassageTopServiceCall()
    }
    
    @IBAction func btnBodyLeftAction(_ sender: UIButton) {
        self.getRoutineMassageLeftServiceCall()
    }
    
    @IBAction func btnBodyRightAction(_ sender: UIButton) {
        self.getRoutineMassageRightServiceCall()
    }
    
    @IBAction func btnBodyBottomAction(_ sender: UIButton) {
        self.getRoutineMassageBottomServiceCall()
    }
    
    func getRoutineMassageTopServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=up"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            
            if json.getString(key: "status") == "false"
            {
                let string = json.getString(key: "response_message")
                showToast(message: string)
            }
        }
    }
    
    func getRoutineMassageBottomServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        
        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=down"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            
            if json.getString(key: "status") == "false"
            {
                let string = json.getString(key: "response_message")
                showToast(message: string)
            }
        }
    }
    
    func getRoutineMassageLeftServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        
        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=left"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            
            if json.getString(key: "status") == "false"
            {
                let string = json.getString(key: "response_message")
                showToast(message: string)
            }
        }
    }
    
    func getRoutineMassageRightServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        
        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=right"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            
            if json.getString(key: "status") == "false"
            {
                let string = json.getString(key: "response_message")
                showToast(message: string)
            }
        }
    }
    
}

extension EqualizerVC: UIPickerViewDelegate, UIPickerViewDataSource {
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        if component == 0 {
            if pickerView == pickerKG {
                print("First Value KG >>>> \(row + 1)")
            }else {
                print("Second Value KG >>>> \(row + 1)")
            }
        }else if component == 1 {
            if pickerView == pickerKG {
                print("First Value >>>> \(row + 1)")
            }else {
                print("Second Value >>>> \(row + 1)")
            }
        }
    }
}
