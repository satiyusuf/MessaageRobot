//
//  LoginViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 04/03/21.
//

import UIKit
import Alamofire
import Foundation
import AuthenticationServices
import GoogleSignIn
import BiometricAuthentication

class LoginViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var AppleLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLoginWithFace: UIButton!
    
    //MARK:- Variable
    var googleSignIn = GIDSignIn.sharedInstance

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.txtEmail.layer.cornerRadius = 7
        self.txtPass.layer.cornerRadius = 7
        self.btnLogin.layer.cornerRadius = 15
     //   self.appleLoginButton()
        let EmailPrefrence = UserDefaults.standard.object(forKey: "EmailPrefrence") as? String ?? ""
        let PasswordPrefrence = UserDefaults.standard.object(forKey: "PasswordPrefrence") as? String ?? ""
        print("EmailPrefrence:\(EmailPrefrence),PasswordPrefrence:\(PasswordPrefrence)")
        if EmailPrefrence.isEmpty == true && PasswordPrefrence.isEmpty == true {
            self.btnLoginWithFace.isUserInteractionEnabled = false
            print("false")
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
    }
    @IBAction func btnForGotPass(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnLogin(_ sender: Any) {
        
        if(txtEmail.text?.isEmpty == true && txtPass.text?.isEmpty == true) {
            self.alert(message: "Please enter your username and password.", title: "Error")
        } else if txtEmail.text == "" {
            self.alert(message: "Please enter your email.", title: "Error")
        } else if txtPass.text == "" {
            self.alert(message: "Please enter your password.", title: "Error")
        } else if helper.shared.isValidEmail(emailID: txtEmail.text!) == false {
            self.alert(message: "Please enter valid email address.", title: "Error")
        } else {
            NewApiCall(Email: txtEmail.text!, Pass: txtPass.text!)
            // loginApi(username: self.txtEmail.text!, password: txtPass.text!)
        }
    }
    @IBAction func btnGoogleLogin(_ sender: Any) {
        self.googleAuthLogin()
    }
    @IBAction func btnRegister(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnLoginWithApple(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
    @IBAction func btnLoginWithFace(_ sender: Any)
    {
        // Set AllowableReuseDuration in seconds to bypass the authentication when user has just unlocked the device with biometric
        BioMetricAuthenticator.shared.allowableReuseDuration = 30
        
        // start authentication
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { [self] (result) in
                
            switch result {
            case .success(let data):
                print("data:-\(data)")
                //self?.alert(message:"Face Login" , title: "Succssufully")
                self.facelogin()
                
            case .failure(let error):
                
                switch error {
                // device does not support biometric (face id or touch id) authentication
                case .biometryNotAvailable:
                    self.alert(message: error.message(), title: "BiometryNotAvailable")
                // No biometry enrolled in this device, ask user to register fingerprint or face
                case .biometryNotEnrolled:
                    let alert = UIAlertController(title: "BiometryNotEnrolled", message: error.message(), preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Go to settings", style: .default, handler: { action in
                        let url = URL(string: UIApplication.openSettingsURLString)
                                    if UIApplication.shared.canOpenURL(url!) {
                                        UIApplication.shared.open(url!, options: [:])
                                    }
                    })
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                // show alternatives on fallback button clicked
                case .fallback:
                    self.alert(message:"Login" , title: "Succssufully")
                case .biometryLockedout:
                    self.alert(message: error.message(), title: "BiometryLockedout")
                // do nothing on canceled by system or user
                case .canceledBySystem, .canceledByUser:
                    break
                    
                // show error for any other reason
                default:
                    self.alert(message: error.message())
                }
            }
        }
    }
}

//MARK:- Api Call Function
extension LoginViewController {
    
    func loginApi(username : String ,password :  String)  {
        
        let categoryListUrl = ApiUrls.baseURL
        let SignupSubUrl = ApiUrls.loginsubUrl
        let url = "\(categoryListUrl)\(SignupSubUrl) email='\(username)' and password='\(password)''"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{return}
        
        callAPI(url: encodedUrl, param: [:], method: .post) { (rModel:[LogionModel]?) in
            self.hideLoading()
            if let rModel = rModel?.first{
                print(rModel.email!)
                print(rModel.firstname!)
                print(rModel.lastname!)
                
                let strUserName = rModel.firstname! + " " + rModel.lastname!
                
                UserDefaults.standard.set(strUserName, forKey: USERNAME)
                UserDefaults.standard.set(rModel.userid, forKey: USERID)
                UserDefaults.standard.set(rModel.email!, forKey: EMAILID)
                UserDefaults.standard.set(rModel.firstname ?? "", forKey: FIRSTNAME)
                
                let isHome: String = UserDefaults.standard.object(forKey: ISHOMEPAGE) as? String ?? "No"
                
                UserDefaults.standard.set("Yes", forKey: ISLOGIN)
                UserDefaults.standard.set("No", forKey: ISANSUPLOAD)
                
//                let vc = UIStoryboard.init(name: "CreateToutine", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                
                    if isHome == "Yes" {
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                    }else {
                        let vc = UIStoryboard.init(name: "CreateToutine", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                //ERROO BLOCK
                UserDefaults.standard.set("No", forKey: ISLOGIN)
                UIApplication.topViewController()?.showAlert(message: "Wrong Credentials", options: "OK", completion: nil)
                
            }
        }
    }
    
    func facelogin(){
        let EmailPrefrence = UserDefaults.standard.object(forKey: "EmailPrefrence") as? String ?? ""
        let PasswordPrefrence = UserDefaults.standard.object(forKey: "PasswordPrefrence") as? String ?? ""
        let SocialType = UserDefaults.standard.object(forKey: "SocialType") as? String ?? "" //value(forKey: "SocialType")
        print("EmailPrefrence:\(EmailPrefrence),PasswordPrefrence:\(PasswordPrefrence),SocialType:\(SocialType)")

    
        if EmailPrefrence.isEmpty == false && PasswordPrefrence.isEmpty == false && SocialType.isEmpty == false {
            DispatchQueue.main.async {
               self.NewApiCall(Email: EmailPrefrence, Pass: PasswordPrefrence)
                self.SocialLogin(Email: EmailPrefrence, SocialID: PasswordPrefrence, SocialType: SocialType)
           }
        } else {
            DispatchQueue.main.async {
               self.NewApiCall(Email: EmailPrefrence, Pass: PasswordPrefrence)
           }
        }
    }
        
    func NewApiCall(Email:String,Pass:String) {
    
        guard isReachable else{
            return

        }
        showLoading()
        let url = "https://api.massagerobotics.com/user/login/"
        var parameters = [String:Any]()
        parameters = ["email":Email,"password":Pass]
        UserDefaults.standard.set(txtEmail.text!, forKey: "EmailPrefrence")
        UserDefaults.standard.set(txtPass.text!, forKey: "PasswordPrefrence")
        ApiHelper.sharedInstance.PostMethodServiceCall(url: url, param: parameters, Token: "", method: .post) { (response, error) in
            self.hideLoading()
            
            if response != nil {
                let Status = response!["status"] as! Bool
                if Status {
                    let RespoData = response!["data"] as! [String:Any]
                    self.UserDetails(Token: RespoData["token"] as? String ?? "")
                    UserDefaults.standard.set( RespoData["token"] as? String ?? "", forKey: TOKEN)
                    print("RespoData:-\(RespoData)")
                } else {
                    let RespoData = response!["data"] as! [String:Any]
                    let message = RespoData["detail"] as? String ?? ""
                    print(message)
                    self.showToast(message: message)
                }
            } else {
                self.showToast(message: "Something is wrong please try againt")
            }
        }
    }
    func SocialLogin(Email:String,SocialID:String,SocialType:String) {
        UserDefaults.standard.set(Email, forKey: "EmailPrefrence")
        UserDefaults.standard.set(SocialID, forKey: "PasswordPrefrence")
        UserDefaults.standard.set(SocialType, forKey: "SocialType")
        guard isReachable else{
            return

        }
        showLoading()
        let url = "https://api.massagerobotics.com/user/social/login/"
        var parameters = [String:Any]()
        parameters = ["email":Email,"issociallogin":"true","socialid":SocialID,"socialtype":SocialType]
   
        ApiHelper.sharedInstance.PostMethodServiceCall(url: url, param: parameters, Token: "", method: .post) { (response, error) in
            self.hideLoading()
            
            if response != nil {
                let Status = response!["status"] as! Bool
                if Status {
                    let RespoData = response!["data"] as! [String:Any]
                    self.UserDetails(Token: RespoData["token"] as? String ?? "")
                    UserDefaults.standard.set( RespoData["token"] as? String ?? "", forKey: TOKEN)
                    print("RespoData:-\(RespoData)")
                } else {
                    let RespoData = response!["data"] as! [String:Any]
                    let message = RespoData["detail"] as? String ?? ""
                    print(message)
                    self.showToast(message: message)
                }
            } else {
                self.showToast(message: "Something is wrong please try againt")
            }
        }
    }
        
        func UserDetails(Token:String) {
            
            guard isReachable else{return}
            showLoading()
            let url = "https://api.massagerobotics.com/user/profile/?userid"
            
            ApiHelper.sharedInstance.GetMethodServiceCall(url: url, Token: Token) { (response, error) in
                self.hideLoading()
                if response != nil {
                    let Status = response!["status"] as! Bool
                    if Status {
                        let RespoData = response!["data"] as! [String:Any]
                        print("RespoData:-\(RespoData)")
                        
                        let FirstName = RespoData["firstname"] as? String ?? ""
                        let LastName = RespoData["lastname"] as? String ?? ""
                        let strUserName = FirstName + " " + LastName
                        let UserID = RespoData["userid"] as? String ?? ""
                        let Email = RespoData["email"] as? String ?? ""
                        
                        UserDefaults.standard.set(strUserName, forKey: USERNAME)
                        UserDefaults.standard.set(UserID, forKey: USERID)
                        UserDefaults.standard.set(Email, forKey: EMAILID)
                        UserDefaults.standard.set(FirstName, forKey: FIRSTNAME)
                        
                        let isHome: String = UserDefaults.standard.object(forKey: ISHOMEPAGE) as? String ?? "No"
                        
                        UserDefaults.standard.set("Yes", forKey: ISLOGIN)
                        UserDefaults.standard.set("No", forKey: ISANSUPLOAD)
                        
                        if isHome == "Yes" {
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                        }else {
                            let vc = UIStoryboard.init(name: "CreateToutine", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                        }
                    } else {
                        let RespoData = response!["data"] as! [String:Any]
                        let message = (RespoData["non_field_errors"]! as! NSArray).mutableCopy() as! NSMutableArray
                        let NewMeaage = message[0]
                        print(message)
                        self.showToast(message: NewMeaage as? String ?? "")
                    }
                } else {
                    self.showToast(message: "Something is wrong please try againt")
                }
                
            }
        }
    
    private func googleAuthLogin() {
        let googleConfig = GIDConfiguration(clientID: "139727097596-plbahmao0k41g5pah4kul8v42va458ij.apps.googleusercontent.com")
        self.googleSignIn.signIn(with: googleConfig, presenting: self) { user, error in
            
            if error == nil {
                guard let user = user else {
                    print("Uh oh. The user cancelled the Google login.")
                    return
                }

                let userId = user.userID ?? ""
                print("Google User ID: \(userId)")
                
                let userIdToken = user.authentication.idToken ?? ""
                print("Google ID Token: \(userIdToken)")
                
                let userFirstName = user.profile?.givenName ?? ""
                print("Google User First Name: \(userFirstName)")
                
                let userLastName = user.profile?.familyName ?? ""
                print("Google User Last Name: \(userLastName)")
                
                let userEmail = user.profile?.email ?? ""
                print("Google User Email: \(userEmail)")
                
                let googleProfilePicURL = user.profile?.imageURL(withDimension: 150)?.absoluteString ?? ""
                print("Google Profile Avatar URL: \(googleProfilePicURL)")
                self.SocialLogin(Email: userEmail, SocialID: userId, SocialType: "google")
            }
        }
    }
}

//MARK:- Private Functin LoginWithApple
extension LoginViewController {
    
    func appleLoginButton() {
            if #available(iOS 13.0, *) {
                let appleLoginBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
                appleLoginBtn.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
                self.AppleLogin.addSubview(appleLoginBtn)
             
                appleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    appleLoginBtn.trailingAnchor.constraint(equalTo:self.AppleLogin.trailingAnchor),
                    appleLoginBtn.leadingAnchor.constraint(equalTo: self.AppleLogin.leadingAnchor),
                    appleLoginBtn.topAnchor.constraint(equalTo: self.AppleLogin.topAnchor),
                    appleLoginBtn.bottomAnchor.constraint(equalTo: self.AppleLogin.bottomAnchor)
                    ])
            }
        }
    
    @objc func actionHandleAppleSignin() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

//MARK:-ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Get user data with Apple ID credentitial
            let userId = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName
            let userLastName = appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email
            print("User ID: \(userId)")
            print("User First Name: \(userFirstName ?? "")")
            print("User Last Name: \(userLastName ?? "")")
            print("User Email: \(userEmail ?? "")")
            self.SocialLogin(Email: userEmail ?? "", SocialID: userId, SocialType: "apple")
            // Write your code here
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Get user data using an existing iCloud Keychain credential
            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            // Write your code here
        }
    }
}
//MARK:-ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
           return self.view.window!
    }
}


extension UIViewController {

    func alert(message: String, title: String = "")
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in

        })

        alert.addAction(ok)

        self.present(alert, animated: true, completion: nil)
    }
}

//// MARK: - Alerts
//extension ViewController {
//
//    func showAlert(title: String, message: String) {
//
//        let okAction = AlertAction(title: OKTitle)
//        let alertController = getAlertViewController(type: .alert, with: title, message: message, actions: [okAction], showCancel: false) { (button) in
//        }
//        present(alertController, animated: true, completion: nil)
//    }
//
//    func showLoginSucessAlert() {
//        showAlert(title: "Success", message: "Login successful")
//    }
//
//    func showErrorAlert(message: String) {
//        showAlert(title: "Error", message: message)
//    }
//
//    func showGotoSettingsAlert(message: String) {
//        let settingsAction = AlertAction(title: "Go to settings")
//
//        let alertController = getAlertViewController(type: .alert, with: "Error", message: message, actions: [settingsAction], showCancel: true, actionHandler: { (buttonText) in
//            if buttonText == CancelTitle { return }
//
//            // open settings
//            let url = URL(string: UIApplication.openSettingsURLString)
//            if UIApplication.shared.canOpenURL(url!) {
//                UIApplication.shared.open(url!, options: [:])
//            }
//
//        })
//        present(alertController, animated: true, completion: nil)
//    }
//}
