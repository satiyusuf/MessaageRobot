//
//  MyPreferenceVC.swift
//  MassageRobot
//
//  Created by Sumit Sharma on 07/02/21.
//

import UIKit

class MyPreferenceVC: UIViewController {
    
    //MARK:- Class Outlet
    @IBOutlet weak var previousandNextView: UIView!
    @IBOutlet weak var progressandCount: UIView!
    @IBOutlet weak var countText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var collectionObj: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var txvDetail: UITextView!
    
    @IBOutlet weak var topScreen_constrnt: NSLayoutConstraint!
    
    //MARK:- Class Variable
    var currentIndexpath  = IndexPath(row: 0, section: 0)
    var currentIndexVal : Int = 0
    
    var isSubmitQue: Bool = false
    
    var questionaryFile = [[String: Any]]()
    var queAnsArray = [[String: Any]]()
    var localQueAndList = [[String: Any]]()
    var QueAnsList = [String]()
    var strQueAnsList: String = ""
    var staticpickervalue = ["Monthly", "Weekly", "Daily"]
                
    var dictLocalStore = [String: AnyObject]()
    var dictPassAPIStore = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        localQueAndList.removeAll()

        ViewTop_UPRadius(value: 10, outlet: self.progressandCount )
        ViewBottom_DownRadius(value: 10, outlet: self.previousandNextView )
        
        borderBtn(value: 10, outlet:self.previewBtn )
        borderBtn(value: 10, outlet:self.nextBtn )
        
//        let deviceHeight = UIScreen.main.nativeBounds.height
//
//        if deviceHeight <= 1334.0{
//            self.topScreen_constrnt.constant = 20.0
//        }else{
//            self.topScreen_constrnt.constant = 62.0
//        }
        
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        BackView.addGestureRecognizer(tap)
        self.setUserPreferenceQuestionService()
        
        getUserPreferenceQuestionAnswerData()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        BackView.isHidden = true
        
        UserDefaults.standard.set("", forKey: QueAns)
        
        if txvDetail.text != "" {
            UserDefaults.standard.set(txvDetail.text, forKey: QueAns)
        }else {
            UserDefaults.standard.set("Yes", forKey: QueAns)
        }
    }
    
    func setUserPreferenceQuestionService() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from userpreferencequestion'"
            
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
                            questionaryFile.append(contentsOf: jsonArray)
                            
                            self.countText.text = "1 / \(questionaryFile.count)"
                            progressBar.progress = Float(Float(1)/Float(questionaryFile.count))
                            
                            collectionObj.reloadData()
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
    
    func getUserPreferenceQuestionAnswerData() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        if userID != "" {
            //let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from userpreferencequestion'"
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query=\"Select * from userpreference where userid='\(userID)'\""
            
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
                            queAnsArray.append(contentsOf: jsonArray)
                            
                            if queAnsArray.count > 0 {
                                UserDefaults.standard.set("Yes", forKey: ISANSUPLOAD)
                                
                                for (index, element) in queAnsArray.enumerated() {
                                  print("Item \(index): \(element)")
                                    
                                    let ans = element["user_preference_answer"] as? String ?? ""
                                    
                                    let strA = String(format: "%@ : strQue%d",ans, (index+1))
                                    print("\(strA)")
                                    
                                    if element["questionid"] as! Int == 1 {
                                        UserDefaults.standard.set(ans, forKey: strQue1)
                                    }else if element["questionid"] as! Int == 2 {
                                        UserDefaults.standard.set(ans, forKey: strQue2)
                                    }else if element["questionid"] as! Int == 3 {
                                        UserDefaults.standard.set(ans, forKey: strQue3)
                                    }else if element["questionid"] as! Int  == 4 {
                                        UserDefaults.standard.set(ans, forKey: strQue4)
                                    }else if element["questionid"] as! Int == 5 {
                                        UserDefaults.standard.set(ans, forKey: strQue5)
                                    }else if element["questionid"] as! Int == 6 {
                                        UserDefaults.standard.set(ans, forKey: strQue6)
                                    }else if element["questionid"] as! Int == 7 {
                                        UserDefaults.standard.set(ans, forKey: strQue7)
                                    }else if element["questionid"] as! Int == 8 {
                                        UserDefaults.standard.set(ans, forKey: strQue8)
                                    }else if element["questionid"] as! Int == 9 {
                                        UserDefaults.standard.set(ans, forKey: strQue9)
                                    }else if element["questionid"] as! Int == 10 {
                                        UserDefaults.standard.set(ans, forKey: strQue10)
                                    }else if element["questionid"] as! Int == 11 {
                                        UserDefaults.standard.set(ans, forKey: strQue11)
                                    }else if element["questionid"] as! Int == 12 {
                                        UserDefaults.standard.set(ans, forKey: strQue12)
                                    }else if element["questionid"] as! Int == 13 {
                                        UserDefaults.standard.set(ans, forKey: strQue13)
                                    }else if element["questionid"] as! Int == 14 {
                                        UserDefaults.standard.set(ans, forKey: strQue14)
                                    }else if element["questionid"] as! Int == 15 {
                                        UserDefaults.standard.set(ans, forKey: strQue15)
                                    }else if element["questionid"] as! Int == 16 {
                                        UserDefaults.standard.set(ans, forKey: strQue16)
                                    }else if element["questionid"] as! Int == 17 {
                                        UserDefaults.standard.set(ans, forKey: strQue17)
                                    }else if element["questionid"] as! Int == 18 {
                                        UserDefaults.standard.set(ans, forKey: strQue18)
                                    }else if element["questionid"] as! Int == 19 {
                                        UserDefaults.standard.set(ans, forKey: strQue19)
                                    }
                                }
                            }
                            
                           collectionObj.reloadData()
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
    
    @IBAction func backToLast(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- priviewNextAction
    @IBAction func priviewNextAction(_ sender: UIButton) {
        
        let currentPlace = Float(currentIndexpath.row)
        let totalPlace = Float(questionaryFile.count)
        
        print("_____________")
        print(currentPlace + 1.0) //set initial valaue
        print(totalPlace)
        
        if self.currentIndexpath.row  == questionaryFile.count - 1 && sender.tag == 1{
            let questionList = questionaryFile[currentIndexpath.row]
            
            var strAnsQue: String = ""
            
            if currentPlace == 0 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue1) as? String ?? ""
            }else if currentPlace == 1 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue2) as? String ?? ""
            }else if currentPlace == 2 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue3) as? String ?? ""
            }else if currentPlace == 3 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue4) as? String ?? ""
            }else if currentPlace == 4 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue5) as? String ?? ""
            }else if currentPlace == 5 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue6) as? String ?? ""
            }else if currentPlace == 6 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue7) as? String ?? ""
            }else if currentPlace == 7 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue8) as? String ?? ""
            }else if currentPlace == 8 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue9) as? String ?? ""
            }else if currentPlace == 9 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue10) as? String ?? ""
            }else if currentPlace == 10 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue11) as? String ?? ""
            }else if currentPlace == 11 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue12) as? String ?? ""
            }else if currentPlace == 12 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue13) as? String ?? ""
            }else if currentPlace == 13 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue14) as? String ?? ""
            }else if currentPlace == 14 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue15) as? String ?? ""
            }else if currentPlace == 15 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue16) as? String ?? ""
            }else if currentPlace == 16 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue17) as? String ?? ""
            }else if currentPlace == 17 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue18) as? String ?? ""
            }else if currentPlace == 18 {
                strAnsQue = UserDefaults.standard.object(forKey: strQue19) as? String ?? ""
            }
            
//            let strAnsQue: String = UserDefaults.standard.object(forKey: QueAns) as? String ?? ""
            
            isSubmitQue = true
            
            self.setQueAnsServiceCall(strQueID: questionList.getString(key: "questionid"), strAns: strAnsQue)
        }else{
            isSubmitQue = false
            
            if sender.tag == 1 {
                
                let questionList = questionaryFile[currentIndexpath.row]
                
                var strAnsQue: String = ""
                
                if currentPlace == 0 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue1) as? String ?? ""
                }else if currentPlace == 1 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue2) as? String ?? ""
                }else if currentPlace == 2 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue3) as? String ?? ""
                }else if currentPlace == 3 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue4) as? String ?? ""
                }else if currentPlace == 4 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue5) as? String ?? ""
                }else if currentPlace == 5 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue6) as? String ?? ""
                }else if currentPlace == 6 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue7) as? String ?? ""
                }else if currentPlace == 7 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue8) as? String ?? ""
                }else if currentPlace == 8 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue9) as? String ?? ""
                }else if currentPlace == 9 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue10) as? String ?? ""
                }else if currentPlace == 10 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue11) as? String ?? ""
                }else if currentPlace == 11 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue12) as? String ?? ""
                }else if currentPlace == 12 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue13) as? String ?? ""
                }else if currentPlace == 13 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue14) as? String ?? ""
                }else if currentPlace == 14 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue15) as? String ?? ""
                }else if currentPlace == 15 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue16) as? String ?? ""
                }else if currentPlace == 16 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue17) as? String ?? ""
                }else if currentPlace == 17 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue18) as? String ?? ""
                }else if currentPlace == 18 {
                    strAnsQue = UserDefaults.standard.object(forKey: strQue19) as? String ?? ""
                }
//                let strAnsQue: String = UserDefaults.standard.object(forKey: QueAns) as? String ?? ""
                
                self.setQueAnsServiceCall(strQueID: questionList.getString(key: "questionid"), strAns: strAnsQue)
                                
                self.currentIndexpath = IndexPath(row: Int(currentPlace) + 1, section: 0)
                print(currentIndexpath.row)
                
                self.countText.text = "\(currentIndexpath.row + 1) / \(questionaryFile.count)"
                progressBar.progress = Float(Float(currentIndexpath.row + 1)/Float(questionaryFile.count))
                                 
                if currentIndexpath.row + 1 == questionaryFile.count {
                    nextBtn.setTitle("Submit", for: .normal)
                }else {
                    nextBtn.setTitle("Next", for: .normal)
                }
            }else if sender.tag == 0{
                
                if currentPlace == 0 {
                    return
                }
                
                localQueAndList.remove(at: self.currentIndexpath.row - 1)
                
                if self.currentIndexpath.row !=  0 {
                    self.currentIndexpath = IndexPath(row: Int(currentPlace) - 1, section: 0)
                    print(currentIndexpath.row)
                    
                    self.countText.text = "\(currentIndexpath.row + 1) / \(questionaryFile.count)"
                    progressBar.progress = Float(Float(currentIndexpath.row + 1)/Float(questionaryFile.count))
                    
                    nextBtn.setTitle("Next", for: .normal)
                }
            }
        }
        collectionObj.reloadData()
        self.collectionObj.scrollToItem(at: currentIndexpath, at: .left, animated: true)
    }
    
    func setQueAnsDataStoreIntDict(strQue: String, strQueID: String, strAns: String) {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? "9ccx8ms5pc0000000000"
        let strUploadQue: String = UserDefaults.standard.object(forKey: ISANSUPLOAD) as? String ?? ""
        
        dictLocalStore["QueAns"] = ["Que": strQue, "QueID": strQueID, "Ans": strAns] as AnyObject
        
        if strUploadQue != "Yes" {
            
            let strAnsQueValue: String = "('\(userID)','\(strQueID)','\(strAns)')"
            
            if localQueAndList.count == 0 {
                strQueAnsList = strAnsQueValue.replacingOccurrences(of: "\"", with: "")
            }else {
                strQueAnsList = strQueAnsList + "," + strAnsQueValue.replacingOccurrences(of: "\"", with: "")
            }
        }
    
        localQueAndList.append(dictLocalStore)
    }
    
    func setQueAnsServiceCall(strQueID: String, strAns:String) {
        
        let strUploadQue: String = UserDefaults.standard.object(forKey: ISANSUPLOAD) as? String ?? ""
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        //let strAnsQue: String = UserDefaults.standard.object(forKey: QueAns) as? String ?? ""
        
        let questionList = questionaryFile[currentIndexpath.row]
        
        if strUploadQue == "Yes" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='UPDATE userpreference SET user_preference_answer='\(strAns)' where questionid='\(strQueID)' and userid='\(userID)''"
                 
            print(url)
            
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                self.hideLoading()
                if json.getString(key: "Response") == "UPDATE query executed Successfully" {
                    self.setQueAnsDataStoreIntDict(strQue: questionList.getString(key: "preferencequestion"), strQueID: questionList.getString(key: "questionid"), strAns: strAns)
                }
                
                showToast(message: json.getString(key: "Response"))
                
                if isSubmitQue == true {
                    let sb = UIStoryboard(name: "Menu", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "AnsQueListView") as! AnsQueListViewController
                    vc.queAnsList.removeAll()
                    vc.queAnsList.append(contentsOf: localQueAndList)
                    navigationController?.pushViewController(vc, animated: false)
                }
            }
        }else {
            
            self.setQueAnsDataStoreIntDict(strQue: questionList.getString(key: "preferencequestion"), strQueID: questionList.getString(key: "questionid"), strAns: strAns)
            
            if isSubmitQue == true {
                
                let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=userpreference&row=[\(strQueAnsList)]"
                
    //            let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=userpreference&row=[('\(userID)','\(strQueID)','\(strAns)')]"
                print(url)
                
                let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                callAPI(url: encodedUrl!) { [self] (json, data1) in
                    print(json)
                    self.hideLoading()
                    
                    if json.getString(key: "Response").lowercased() != "entered data is not as per the table schema" {
                        let sb = UIStoryboard(name: "Menu", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "AnsQueListView") as! AnsQueListViewController
                        vc.queAnsList.removeAll()
                        vc.queAnsList.append(contentsOf: localQueAndList)
                        navigationController?.pushViewController(vc, animated: false)
                    }
                                     
                    showToast(message: json.getString(key: "Response"))
                }
            }
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        self.BackView.isHidden = true
        UserDefaults.standard.set("", forKey: QueAns)
        
        if txvDetail.text != "" {
            UserDefaults.standard.set(txvDetail.text, forKey: QueAns)
        }else {
            UserDefaults.standard.set("Yes", forKey: QueAns)
        }
    }
}

extension MyPreferenceVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyPreferenceCollectioncellDelegate {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return questionaryFile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyPreferenceCollectioncell
        let questionList = questionaryFile[indexPath.row]
        cell.questionaryText.text = questionList.getString(key: "preferencequestion")
        self.currentIndexVal = indexPath.row
        print(self.currentIndexVal)
        
        cell.delegate = self
        //cell.rangeSelectedbutton.tag = indexPath.section
        cell.pickerview.tag = indexPath.section
        cell.currentIndex = indexPath.row
        cell.staticpickervalue = staticpickervalue//[currentIndexpath.row]
        
        cell.updateView()
        
//        borderBtn(value: 5, outlet:cell.rangeSelectedbutton)
//        borderColor(value: 1.5, outlet: cell.rangeSelectedbutton)
        
        print("CurrentIndex>>>> \(indexPath.row)")
        
        if indexPath.row == 0 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue1) as? String ?? ""
        }else if indexPath.row == 1 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue2) as? String ?? ""
        }else if indexPath.row == 2 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue3) as? String ?? ""
        }else if indexPath.row == 3 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue4) as? String ?? ""
        }else if indexPath.row == 4 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue5) as? String ?? ""
        }else if indexPath.row == 5 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue6) as? String ?? ""
        }else if indexPath.row == 6 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue7) as? String ?? ""
        }else if indexPath.row == 7 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue8) as? String ?? ""
        }else if indexPath.row == 8 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue9) as? String ?? ""
        }else if indexPath.row == 9 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue10) as? String ?? ""
        }else if indexPath.row == 10 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue11) as? String ?? ""
        }else if indexPath.row == 11 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue12) as? String ?? ""
        }else if indexPath.row == 12 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue13) as? String ?? ""
        }else if indexPath.row == 13 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue14) as? String ?? ""
        }else if indexPath.row == 14 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue15) as? String ?? ""
        }else if indexPath.row == 15 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue16) as? String ?? ""
        }else if indexPath.row == 16 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue17) as? String ?? ""
        }else if indexPath.row == 17 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue18) as? String ?? ""
        }else if indexPath.row == 18 {
            cell.txtSelectAns.text = UserDefaults.standard.object(forKey: strQue19) as? String ?? ""
        }
        //design only for pickerview
        
        return cell
        
    }
    
    func designview(dcell : MyPreferenceCollectioncell)  {
        
        //dcell.pickerview.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return collectionView.frame.size
    }
    
    //[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.theData.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //design
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        progressBar.transform = transform
        progressBar.layer.cornerRadius = 8
        progressBar.clipsToBounds = true
    }
    
    func setUnderDoctor(strAction: String) {
        if strAction == "Yes" {
            self.BackView.isHidden = false
        }else {
            self.BackView.isHidden = true
            UserDefaults.standard.set("", forKey: QueAns)
            UserDefaults.standard.set(strAction, forKey: QueAns)
        }
    }
}

protocol MyPreferenceCollectioncellDelegate {
    func setUnderDoctor(strAction: String)
}

class MyPreferenceCollectioncell : UICollectionViewCell, UITextFieldDelegate  {
    
    var staticpickervalue : [String] = []
    var currentIndex: Int!
    
    var delegate : MyPreferenceCollectioncellDelegate?
    
    var pickerview = UIPickerView()
    
    @IBOutlet var txtSelectAns: UITextField!
    
    @IBOutlet weak var questionaryText: UILabel!
    @IBOutlet weak var viewContainer: UIView!
            
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pickerview.dataSource = self
        pickerview.delegate = self
        
        txtSelectAns.inputView = pickerview
        
        txtSelectAns.delegate = self
        txtSelectAns.text = staticpickervalue.first
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSelectAns.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtSelectAns.text = staticpickervalue[textField.tag]
        pickerview.selectRow(txtSelectAns.tag, inComponent: 0, animated: true)
        pickerview.reloadAllComponents()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if txtSelectAns.text != "" {

        }
    }
    
    func updateView() {
        
        staticpickervalue .removeAll()
        
        if currentIndex == 0 {
            staticpickervalue = ["Monthly", "Weekly", "Daily", "Never", "Holiday", "Gifted"]
        }else if currentIndex == 1 {
            staticpickervalue = ["Upper Body", "Lower Body", "Legs", "Arms"]
        }else if currentIndex == 2 {
            staticpickervalue = ["Good", "Average", "Poor"]
        }else if currentIndex == 3 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 4 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 5 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 6 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 7 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 8 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 9 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 10 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 11 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 12 {
            staticpickervalue = ["Soft", "Hard"]
        }else if currentIndex == 13 {
            staticpickervalue = ["Loud", "Medium", "Low"]
        }else if currentIndex == 14 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 15 {
            staticpickervalue = ["Work", "Pleasure"]
        }else if currentIndex == 16 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 17 {
            staticpickervalue = ["Minimum", "Midium", "Maximum"]
        }else if currentIndex == 18 {
            staticpickervalue = ["Dressed", "Undressed"]
        }
        
        pickerview.reloadAllComponents()
        
        if currentIndex == 0 {
            if let val1 = UserDefaults.standard.value(forKey: strQue1) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 1 {
            if let val1 = UserDefaults.standard.value(forKey: strQue2) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 2 {
            if let val1 = UserDefaults.standard.value(forKey: strQue3) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
//                    if currentIndex == 3 && selectedCost == "Yes"{
//                        delegate?.setUnderDoctor(strAction: "Yes")
//                    }else {
                        //delegate?.setUnderDoctor(strAction: "No")
//                    }
                }
            }
        }else if currentIndex == 3 {
            if let val1 = UserDefaults.standard.value(forKey: strQue4) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
//                    if currentIndex == 3 && selectedCost == "Yes"{
//                        delegate?.setUnderDoctor(strAction: "Yes")
//                    }else {
                        //delegate?.setUnderDoctor(strAction: "No")
//                    }
                }
            }
        }else if currentIndex == 4 {
            if let val1 = UserDefaults.standard.value(forKey: strQue5) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 5 {
            if let val1 = UserDefaults.standard.value(forKey: strQue6) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 6 {
            if let val1 = UserDefaults.standard.value(forKey: strQue7) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 7 {
            if let val1 = UserDefaults.standard.value(forKey: strQue8) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 8 {
            if let val1 = UserDefaults.standard.value(forKey: strQue9) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 9 {
            if let val1 = UserDefaults.standard.value(forKey: strQue10) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 10 {
            if let val1 = UserDefaults.standard.value(forKey: strQue11) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 11 {
            if let val1 = UserDefaults.standard.value(forKey: strQue12) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 12 {
            if let val1 = UserDefaults.standard.value(forKey: strQue13) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 13 {
            if let val1 = UserDefaults.standard.value(forKey: strQue14) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 14 {
            if let val1 = UserDefaults.standard.value(forKey: strQue15) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 15 {
            if let val1 = UserDefaults.standard.value(forKey: strQue16) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 16 {
            if let val1 = UserDefaults.standard.value(forKey: strQue17) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 17 {
            if let val1 = UserDefaults.standard.value(forKey: strQue18) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }else if currentIndex == 18 {
            if let val1 = UserDefaults.standard.value(forKey: strQue19) as? String {
                if let selectedCostIndex = staticpickervalue.firstIndex(of: val1) {
                    self.pickerview.selectRow(selectedCostIndex, inComponent: 0, animated: true)
                    self.txtSelectAns.text = val1
                    //delegate?.setUnderDoctor(strAction: "No")
                }
            }
        }
    }
}

extension MyPreferenceCollectioncell{
    
//    @IBAction func onClickPickerDisplay(sender : UIButton){
//        self.pickerview.isHidden = false
//        self.rangeSelectedbutton.setTitle("", for: .normal)
//
//        /*staticpickervalue .removeAll()
//
//        if currentIndex == 0 {
//            staticpickervalue = ["Monthly", "Bi-Weekly", "Weekly", "Daily", "Never", "Holiday", "Gifted"]
//        }else if currentIndex == 1 {
//            staticpickervalue = ["Upper Body", "Lower Body", "Legs", "Arms"]
//        }else if currentIndex == 2 {
//            staticpickervalue = ["Good", "Average", "Poor"]
//        }else if currentIndex == 3 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 4 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 5 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 6 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 7 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 8 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 9 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 10 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 11 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 12 {
//            staticpickervalue = ["Soft", "Hard"]
//        }else if currentIndex == 13 {
//            staticpickervalue = ["Loud", "Medium", "Low"]
//        }else if currentIndex == 14 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 15 {
//            staticpickervalue = ["Work", "Pleasure"]
//        }else if currentIndex == 16 {
//            staticpickervalue = ["Yes", "No"]
//        }else if currentIndex == 17 {
//            staticpickervalue = ["Minimum", "Midium", "Maximum"]
//        }else if currentIndex == 18 {
//            staticpickervalue = ["Dressed", "Undressed"]
//        }
//        pickerview.reloadAllComponents()
//
//        updateView()*/
//    }
}

extension MyPreferenceCollectioncell:UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return staticpickervalue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return staticpickervalue[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCost = staticpickervalue[row] // selected item
        txtSelectAns.text = selectedCost
        txtSelectAns.textColor = UIColor.black
        
//        self.rangeSelectedbutton.setTitle(selectedCost, for: .normal)
//        self.rangeSelectedbutton.setTitleColor(.black, for: .normal)
        
//        if currentIndex == 3 && selectedCost == "Yes"{
//            delegate?.setUnderDoctor(strAction: "Yes")
//        }else {
//            delegate?.setUnderDoctor(strAction: "No")
//        }
        
        UserDefaults.standard.set("", forKey: QueAns)
        UserDefaults.standard.set(txtSelectAns.text, forKey: QueAns)
        
        if currentIndex == 0 {
            UserDefaults.standard.set(selectedCost, forKey: strQue1)
        }else if currentIndex == 1 {
            UserDefaults.standard.set(selectedCost, forKey: strQue2)
        }else if currentIndex == 2 {
            UserDefaults.standard.set(selectedCost, forKey: strQue3)
        }else if currentIndex == 3 {
            UserDefaults.standard.set(selectedCost, forKey: strQue4)
        }else if currentIndex == 4 {
            UserDefaults.standard.set(selectedCost, forKey: strQue5)
        }else if currentIndex == 5 {
            UserDefaults.standard.set(selectedCost, forKey: strQue6)
        }else if currentIndex == 6 {
            UserDefaults.standard.set(selectedCost, forKey: strQue7)
        }else if currentIndex == 7 {
            UserDefaults.standard.set(selectedCost, forKey: strQue8)
        }else if currentIndex == 8 {
            UserDefaults.standard.set(selectedCost, forKey: strQue9)
        }else if currentIndex == 9 {
            UserDefaults.standard.set(selectedCost, forKey: strQue10)
        }else if currentIndex == 10 {
            UserDefaults.standard.set(selectedCost, forKey: strQue11)
        }else if currentIndex == 11 {
            UserDefaults.standard.set(selectedCost, forKey: strQue12)
        }else if currentIndex == 12 {
            UserDefaults.standard.set(selectedCost, forKey: strQue13)
        }else if currentIndex == 13 {
            UserDefaults.standard.set(selectedCost, forKey: strQue14)
        }else if currentIndex == 14 {
            UserDefaults.standard.set(selectedCost, forKey: strQue15)
        }else if currentIndex == 15 {
            UserDefaults.standard.set(selectedCost, forKey: strQue16)
        }else if currentIndex == 16 {
            UserDefaults.standard.set(selectedCost, forKey: strQue17)
        }else if currentIndex == 17 {
            UserDefaults.standard.set(selectedCost, forKey: strQue18)
        }else if currentIndex == 18 {
            UserDefaults.standard.set(selectedCost, forKey: strQue19)
        }
    }
}
