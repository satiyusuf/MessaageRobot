//
//  MenuListVC.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 07/07/21.
//

import UIKit

class MenuListVC: UIViewController {

    @IBOutlet weak var tblMenuList: UITableView!
    
    let arrMenuList = ["My Profile", "My Preference", "Add New Routine", "Contact Us", "Gallery", "Investors", "FAQ", "Calibration","Reset", "Logout"]
    let menuItemIcon = ["MyProfile","MyPreference","AddNewRoutine","ContactUs","Gallery","Investors","FAQ","CalibrationANdReset","CalibrationANdReset","Logout"]
    
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
        return 10
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
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetail") as! RoutineDetailViewController
            navigationController?.pushViewController(vc, animated: false)
        }else if index == 7 {
            print("Calibration")
            let calibrationView = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "CalibrationView") as! CalibrationViewController
            self.navigationController?.pushViewController(calibrationView, animated: true)
        }else if index == 8 {
            self.resetServiceCall()
        }else if index == 9 {
            UserDefaults.standard.set("No", forKey: ISLOGIN)
            let vc = UIStoryboard.init(name: "CreateToutine", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
