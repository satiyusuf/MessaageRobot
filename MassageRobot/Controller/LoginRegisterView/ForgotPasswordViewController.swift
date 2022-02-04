//
//  ForgotPasswordViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 05/03/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var btnSendLink: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var viewOTPLeft: UIView!
    @IBOutlet weak var viewOTPRight: UIView!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var viewAction: UIView!
    
    @IBOutlet weak var lblNotified: UILabel!
        
    @IBOutlet var txtOTP: [UITextField]!
    
    var otpFromUser = ""
    var otpFromAPI = ""
    
    var isOTPViewOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewLeft.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: -20, height: 8), radius: 5, scale: true)
        viewRight.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: 20, height: 8), radius: 5, scale: true)
        
        viewOTPLeft.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: -20, height: 8), radius: 5, scale: true)
        viewOTPRight.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: 20, height: 8), radius: 5, scale: true)
        
        txtEmailPhone.delegate = self
        
        for t in txtOTP
        {
            t.delegate = self
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))

        viewBack.addGestureRecognizer(tapGestureRecognizer)
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            viewBack.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.viewBack.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            viewBack.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            viewBack.addSubview(viewAction)
        } else {
            viewBack.backgroundColor = .white
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view", sender)
        viewBack.isHidden = true
        isOTPViewOpen = false
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    
    @IBAction func btnSendLinkAction(_ sender: UIButton) {
        
        if txtEmailPhone.text?.isEmpty == true {
            showToast(message: "Please Enter Your Email id")
        } else if helper.shared.isValidEmail(emailID: txtEmailPhone.text!) == false {
            showToast(message: "Please enter valid email address.")
        } else {
            self.Forgotpass()
        }
//        let alert = UIAlertController(title: "Alert!", message: "Please check your mail_id, we have send OTP.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//            self.setOTPViewOpen()
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func setOTPViewOpen() {
//
//        for txt in self.txtOTP {
//            txt.text = ""
//        }
//
//        self.viewBack.isHidden = false
//        self.viewAction.isHidden = false
//
//        self.isOTPViewOpen = true
    }
    
    @IBAction func btnSubmitOTPAction(_ sender: UIButton) {
        
        self.viewBack.isHidden = true
        self.viewAction.isHidden = true
                
        otpFromUser = ""
        for txt in txtOTP {
            otpFromUser += txt.text!
        }
        
        self.viewBack.isHidden = true
        self.viewAction.isHidden = true

        isOTPViewOpen = false
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
        
//        if otpFromUser == otpFromAPI {
//
//        }else {
//            showAlert(title: "Alert", message: "Invalid otp", options: "Ok", completion: nil)
//        }
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isOTPViewOpen == true {
            let text = string
            if text.count >= 1
            {
                textField.text = text
                if textField.tag != 4
                {
                    txtOTP[textField.tag].becomeFirstResponder()
                }
                else
                {
                    view.endEditing(true)
                }
            }
        }
                
        return true
    }
}


//MARK:- Private function
extension ForgotPasswordViewController {
    
    private func Forgotpass(){
        
      //  let token = UserDefaults.standard.object(forKey: TOKEN) as? String ?? ""
        guard isReachable else{return}
        showLoading()
        let url = "https://api.massagerobotics.com/user/forgot-password/"
        let parameters = ["email":self.txtEmailPhone.text!]
        ApiHelper.sharedInstance.PostMethodServiceCall(url: url, param: parameters, Token: "", method: .post) { [self] (response,error) in
            self.hideLoading()
            if response != nil {
                let status = response!["status"] as! Bool
                if status {
                    let alert = UIAlertController(title: "Alert!", message: "Please check your mail_id, we have send OTP.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    showToast(message: "Your Password Not Change")
                }
            } else {
                self.showToast(message: "Something is wrong please try againt")
            }
        }
    }
}
