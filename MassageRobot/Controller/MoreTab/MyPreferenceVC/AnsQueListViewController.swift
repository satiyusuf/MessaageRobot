//
//  AnsQueListViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 16/03/21.
//

import UIKit

class AnsQueListViewController: UIViewController {

    @IBOutlet weak var tblAnsQueList: UITableView!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblFName: UILabel!
    
    var dictLocalStore = [String: AnyObject]()
    var queAnsList = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        lblEmail.text = UserDefaults.standard.object(forKey: EMAILID) as? String ?? ""
        
        let FName = UserDefaults.standard.object(forKey: FIRSTNAME) as? String ?? ""
        lblFName.text = "Welcome " + FName
        
        self.tblAnsQueList.register(UINib(nibName: "AnsQueCell", bundle: nil), forCellReuseIdentifier: "AnsQueCell")
        
        tblAnsQueList.estimatedRowHeight = 80
        tblAnsQueList.rowHeight = UITableView.automaticDimension
        
        //self.setMyPreferenceAnsQueListServiceCall()
    }
    
    func setMyPreferenceAnsQueListServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from userpreference WHERE userid='\(userID)''"
            
            print(url)
            
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                self.hideLoading()
                if json.getString(key: "status") == "false"
                {
                    let string = json.getString(key: "response_message")
                    let data = string.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                                                                                    
                            if jsonArray.count > 0 {
                                queAnsList.append(contentsOf: jsonArray)
                            }else {
                                showToast(message: "Data is blank")
                            }
                            tblAnsQueList.reloadData()
                        } else {
                            showToast(message: "Bad Json")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
    }
    
    @IBAction func btnBackToMenuAction(_ sender: UIButton) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    @IBAction func btnUpdateProfileAction(_ sender: UIButton) {
        let myProfileInfo = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        myProfileInfo.strPath = "AnsList"
        self.navigationController?.pushViewController(myProfileInfo, animated: true)
    }
}

//MARK:- Tableview Delegate Datasource
extension AnsQueListViewController : UITableViewDelegate, UITableViewDataSource {
         
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queAnsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let queAnsCell = tableView.dequeueReusableCell(withIdentifier: "AnsQueCell") as! AnsQueCell
        
        queAnsCell.selectionStyle = .none
        
        let queAndDataList = queAnsList[indexPath.row]
        
        queAnsCell.lblQue.text = queAndDataList.getDictionary(key: "QueAns").getString(key: "Que")
        queAnsCell.lblAns.text = "Answer : " + queAndDataList.getDictionary(key: "QueAns").getString(key: "Ans")
//
//        notiCell.lblTitle.text = notificationList.getString(key: "title")
//        notiCell.lblDescription.text = notificationList.getString(key: "description")
//
//        let fullDate = notificationList.getString(key: "dt_created")
//
//        let strTimeGet = fullDate.components(separatedBy: "-")
//
//        notiCell.lblDateTime.text = strTimeGet[0] + "\n" + strTimeGet[1]
        
        return queAnsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblAnsQueList.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
