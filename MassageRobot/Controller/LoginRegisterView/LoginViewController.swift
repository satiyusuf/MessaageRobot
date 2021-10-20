//
//  LoginViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 04/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableiew: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.isHidden = true
        
        SetUpUIView()
    }
    
    func SetUpUIView()  {
        //self.tableiew.reloadData()
            
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "LogRegi")?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor.init(patternImage: image!)
    }
    
    override func viewDidLayoutSubviews() {
        tableiew.isScrollEnabled = tableiew.contentSize.height > tableiew.frame.size.height
    }
    
    func cellDESIGNform(dcell : loginviewcell){
        
        dcell.selectionStyle = .none
        
        corrner_Raduis(value: 10, outlet: dcell.login_btn)
        
        corrner_Raduis(value: 3, outlet: dcell.username_txtfld)
        
        corrner_Raduis(value: 3, outlet: dcell.password_txtfld)
        
        corrner_Raduis(value: 15, outlet: dcell.viewBack)
        
        corrner_Raduis(value: 15, outlet: dcell.viewLeft)
        
        corrner_Raduis(value: 15, outlet: dcell.viewRight)
        
        dcell.viewLeft.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: -20, height: 8), radius: 5, scale: true)
        dcell.viewRight.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: 20, height: 8), radius: 5, scale: true)
    }
    
    func loginApi(username : String ,
                  password :  String)  {
        
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
}

//MARK:- extension for tableview

extension LoginViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! loginviewcell
        
        cellDESIGNform(dcell: cell)
        
        return cell
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class loginviewcell: UITableViewCell {
    
    var login = LoginViewController()
    
    func getTextFieldLeftAndRightView() -> UIView {
        let paddingView: UIView = UIView.init(frame: CGRect(x:0, y: 0, width:10, height:10))
        return paddingView
    }
    
    @IBAction func loginAction_Action(_ sender: Any) {
        
        if let root = UIApplication.topViewController() {
            //do sth with root view controller
            
            if(username_txtfld.text?.isEmpty == true && password_txtfld.text?.isEmpty == true) {
                showAlert(title: helper.shared.APP_ALERT_TITLE_OOPS, message: "Please enter your username and password.", viewController: root)
            }
            else if username_txtfld.text == "" {
                showAlert(title: helper.shared.APP_ALERT_TITLE_OOPS, message: "Please enter your username.", viewController: root)
            }
            else if password_txtfld.text == "" {
                showAlert(title: helper.shared.APP_ALERT_TITLE_OOPS, message: "Please enter your password.", viewController: root)
            }
            else if helper.shared.isValidEmail(emailID: username_txtfld.text!) == false {
                showAlert(title: helper.shared.APP_ALERT_TITLE_OOPS, message: "Please enter valid email address", viewController: root)
            }
            else {
                username_txtfld.resignFirstResponder()
                password_txtfld.resignFirstResponder()
                
                username_txtfld.textRect(forBounds: CGRect(x:0, y: 0, width:10, height:10))
                password_txtfld.textRect(forBounds: CGRect(x:0, y: 0, width:10, height:10))
                                
                let emailID : String = username_txtfld!.text!
                let password : String = password_txtfld!.text!
                
                print("\(emailID) \(password)")
                
                //Api call
                
                login.loginApi(username: emailID, password: password)
            }
        }
    }
    
    
    @IBAction func registerViewNAv(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
     
    @IBOutlet weak var username_txtfld: UITextField!
    @IBOutlet weak var password_txtfld: UITextField!
    @IBOutlet weak var login_btn: UIButton!
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
}
