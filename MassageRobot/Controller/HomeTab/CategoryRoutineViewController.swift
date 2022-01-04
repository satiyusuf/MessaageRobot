//
//  CategoryRoutineViewController.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 29/06/21.
//

import UIKit
import IQKeyboardManagerSwift

class CategoryRoutineViewController: UIViewController {

    @IBOutlet weak var txtSearchRoutine: UnderlineTextField!
    @IBOutlet var txtCategoryRoutine: UITextField!
    
    @IBOutlet var constHeightSearch: NSLayoutConstraint!
    
    @IBOutlet var gestureView: UIView!
    
    @IBOutlet var tblCategoryList: UITableView!
    
    @IBOutlet var lblNote: UILabel!
    
    var picker: UIPickerView!
                       
    var strCategoryName: String!
    var strPath: String!
    var strSubCat: String!
    var strSubCatName: String!
    var strSorting: String!
    
    var arrSubCategoryList = [String]()
    var ActivitiSubCateGory = ["Run","Walk","Stairs","Gaming","Driving"]
    var arrSubCategoryRoutineList = [[String: Any]]()
    var arrSubCategoryRoutineSearchList = [[String: Any]]()
    
    var isSearch: Bool = false
    var Count = 0
    var isMore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        txtCategoryRoutine.inputView = picker
        txtCategoryRoutine.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestureView.addGestureRecognizer(tap)
        
        self.tblCategoryList.register(UINib(nibName: "RoutineCatCell", bundle: nil), forCellReuseIdentifier: "RoutineCatCell")
        
        if strPath == "Activities" {
            arrSubCategoryList = ActivitiSubCateGory
        }
        arrSubCategoryList.insert("All", at: 0)
        
        txtCategoryRoutine.text = arrSubCategoryList.first
                        
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        txtCategoryRoutine.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
                                
        if strSubCat == "Yes" {
            constHeightSearch.constant = 52.0
            if txtCategoryRoutine.text == "All" {
                txtCategoryRoutine.text = "All"
                
//                if strPath == "Activities" {
//                    strPath = "activites"
//                }
                self.setListingServiceCall(strCategory: strPath, DataCount: String(Count))
            }
            
            if strPath == "Discover" {
                
            }else if strPath == "Target Areas" {
                
            }else if strPath == "Workout" {
                
            }else if strPath == "Wellness" {
                
            }else if strPath == "Lifestyle" {
                
            }else if strPath == "Browse" {
                
            }else if strPath == "Ailments" {
                
            }else if strPath == "Activites" {
                
            }else if strPath == "Sports" {
                
            }
        }else if strSubCat == "No" {
            constHeightSearch.constant = 0.0
            
            if strPath == "For You" {
                self.setForYouServiceCall()
            }else {
                self.setListingServiceCall(strCategory: strPath, DataCount: String(Count))
            }
        }else {
            txtCategoryRoutine.text = strSubCatName
        }
        
        getSubCategoryListAPI()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("tep Gesture Work")
        txtCategoryRoutine.resignFirstResponder()
        txtSearchRoutine.resignFirstResponder()
        gestureView.isHidden = true
    }
    
    func setListingServiceCall(strCategory: String,DataCount:String) {
          
        strSorting = UserDefaults.standard.object(forKey: SORTING) as? String ?? ""
        
        if strSorting == "" {
            strSorting = "DESC"
        }
        
       
       let strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, u.*, p.thumbnail as userprofile, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = u.userid and f.routineid = r.routineid) as is_favourite from Routine as r left join Userdata as u on r.userid = u.userid left join Userprofile as p on r.userid = p.userid where r.routine_category='\(strCategory.lowercased())' ORDER BY creation \(strSorting ?? "DESC") LIMIT 50 OFFSET \(DataCount)'"
         
        print(strURL)
                        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            
            tblCategoryList.isHidden = true
            
            self.hideLoader()
                      
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                    
                        arrSubCategoryRoutineList.append(contentsOf: jsonArray)
                        if arrSubCategoryRoutineList.count > 0
                        {
                            self.isMore = true
                            for tempDict in arrSubCategoryRoutineList
                            {
                                let rID = tempDict.getString(key: "routineid")
                                self.DurationGet(routinngId: rID)
                            }
                        } else {
                            self.DataEmtyLabelAdd()
                        }
                        
                        if jsonArray.isEmpty == true {
                            self.isMore = false
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
    
    func DataEmtyLabelAdd() {
        if arrSubCategoryRoutineList.isEmpty == true {
            let label = UILabel()
            label.frame = CGRect.init(x: view.frame.width/2 - 75, y: view.frame.height/2, width:150, height: 40)
            label.text = "Data Not Found"
            label.font = UIFont(name: "futura", size: 18)
            label.textColor = .black
            view.addSubview(label)
        }
    }
    
    func setForYouServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? "9ccx8ms5pc0000000000"
        
        let param: [String: Any] = [
            "user_id": userID
        ]
        
        callAPIRawDataCall("https://massage-robotics-website.uc.r.appspot.com/get-recommendations", parameter: param, isWithLoading: true, isNeedHeader: false, methods: .post) { (json, data1) in
            
            print(json)
            if json.getInt(key: "status_code") == 200 {
                let authData = json.getArrayofDictionary(key: "recommendations")
                print("Routine Count \(authData)")
                
                self.arrSubCategoryRoutineList.removeAll()
                self.tblCategoryList.isHidden = true
                
                self.arrSubCategoryRoutineList.append(contentsOf: authData)
                self.tblCategoryList.reloadData()
            }
        }
    }
    
    func getSubCategoryListAPI() {
               
        strSorting = UserDefaults.standard.object(forKey: SORTING) as? String ?? ""
        
        if strSorting == "" {
            strSorting = "DESC"
        }
        
        arrSubCategoryRoutineList.removeAll()
        tblCategoryList.isHidden = true
        
        var strURL = String()
        
        if self.txtCategoryRoutine.text == "All" {
            
            strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, u.*, p.thumbnail as userprofile, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = u.userid and f.routineid = r.routineid) as is_favourite from Routine as r left join Userdata as u on r.userid = u.userid left join Userprofile as p on r.userid = p.userid where r.routine_category='\(strCategoryName.lowercased() )' ORDER BY creation \(strSorting ?? "DESC") LIMIT 10 OFFSET 0'"
            
        } else {
            strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, u.*, p.thumbnail as userprofile, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = u.userid and f.routineid = r.routineid) as is_favourite from Routine as r left join Userdata as u on r.userid = u.userid left join Userprofile as p on r.userid = p.userid where r.routine_category='\(strCategoryName.lowercased() )' AND r.routine_subcategory='\(txtCategoryRoutine.text?.lowercased() ?? "")' ORDER BY creation \(strSorting ?? "DESC") LIMIT 10 OFFSET 0'"
        }
        
        
            
        print(strURL)
        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            self.hideLoading()
            if json.getString(key: "status") == "false"
            {
                self.hideLoading()
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        arrSubCategoryRoutineList.append(contentsOf: jsonArray)
                        tblCategoryList.isHidden = false
                    } else {
                        showToast(message: "Bad Json")
                    }
                    
                    tblCategoryList.reloadData()
                } catch let error as NSError {
                    print(error)
                    showToast(message: json.getString(key: "response_message"))
                }
            }
        }
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
                    tblCategoryList.isHidden = false
                    tblCategoryList.reloadData()
                }
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        
                        print("\(json) === \(jsonArray)")
                        
                    for (index,tempDict) in arrSubCategoryRoutineList.enumerated()
                    {
                        let rID = tempDict.getString(key: "routineid")
                        if jsonArray.count > 0
                        {
                            if rID == jsonArray[0].getString(key: "routineid")
                            {
                                var dict = tempDict
                                dict["duration"] = jsonArray[0].getString(key: "tot")
                                print("For you \(rID) --> \(dict["duration"])" )
                                arrSubCategoryRoutineList.remove(at: index)
                                arrSubCategoryRoutineList.insert(dict, at: index)
                                print(dict)
                            }
                        }
                        else
                        {
                            var dict = tempDict
                            dict["duration"] = "0"
                            print("For you \(rID) -0-> \(dict["duration"])" )
                            arrSubCategoryRoutineList.remove(at: index)
                            arrSubCategoryRoutineList.insert(dict, at: index)
                            print(dict)
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
    
    @IBAction func onClickCloseBtn(_ sender: Any) {
        self.removeSearchData()
    }
    
    @IBAction func onClickCancelBtn(_ sender: Any) {
        self.removeSearchData()
    }
    
    func removeSearchData() {
        if isSearch == true || txtSearchRoutine.text != "" {
            txtSearchRoutine.text = ""
            isSearch = false
            tblCategoryList.isHidden = false
            tblCategoryList.reloadData()
        }
    }
    
    @IBAction func onClickSortingBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SortingVC") as! SortingVC
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension CategoryRoutineViewController: UITableViewDelegate, UITableViewDataSource, RoutineCatCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch == true {
            return arrSubCategoryRoutineSearchList.count
        }else {
            return arrSubCategoryRoutineList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCatCell", for: indexPath) as! RoutineCatCell
        cell.delegate = self
        cell.intIndex = indexPath.row
        
       
        if UIDevice.current.userInterfaceIdiom == .pad {
            let width = view.frame.width / 2
            cell.ImageWidth.constant = width
        }
//
        
        if isSearch == true {
            if arrSubCategoryRoutineSearchList.count > 0 {
                let routingData = arrSubCategoryRoutineSearchList[indexPath.row]
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
                
            }
        }else {
            if arrSubCategoryRoutineList.count > 0 {
                let routingData = arrSubCategoryRoutineList[indexPath.row]
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
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 110
        } else {
            return 170
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        
        if isSearch == true {
            if arrSubCategoryRoutineSearchList.count > 49 {
                if isMore == true {
                    if indexPath.row == self.arrSubCategoryRoutineSearchList.count - 1 {
                        Count += 50
                        self.setListingServiceCall(strCategory: strPath, DataCount: String(Count))
                    }
                }
            }
           
        } else {
            if isMore == true {
                if arrSubCategoryRoutineList.count > 49 {
                    if indexPath.row == self.arrSubCategoryRoutineList.count - 1 {
                        Count += 50
                        self.setListingServiceCall(strCategory: strPath, DataCount: String(Count))
                    }
                }
            }
        }
    }
    
    func onClickRoutineDetailOpen(index: NSInteger) {
        let routingData = arrSubCategoryRoutineList[index]
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
        vc.strRoutingID = routingData.getString(key: "routineid")
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension CategoryRoutineViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrSubCategoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrSubCategoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtCategoryRoutine.text = arrSubCategoryList[row]
        txtCategoryRoutine.tag = row
    }
    
}

extension CategoryRoutineViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtSearchRoutine {
            txtSearchRoutine.resignFirstResponder()
            return true
        }else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
                    
        gestureView.isHidden = false
                
        if textField == txtCategoryRoutine {
            txtCategoryRoutine.text = arrSubCategoryList[textField.tag]
            picker.selectRow(txtCategoryRoutine.tag, inComponent: 0, animated: true)
            picker.reloadAllComponents()
        }else if textField == txtSearchRoutine {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        gestureView.isHidden = true
        
        if textField.text == "All" {
            self.setListingServiceCall(strCategory: strPath, DataCount: String(Count))
        }else if textField == txtSearchRoutine {
            print("Search data")
            
            if txtSearchRoutine.text != "" {
                arrSubCategoryRoutineSearchList.removeAll()
                
                arrSubCategoryRoutineSearchList = arrSubCategoryRoutineList.filter { NSPredicate(format: "(routinename contains[c] %@)", txtSearchRoutine.text ?? "r").evaluate(with: $0) }

                print("daa????>>>>> \(arrSubCategoryRoutineSearchList)")

                isSearch = true
                
                if arrSubCategoryRoutineSearchList.count == 0 {
                    lblNote.isHidden = false
                    tblCategoryList.isHidden = true
                }else {
                    tblCategoryList.reloadData()
                }
            }
         
//            _ = arrSubCategoryRoutineList.filter{
//                let string = $0["routinename"] as! String
//                print("TEst Seda>>>> \(string.hasPrefix("tes"))")
//
//                return string.hasPrefix("tes")
//            }
        }else {
            self.getSubCategoryListAPI()
        }
    }
}

