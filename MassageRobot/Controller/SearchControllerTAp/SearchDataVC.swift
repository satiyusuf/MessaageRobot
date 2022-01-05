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
        self.txtSeach.text = ""
        self.arrSearchData = arrData
        self.tblList.reloadData()
    }
}

extension SearchDataVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrSearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCatCell", for: indexPath) as! RoutineCatCell

        if UIDevice.current.userInterfaceIdiom == .pad {
            let width = view.frame.width / 2
            cell.ImageWidth.constant = width
        }
        
        let routingData = arrSearchData[indexPath.row]
        cell.lblRoutineName.text = routingData.getString(key: "routinename")
        cell.lblCategory.text = routingData.getString(key: "routine_category")
        cell.lblRLocation.text = routingData.getString(key: "routine_type")
        cell.lblLLocation.text = routingData.getString(key: "user_type")

        let time = routingData.getString(key: "duration")
        cell.lblRoutineTime.text = "0 Min"
        if time != ""
        {
            let min = Int(time)! / 60
            cell.lblRoutineTime.text = "\(min) Min"
        }
        
        if routingData.getString(key: "thumbnail") != "" {
            let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + routingData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
            let urls = URL.init(string: strURLThumb)
            cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon"))
        }else {
            cell.imgBannarPic.image = UIImage(named: "DefaultIcon")
        }
        
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
        let searchText  = textField.text! + string
        
        print(searchText)
        let predicate = NSPredicate(format: "routinename contains %@", searchText)
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
                        
                        if self.arrData.count > 0 && self.arrSearchData.count > 0 {
                            for tempDict in arrData
                            {
                                let rID = tempDict.getString(key: "routineid")
                                self.DurationGet(routinngId: rID)
                            }
                        } else {
                            self.DataEmtyLabelAdd()
                        }
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
    func DataEmtyLabelAdd() {
            let label = UILabel()
            label.frame = CGRect.init(x: view.frame.width/2 - 75, y: view.frame.height/2, width:150, height: 40)
            label.text = "Data Not Found"
            label.font = UIFont(name: "futura", size: 18)
            label.textColor = .black
            view.addSubview(label)
    }
    
    func DurationGet(routinngId:String)
    {
        let strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity WHERE routineid='\(routinngId)' GROUP BY routineid'"
        
        print(strURL)
        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            
            if json.getString(key: "status") == "false"
            {
                defer {
                    self.tblList.reloadData()
                }
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        
                        print("\(json) === \(jsonArray)")
                        
                    for (index,tempDict) in arrData.enumerated()
                    {
                        let rID = tempDict.getString(key: "routineid")
                        if jsonArray.count > 0
                        {
                            if rID == jsonArray[0].getString(key: "routineid")
                            {
                                var dict = tempDict
                                dict["duration"] = jsonArray[0].getString(key: "tot")
                                arrData.remove(at: index)
                                arrData.insert(dict, at: index)
                                arrSearchData.remove(at: index)
                                arrSearchData.insert(dict, at: index)
                            }
                        }
                        else
                        {
                            var dict = tempDict
                            dict["duration"] = "0"
                            arrData.remove(at: index)
                            arrData.insert(dict, at: index)
                            arrSearchData.remove(at: index)
                            arrSearchData.insert(dict, at: index)
                        }
                    }
                  }
                } catch let error as NSError {
                    print(error)
                    showToast(message: json.getString(key: "response_message"))
                }
            }
        }
    }
}
