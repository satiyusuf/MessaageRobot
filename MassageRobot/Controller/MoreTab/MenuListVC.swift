//
//  MenuListVC.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 07/07/21.
//

import UIKit

class MenuListVC: UIViewController {

    @IBOutlet weak var tblMenuList: UITableView!
    
    let arrMenuList = ["My Profile", "My Preference", "Add New Routine","I'm Feeling Lucky","Contact Us", "Gallery", "Investors", "FAQ", "Calibration","Reset", "Logout"]
    let menuItemIcon = ["MyProfile","MyPreference","AddNewRoutine","AddNewRoutine","ContactUs","Gallery","Investors","FAQ","CalibrationANdReset","CalibrationANdReset","Logout"]
    
    var MyProfileIs = false
    var MyPreferenceIs = false
    var Duraction = Int()
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    let myGroup = DispatchGroup()
    let dispatchQueue = DispatchQueue.global(qos: .default)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        UserDefaults.standard.set("", forKey: strQue1)
        UserDefaults.standard.set("", forKey: strQue2)
        UserDefaults.standard.set("", forKey: strQue3)
        UserDefaults.standard.set("", forKey: strQue4)
        UserDefaults.standard.set("", forKey: strQue5)
        UserDefaults.standard.set("", forKey: strQue6)
        UserDefaults.standard.set("", forKey: strQue7)
        UserDefaults.standard.set("", forKey: strQue8)
        UserDefaults.standard.set("", forKey: strQue9)
        UserDefaults.standard.set("", forKey: strQue10)
        UserDefaults.standard.set("", forKey: strQue11)
        UserDefaults.standard.set("", forKey: strQue12)
        UserDefaults.standard.set("", forKey: strQue13)
        UserDefaults.standard.set("", forKey: strQue14)
        UserDefaults.standard.set("", forKey: strQue15)
        UserDefaults.standard.set("", forKey: strQue16)
        UserDefaults.standard.set("", forKey: strQue17)
        UserDefaults.standard.set("", forKey: strQue18)
        UserDefaults.standard.set("", forKey: strQue19)
                
        self.tblMenuList.register(UINib(nibName: "MenuListCell", bundle: nil), forCellReuseIdentifier: "MenuListCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.GetUserProfile()
        self.GetUserPreference()
    }
    
    func resetServiceCall() {
                
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=reset"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        callAPI(url: encodedUrl, param: [:], method: .post) {_,_ in
            self.hideLoading()
        }
    }
}

extension MenuListVC : UITableViewDataSource, UITableViewDelegate, MenuListCellDelegate {
    //MARK:- Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuListCell = self.tblMenuList.dequeueReusableCell(withIdentifier: "MenuListCell") as! MenuListCell

        cell.lblMenuName.text = arrMenuList[indexPath.row]
        cell.imgIcon.image = UIImage(named: menuItemIcon[indexPath.row])
        
        cell.delegate = self
        cell.intIndex = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select cell")
    }
    func onClickOpenMenuOPT(index: NSInteger) {
        
        let isLogin = UserDefaults.standard.object(forKey: ISLOGIN) as? String ?? "No"
        
        if isLogin == "No" {
            UserDefaults.standard.set("Yes", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
            
            return
        }
        
        if index == 0 {
            print("Profile")
            let myProfileInfo = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
            myProfileInfo.strPath = "Menu"
            self.navigationController?.pushViewController(myProfileInfo, animated: true)
        }else if index == 1 {
            print("My prference")
            let MyPreference = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MyPreferenceVC") as! MyPreferenceVC
            self.navigationController?.pushViewController(MyPreference, animated: true)
        }else if index == 2 {
            
            if MyPreferenceIs == true && MyProfileIs == true {
                
                let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "RoutineDetail") as! RoutineDetailViewController
                navigationController?.pushViewController(vc, animated: false)
            } else if MyPreferenceIs == false {
                showToast(message: "Please Add My Profile And My Prference First After That You able to Create a Routin")
            } else if MyProfileIs == false {
                showToast(message: "Please Add My Profile And My Prference First After That You able to Create a Routin")
            }
            
        } else if index == 3 {
            
            
           
            picker = UIPickerView(frame: CGRect(x: 0, y: self.view.frame.size.height - 300, width: self.view.frame.size.width, height: 300))
            picker.delegate = self
            picker.dataSource = self
            picker.backgroundColor = UIColor.lightGray
            picker.setValue(UIColor.black, forKey: "textColor")

            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelButton))

            
            toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height - 300 - 44, width: picker.frame.width, height: 44))
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.isUserInteractionEnabled = true
            toolBar.items = [cancelButton,spaceButton,doneButton]
            self.view.addSubview(toolBar)
            self.view.addSubview(picker)
            
        } else if index == 8 {
            print("Calibration")
            let calibrationView = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "CalibrationView") as! CalibrationViewController
            self.navigationController?.pushViewController(calibrationView, animated: true)
        }else if index == 9 {
            self.resetServiceCall()
        }else if index == 10 {
            UserDefaults.standard.set("No", forKey: ISLOGIN)
            let vc = UIStoryboard.init(name: "CreateToutine", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension MenuListVC
{
    func GetUserProfile() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Userprofile where userid='\(userID)''"
                    
            print(url)
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                self.hideLoading()
                if json.getString(key: "status") == "false" {
                    
                    let string = json.getString(key: "response_message")
                    let data = string.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                        {
                            if jsonArray.count > 0{
                                self.MyProfileIs = true
                            }else {
                                self.MyProfileIs = false
                            }
                
                        } else {
                            showToast(message: "Add You Profile")
                            showToast(message: "Bad Json")
                        }
                    } catch let error as NSError {
                        showToast(message: "Add You Profile")
                        print(error)
                    }
                }
            }
        }
    }
    func GetUserPreference() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from userpreference where userid='\(userID)''"
                    
            print(url)
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                self.hideLoading()
                if json.getString(key: "status") == "false" {
                    
                    let string = json.getString(key: "response_message")
                    let data = string.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                        {
                            if jsonArray.count > 0{
                                self.MyPreferenceIs = true
                            }else {
                                self.MyPreferenceIs = false
                            }
                
                        } else {
                            showToast(message: "Add You Profile")
                            showToast(message: "Bad Json")
                        }
                    } catch let error as NSError {
                        showToast(message: "Add You Profile")
                        print(error)
                    }
                }
            }
        }
    }
}

//MARK:- PickerView Method
extension MenuListVC: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 45
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 15)"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.Duraction = row + 15
    }
   
   @objc func donePicker() {
       toolBar.removeFromSuperview()
       picker.removeFromSuperview()
       self.RoutineCreate()
    }
    @objc func cancelButton() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
     }
}

//MARK:- Feeling Lucky Some Private Function
extension MenuListVC {

    private func RoutineCreate(){

        var arrUser = ["adult","athlete","geriatric", "pregnant", "youth"]
        let UserRondomNumder = Int(arc4random_uniform(5))
        let User = arrUser[UserRondomNumder]
        
        var arrType = ["cranial sacral therapy", "deep tissue massage", "geriatric massage", "prenatal massage", "reflexology", "sports massage", "swedish massage", "percussion massage", "trigger point acupressure"]
        let TypeRondomNumder = Int(arc4random_uniform(9))
        let Type = arrType[TypeRondomNumder]
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""

        let dfPass = DateFormatter()
        dfPass.dateFormat = "yyyy-MM-dd HH:mm"

        let Count = +1

        let strRoutingID = randomRoutineId()

        let url = """
        https://massage-robotics-website.uc.r.appspot.com/wt?tablename=Routine&row=[('\(strRoutingID)',
        '\(userID)',
        '\(dfPass.string(from: Date()))',
        'public',
        'alex\(Count)',
        '',
        '\(dfPass.string(from: Date()))',
        '5',
        '2',
        'best and good',
        '',
        '',
        'ailments',
        '\(Type)',
        '\(User)',
        '',
        '',
        'muscle cramps')]
        """
        print(url)

        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        callAPI(url: encodedUrl!) { [self] (json, data) in
            print(json)
            self.hideLoading()
            if json.getString(key: "Response") == "Success" {
               
                let Location = Int(arc4random_uniform(6) + 1)
                var BodyFrontBack = String()
                if Location % 2 == 0 {
                    BodyFrontBack = "F"
                } else {
                    BodyFrontBack = "B"
                }
                
                let Minute = Int.random(in: 3..<6)
                var SegmentCount = Duraction / Minute
                let Value = Minute * SegmentCount
                let Makeup = Duraction - Value
                
                if Value == Duraction {
                    print("Minute:- \(Minute) , Makeup:-\(Makeup) , SegmentCount:- \(SegmentCount)")
                } else {
                    SegmentCount = SegmentCount + 1
                    print("Minute:- \(Minute) , Makeup:-\(Makeup) , SegmentCount:- \(SegmentCount)")
                }
                
                for index in 0..<SegmentCount {
                    
                    if Makeup == 0 {
                        myGroup.enter()
                
                        self.CreateSegmentApiCAll(BodyFrontBack: BodyFrontBack, Time: Minute, RoutingID: strRoutingID, SegmentCount: SegmentCount, index: index)
                        
                       
                    } else {
                        if index == 0 {
                            myGroup.enter()
                            self.CreateSegmentApiCAll(BodyFrontBack: BodyFrontBack, Time: Makeup, RoutingID: strRoutingID, SegmentCount: SegmentCount, index: index)
                            
                        } else {
                            myGroup.enter()
                            self.CreateSegmentApiCAll(BodyFrontBack: BodyFrontBack, Time: Minute, RoutingID: strRoutingID, SegmentCount: SegmentCount, index: index)
                        }
                    }
                }
            }
        }
    }
    
    private func CreateSegmentApiCAll(BodyFrontBack:String,Time:Int,RoutingID:String,SegmentCount:Int,index:Int)
    {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let datetime = formatter.string(from: now)
        print(datetime)
        let timeAndDate = datetime.components(separatedBy: " ")

        let strDateC: String = String(format: "%@", timeAndDate[0])
        let strTimeC: String = String(format: "%@", timeAndDate[1])
        
        
        let arrPath = ["none", "linear", "circular", "random", "point"]
        let arrTool = ["none", "omni", "inline", "point", "shiatsu","sport","precussion","vibration"]
        let PathRandom = Int(arc4random_uniform(5))
        let Path = arrPath[PathRandom]
        let ToolRandom = Int(arc4random_uniform(8))
        let Tool = arrTool[ToolRandom]
        let Speed = Int(arc4random_uniform(100) + 1)
        let Force = Int(arc4random_uniform(100) + 1)
       
        var Location = String()
        if BodyFrontBack == "F" {
            let arrFrontLocation = ["pectoralis","iliotibal tract","quadracepts","knee","tibalis anterior"]
            let FrontRandom = Int(arc4random_uniform(5))
            Location = arrFrontLocation[FrontRandom]
        } else {
            let arrBackLocation  = ["deltoid","upperback","lowerback","gastrocnemius","hamstring","glutiusmaximus"]
            let BackRandom = Int(arc4random_uniform(6))
            Location = arrBackLocation[BackRandom]
        }

       
        let strTime = Time * 60
            
        let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=RoutineEntity&row=[('sagmet\(randomSegmentId())','\(strTime)','\(Force)','\(Force)','\(Location)','\(Location)','\(Path)','\(Path)','\(Speed)','\(Speed)','\(strDateC),\(strTimeC)','\(Tool)','\(Tool)','\(index + 1)','\(RoutingID)','\(BodyFrontBack)')]"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            self.hideLoading()
            if json.getString(key: "Response") == "Success"
            {
                print("index:-\(index)")
                if index + 1 == SegmentCount {
                    let alert = UIAlertController(title: "Successfully", message: "Your Routine Created Successfully ", preferredStyle: UIAlertController.Style.alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                       
                        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
                        vc.strRoutingID = RoutingID
                        navigationController?.pushViewController(vc, animated: false)
                    })
                     alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                myGroup.leave()
            }
        }
    }
 }
