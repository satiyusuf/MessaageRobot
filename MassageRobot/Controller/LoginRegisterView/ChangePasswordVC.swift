//
//  ChangePasswordVC.swift
//  MassageRobot
//
//  Created by Emp-Mac-Lenovo on 02/02/22.
//

import UIKit

class ChangePasswordVC: UIViewController {

    //MARK:- Outlet
    @IBOutlet weak var txtConfiPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtOldPass: UITextField!
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    

    //MARK:- Action
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmit(_ sender: Any) {
        if txtOldPass.text?.isEmpty == true {
            showToast(message: "Please Enter Old Password")
        } else if txtNewPass.text?.isEmpty == true {
            showToast(message: "Please Enter New Password")
        } else if txtConfiPass.text?.isEmpty == true {
            showToast(message: "Please Enter Confirm Password")
        }else if txtNewPass.text == txtConfiPass.text {
            self.ChangePassword()
        } else {
            showToast(message: "New Passsword and Confirm Password are not match")
        }
    }
}

//MARK:- Private function
extension ChangePasswordVC {
    
    private func ChangePassword(){
        
        let token = UserDefaults.standard.object(forKey: TOKEN) as? String ?? ""
        guard isReachable else{return}
        showLoading()
        let email = UserDefaults.standard.object(forKey: EMAILID) as? String ?? ""
        let url = "https://api.massagerobotics.com/user/change-password/"
        let parameters = ["old_password":txtOldPass.text!,"new_password":txtNewPass.text!,"email":email]
        ApiHelper.sharedInstance.PostMethodServiceCall(url: url, param: parameters, Token: token, method: .patch) { [self] (response,error) in
            self.hideLoading()
            if response != nil {
                let status = response!["status"] as! Bool
                if status {
                    let alert = UIAlertController(title: "Alert!", message: "Your New Password Succssufully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let Response = response!["data"] as! [String]
                    let message = Response[0]
                    showToast(message: message)
                }
            } else {
                self.showToast(message: "Something is wrong please try againt")
            }
        }
    }
}
