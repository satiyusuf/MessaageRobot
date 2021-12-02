//
//  SearchDataVC.swift
//  MassageRobot
//
//  Created by Empyreal Infotech on 30/11/21.
//

import UIKit

class SearchDataVC: UIViewController {

    //MARK:- Outlet
    @IBOutlet weak var txtSeach: UnderlineTextField!
    @IBOutlet weak var tblList: UITableView!
    
    //MARK:- Variable
    var arrData = [[String: Any]]()
    var arrSearchData = [[String: Any]]()
    //MARK:- FilterDataPass Variable
    var QueryUrl = String()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.GetFilterData()
        self.tblList.register(UINib(nibName: "RoutineCatCell", bundle: nil), forCellReuseIdentifier: "RoutineCatCell")
        self.txtSeach.delegate = self
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        let isLogin = UserDefaults.standard.object(forKey: ISLOGIN) as? String ?? "No"
        if isLogin == "No" {
            UserDefaults.standard.set("Yes", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
            return
        }
    }
    
    //MARK:- Action
    @IBAction func btnCencel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClose(_ sender: Any) {
    }
}

extension SearchDataVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCatCell", for: indexPath) as! RoutineCatCell

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
    }
}

extension SearchDataVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtSeach {
            txtSeach.resignFirstResponder()
            return true
        }else {
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print(textField.text!)
        let predicate = NSPredicate(format: "SELF contains %@", textField.text!)
        let arr = arrData.filter { predicate.evaluate(with: $0) }
  
        if arr.count > 0
        {
            self.arrSearchData.removeAll()
            self.arrSearchData = arr
        }
        else
        {
            self.arrSearchData = arrData
        }
        self.tblList.reloadData()
        return true
    }
}

//MARK:- Private Function Api Call

extension SearchDataVC {
    
    func GetFilterData() {

        print(QueryUrl)

        let encodedUrl = QueryUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)

            self.arrSearchData.removeAll()
            self.arrData.removeAll()

            self.hideLoader()

            if json.getString(key: "status") == "false" {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        self.arrData.append(contentsOf: jsonArray)
                        self.arrSearchData.append(contentsOf: jsonArray)

                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                    showToast(message: json.getString(key: "response_message"))
                }
            }
        }
    }
}
