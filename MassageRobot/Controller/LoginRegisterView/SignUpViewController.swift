//
//  SignUpViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 05/03/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "LogRegi")?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        view.backgroundColor = UIColor.init(patternImage: image!)
    }
    
    override func viewDidLayoutSubviews() {
        
        tableview.isScrollEnabled = tableview.contentSize.height > tableview.frame.size.height
    }
    
    func designcell(dCEll : SignupViewCell) {
        dCEll.selectionStyle = .none
        corrner_Raduis(value: 3, outlet: dCEll.firstName)
        corrner_Raduis(value: 3, outlet: dCEll.lastName)
        corrner_Raduis(value: 3, outlet: dCEll.Email)
        corrner_Raduis(value: 3, outlet: dCEll.Phone_txt)
        corrner_Raduis(value: 3, outlet: dCEll.password_text)
        corrner_Raduis(value: 3, outlet: dCEll.ConfirmPassword)
        corrner_Raduis(value: 10, outlet: dCEll.register_btn)
        
        corrner_Raduis(value: 15, outlet: dCEll.viewBack)
        
        corrner_Raduis(value: 15, outlet: dCEll.viewLeft)
        
        corrner_Raduis(value: 15, outlet: dCEll.viewRight)
        
        dCEll.viewLeft.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: -20, height: 8), radius: 5, scale: true)
        dCEll.viewRight.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: 20, height: 8), radius: 5, scale: true)    
    }
    
    //MARK:-  Api call hit
    func getNewUser(userID:String,
                    firstname:String,
                    lastname:String,
                    email:String,
                    lastlogin:String,
                    registerdate:String,
                    role:String,
                    password:String)  {
        
        
        let categoryListUrl = ApiUrls.baseURL
        let SignupSubUrl = ApiUrls.SignUpsubUrl
        let url = "\(categoryListUrl)\(SignupSubUrl)[('\(userID)','\(firstname)','\(lastname)','\(email)','\(registerdate)','\(lastlogin)','\(role)','\(password)')]"
        
        print(url)
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        callAPI(url: encodedUrl, param: [:], method: .post) { (rModel:LogionModel?) in
            self.hideLoading()
            if rModel != nil{
                
                UserDefaults.standard.set("No", forKey: ISANSUPLOAD)
                
                let isHome: String = UserDefaults.standard.object(forKey: ISHOMEPAGE) as? String ?? "No"
                if isHome == "Yes" {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                    UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                }else {
                    let vc = UIStoryboard.init(name: "CreateToutine", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                //ERROO BLOCK
            }
        }
    }
}

extension SignUpViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SignupViewCell
        designcell(dCEll: cell)
        return cell
    }
}


class SignupViewCell: UITableViewCell {
    
    var signup = SignUpViewController()
    
    
    @IBAction func Signup(_ sender: Any) {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        if let root = UIApplication.topViewController() {
            
            if(firstName.text?.isEmpty == true || lastName.text?.isEmpty == true) || Email.text?.isEmpty == true || Phone_txt.text?.isEmpty == true || password_text.text?.isEmpty == true || ConfirmPassword.text?.isEmpty == true {
                showAlert(title: helper.shared.APP_ALERT_TITLE_OOPS, message: "All text field are required", viewController: root)
                
            }else if password_text.text == ConfirmPassword.text{
                //api call here
                signup.getNewUser(userID: helper.shared.randomUserId(), firstname: firstName.text!, lastname: lastName.text!, email: Email.text!, lastlogin: df.string(from: Date()) , registerdate: df.string(from: Date()), role: "customer", password: password_text.text!)
            }else{
                showAlert(title: helper.shared.APP_ALERT_TITLE_OOPS, message: "Password is not matched", viewController: root)
            }
        }
    }
    
    @IBOutlet weak var firstName: UITextField! //
    @IBOutlet weak var lastName: UITextField!  //
    @IBOutlet weak var Email: UITextField!     //
    @IBOutlet weak var Phone_txt: UITextField!
    @IBOutlet weak var password_text: UITextField!  //
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var register_btn: UIButton!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
}
