//
//  RoutineDetailDisplayVC.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 20/07/21.
//

import UIKit
import TagListView

class RoutineDetailDisplayVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionTool: UICollectionView!

    @IBOutlet var constHeight: NSLayoutConstraint!
    @IBOutlet var constHeightAilment: NSLayoutConstraint!
    @IBOutlet var constHeightSubCategory: NSLayoutConstraint!
    @IBOutlet var constHeightDescription: NSLayoutConstraint!
    @IBOutlet var constHeightLocation: NSLayoutConstraint!
    @IBOutlet var constHeightPath: NSLayoutConstraint!
    @IBOutlet var constHeightTags: NSLayoutConstraint!
    @IBOutlet var constHeightTools: NSLayoutConstraint!
    
    @IBOutlet weak var viewTagList: TagListView!
    
    @IBOutlet var txtNewTagName: UITextField!
    
    @IBOutlet var btnAilment: UIButton!
    @IBOutlet var btnDescription: UIButton!
    @IBOutlet var btnLocation: UIButton!
    @IBOutlet var btnPath: UIButton!
    @IBOutlet var btnSegment: UIButton!
    @IBOutlet var btnTags: UIButton!
    @IBOutlet var btnTool: UIButton!
    @IBOutlet var btnTools: [UIButton]!
    @IBOutlet var btnSPath: [UIButton]!
    @IBOutlet var btnDiseases: [UIButton]!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet var lblRoutineName: UILabel!
    @IBOutlet var lblAutherName: UILabel!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblSubCategory: UILabel!
    @IBOutlet var lblSegmentCount: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var progressSegment: UIProgressView!
    
    @IBOutlet weak var imgRoutine: UIImageView!
    @IBOutlet weak var ImgBody: UIImageView!
    @IBOutlet weak var ImageAddView: UIView!
    
    @IBOutlet var txvDescription: UITextView!
    @IBOutlet var txvAuthorDescription: UITextView!
    
    @IBOutlet var bottomBarView: UIView!
    @IBOutlet var routineDetailView: UIView!
    @IBOutlet weak var ImageCreateAndRemove: UIView!
    @IBOutlet weak var SubCateGoryHeight: UIView!
    
    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Title2: UILabel!
    @IBOutlet weak var Title3: UILabel!
    @IBOutlet weak var Title4: UILabel!
    @IBOutlet weak var Height: NSLayoutConstraint!
    @IBOutlet weak var lblNewDescri: UILabel!
    @IBOutlet weak var lblNewLocation: UILabel!
    @IBOutlet weak var lblNewPath: UILabel!
    @IBOutlet weak var lblNewTags: UILabel!
    @IBOutlet weak var lblNewTools: UILabel!
    var arrRoutingData = [[String: Any]]()
    var arrSegmentList = [[String: Any]]()
    var arrUserDetail = [[String: Any]]()
    var arrSegmentTools = [String]()
    var arrStoreTools = [String]()
    var arrSegmentDuration = [Int]()
    var selectedTools = [String]()
    var selectedPaths = [String]()
    var strRoutineUID: String = ""
    
    var strRoutingID: String!
    var totalSegCount: Int = 0
    var Gender = String()
    var arrFrontBodyData = [[String:Any]]()
    var arrBackBodyData = [[String:Any]]()
    var arrForce = [Int]()
    
    let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:340,height: 460))
    var colors:[UIColor] = [UIColor.red, UIColor.yellow]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:70,y: 440, width:200, height:50))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getUserDetailAPICall()
        // Do any additional setup after loading the view.
        
       //       pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
        viewTagList.delegate = self
        
        self.collectionTool.register(UINib(nibName: "RoutineDetailCell", bundle: nil), forCellWithReuseIdentifier: "DetailCell")
        
        constHeightAilment.constant = 34.0
        constHeightSubCategory.constant = 40.0
        constHeightDescription.constant = 32.0
        constHeightLocation.constant = 34.0
        constHeightPath.constant = 34.0
        constHeightTags.constant = 34.0
        constHeightTools.constant = 34.0
        
        self.getRoutineDetailHeight()
        self.setRoutingDataServiceCall()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getUserDetailAPICall() {
                           
      //  let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='select r.userid, r.*,u.firstname, u.lastname, u.email from routine r left join userdata u on r.userid=u.userid where r.routineid ='\(strRoutingID ?? "")''"
        
        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='select r.userid, us.gender,u.firstname, u.lastname, u.email from routine r left join userdata u on r.userid=u.userid left join Userprofile us on  us.userid=u.userid where r.routineid ='\(strRoutingID ?? "")''"

        
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
                               
                        arrUserDetail.append(contentsOf: jsonArray)
                        
                        if arrUserDetail.count > 0 {
                            let routingData = arrUserDetail[0]
                            lblAutherName.text = routingData.getString(key: "firstname") + " " + routingData.getString(key: "lastname")
                            
                            UserDefaults.standard.set(lblAutherName.text, forKey: RoutineUName)
                            
                            self.Gender = routingData.getString(key: "gender")
                            
//                            if Gender == "F"
//                            {
//                                self.ImgBody.image = UIImage(named: "F-grey female body back")
//                            }else{
//                                self.ImgBody.image = UIImage(named: "grey male body back")
//                            }
                        }
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func setRoutingDataServiceCall() {
                        
        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = '9ccx8ms5pc0000000000' and f.routineid = r.routineid) as is_favourite from Routine as r where r.routineId='\(strRoutingID!)''"
        
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
                        
                        arrRoutingData.append(contentsOf: jsonArray)
                        
                        if arrRoutingData.count > 0 {
                            let routingData = arrRoutingData[0]
                                                        
                            strRoutineUID = routingData.getString(key: "userid")
                            
                            lblRoutineName.text = routingData.getString(key: "routinename")
                            lblType.text = routingData.getString(key: "routine_type")
                            lblUser.text = routingData.getString(key: "user_type")
                            lblCategory.text = routingData.getString(key: "routine_category")
                            
                            if lblCategory.text == "therapy" {
                                self.Height.constant = 0
                            }
                            //else {
                            //    self.Height.constant = 40
                           // }
                            
                            self.lblNewDescri.text = routingData.getString(key: "description")
                            self.lblNewTags.text = routingData.getString(key: "routine_tags")
                            
                            lblSubCategory.text = routingData.getString(key: "routine_subcategory")
                            txvDescription.text = routingData.getString(key: "description")
                            
                            let strCreateDate = routingData.getString(key: "creation").replacingOccurrences(of: " GMT", with: "")
                               
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "E, d MMM yyyy HH:mm:ss"

                            let dateFormatterPrint = DateFormatter()
                            dateFormatterPrint.dateFormat = "E, d MMM yyyy"

                            let date: NSDate? = dateFormatterGet.date(from: strCreateDate) as NSDate?
                            print(dateFormatterPrint.string(from: date! as Date))
                                                    
                            lblDate.text = dateFormatterPrint.string(from: date! as Date)
                                                    
                            let points = routingData.getString(key: "user_details")
                            let arrDiseases_1 = points.components(separatedBy: ",")
                            print("Array Count>>>>>\(arrDiseases_1.count)")
                            
                            if arrDiseases_1.count > 0 {
                                
                                for i in 0..<arrDiseases_1.count {
                                    
                                    let selectValue: String = String(format: "%@", arrDiseases_1[i])
                                    
                                    if selectValue == "anxiety" {
                                        btnDiseases[0].isSelected = true
                                    }
                                    if selectValue == "fatiue" {
                                        btnDiseases[1].isSelected = true
                                    }
                                    if selectValue == "headache/migraines" {
                                        btnDiseases[2].isSelected = true
                                    }
                                    if selectValue == "inflammation" {
                                        btnDiseases[3].isSelected = true
                                    }
                                    if selectValue == "injury" {
                                        btnDiseases[4].isSelected = true
                                    }
                                    if selectValue == "insomnia" {
                                        btnDiseases[5].isSelected = true
                                    }
                                    if selectValue == "muscle spasm" {
                                        btnDiseases[6].isSelected = true
                                    }
                                    if selectValue == "pain" {
                                        btnDiseases[7].isSelected = true
                                    }
                                    if selectValue == "relaxation" {
                                        btnDiseases[8].isSelected = true
                                    }
                                    if selectValue == "stress" {
                                        btnDiseases[9].isSelected = true
                                    }
                                    if selectValue == "hand" {
                                        btnDiseases[10].isSelected = true
                                    }
                                    if selectValue == "tension" {
                                        btnDiseases[11].isSelected = true
                                    }
                                }
                            }
                                                        
                            if routingData.getString(key: "thumbnail") != "" {
                                let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + routingData.getString(key: "thumbnail") + "?alt=media"
                                let urls = URL.init(string: strURLThumb)
                                imgRoutine.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon"))
                            }else {
                                imgRoutine.image = UIImage(named: "DefaultIcon")
                            }
                            
                            let strTagList: String = routingData.getString(key: "routine_tags")
                            
                            if strTagList != "" {
                                let strTagData = strTagList.components(separatedBy: ",")
                                
                                for tagAdd in strTagData {
    //                                let strAddTag: String = String(format: "%@", tagAdd)
                                    viewTagList.addTag(String(format: "%@", tagAdd))
                                }
                            }

                        }
                        self.getRoutinSegmentDataListServiceCall()
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func getRoutineDetailHeight() {
        let contHeight: Float = Float(constHeightPath.constant + constHeightTags.constant + constHeightTools.constant)
        
        constHeight.constant = CGFloat(Float(2150.0 + constHeightAilment.constant + constHeightSubCategory.constant + constHeightDescription.constant + constHeightLocation.constant) + contHeight)
    }
    
    func getRoutinSegmentDataListServiceCall() {
        
        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from RoutineEntity where routineID = '\(strRoutingID!)''"
        
        print(url)
        //ROUTINGUSERID
        
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
                        
                        arrSegmentList.append(contentsOf: jsonArray)
                        print("SegmentCount:-\(arrSegmentList.count),SegmentData:-\(arrSegmentList)")
                        
                        if arrSegmentList.count >= 4
                        {
                            let data1 = arrSegmentList[0]
                            let location_r1 = data1["location_r"] as? String ?? ""
                            Title1.text = location_r1
                            
                            let data2 = arrSegmentList[1]
                            let location_r2 = data2["location_r"] as? String ?? ""
                            Title2.text = location_r2
                            
                            let data3 = arrSegmentList[2]
                            let location_r3 = data3["location_r"] as? String ?? ""
                            Title3.text = location_r3
                            
                            let data4 = arrSegmentList[3]
                            let location_r4 = data4["location_r"] as? String ?? ""
                            Title4.text = location_r4
                        }
                        else if arrSegmentList.count == 3
                        {
                            let data1 = arrSegmentList[0]
                            let location_r1 = data1["location_r"] as? String ?? ""
                            Title1.text = location_r1
                            
                            let data2 = arrSegmentList[1]
                            let location_r2 = data2["location_r"] as? String ?? ""
                            Title2.text = location_r2
                            
                            let data3 = arrSegmentList[2]
                            let location_r3 = data3["location_r"] as? String ?? ""
                            Title3.text = location_r3
                        }
                        else if arrSegmentList.count == 2
                        {
                            let data1 = arrSegmentList[0]
                            let location_r1 = data1["location_r"] as? String ?? ""
                            Title1.text = location_r1
                            
                            let data2 = arrSegmentList[1]
                            let location_r2 = data2["location_r"] as? String ?? ""
                            Title2.text = location_r2
                        }
                        else if arrSegmentList.count == 1
                        {
                            let data1 = arrSegmentList[0]
                            let location_r1 = data1["location_r"] as? String ?? ""
                            Title1.text = location_r1
                        }
                        
                        
                        
                        
                        for Data in arrSegmentList
                        {
                            let FrontAndBack = Data["body_location"] as? String ?? ""
                            let location_r = Data["location_r"] as? String ?? ""
                            let location_l = Data["location_l"] as? String ?? ""
                            
                            let force_r = Data["force_r"] as? Int ?? 0
                            let force_l = Data["force_l"] as? Int ?? 0
                            self.arrForce.append(force_r)
                            self.arrForce.append(force_l)
                            
                            if FrontAndBack == "F" {
                                let Dict = ["location_r":location_r,"location_l":location_l,"body_location":FrontAndBack]
                                self.arrFrontBodyData.append(Dict)
                            } else if FrontAndBack == "B"{
                                let Dict = ["location_r":location_r,"location_l":location_l,"body_location":FrontAndBack]
                                self.arrBackBodyData.append(Dict)
                            }else {
                                let Dict = ["location_r":location_r,"location_l":location_l,"body_location":FrontAndBack]
                                self.arrFrontBodyData.append(Dict)
                            }
                        }
                        
                        
                        if arrFrontBodyData.count > 0 && arrBackBodyData.count > 0
                        {
                            self.ConfigurePageControl(Count: 2)
                            scrollView.delegate = self
                            scrollView.isPagingEnabled = true
                            self.ImageAddView.addSubview(scrollView)
                            
//                            for index in 0..<2 {
//                              print("ImageBodyPartIndex:-\(index)")
//                              self.scrollView .addSubview(ImgBody)
//                            }
                            self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 2,height: self.scrollView.frame.size.height)
                            
                            for Data in arrFrontBodyData
                            {
                                let location_r = Data["location_r"] as? String ?? ""
                                let location_l = Data["location_l"] as? String ?? ""
                                let FrontAndBack = Data["body_location"] as? String ?? ""
                                self.ImageBodyPartSetAndFrontBack(LLocation: location_l, RLocation: location_r, Body: FrontAndBack, Gender: self.Gender)
                            }
                        }
                        else if arrFrontBodyData.count > 0
                        {
                            self.ConfigurePageControl(Count: 1)
                            scrollView.delegate = self
                            scrollView.isPagingEnabled = true
                            self.ImageAddView.addSubview(scrollView)
                            self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 1,height: self.scrollView.frame.size.height)
                            
                            for Data in arrFrontBodyData
                            {
                                let location_r = Data["location_r"] as? String ?? ""
                                let location_l = Data["location_l"] as? String ?? ""
                                let FrontAndBack = Data["body_location"] as? String ?? ""
                                
                                self.ImageBodyPartSetAndFrontBack(LLocation: location_l, RLocation: location_r, Body: FrontAndBack, Gender: self.Gender)
                            }
                        }
                        else if arrBackBodyData.count > 0
                        {
                            self.ConfigurePageControl(Count: 1)
                            scrollView.delegate = self
                            scrollView.isPagingEnabled = true
                            self.ImageAddView.addSubview(scrollView)
                            self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 1,height: self.scrollView.frame.size.height)
                            
                            for Data in arrBackBodyData
                            {
                                let location_r = Data["location_r"] as? String ?? ""
                                let location_l = Data["location_l"] as? String ?? ""
                                let FrontAndBack = Data["body_location"] as? String ?? ""
                                
                                self.ImageBodyPartSetAndFrontBack(LLocation: location_l, RLocation: location_r, Body: FrontAndBack, Gender: self.Gender)
                            }
                        }
                        
                        let ForceMex = arrForce.max()
                        let FOr:Float = Float(ForceMex!)
                        progressSegment.setProgress(FOr/100.0, animated: true)
                      //  progressDownload.setProgress(5.0/10.0, animated: true)

                        
                       

//                        if arrHumanBodyNameLeft.count > 0  && arrHumanBodyNameRight.count  > 0 {
//                        if arrUserDetail.count > 0 {
//                            let routingData = arrUserDetail[0]
//                            let Gender = routingData.getString(key: "gender")
//                            if Gender == "F"
//                            {
//                                self.ImgBody.image = UIImage(named: "F-grey female body back")
//                                for Female in arrHumanBodyNameLeft {
//                                    var BodyPartNameL = String()
//                                    if Female == "upperback"
//                                    {
//                                        BodyPartNameL = "F-L-trap"
//                                    }
//                                    else if Female == "lowerback"
//                                    {
//                                        BodyPartNameL = "F-L-lower back"
//                                    }
//                                    else if Female == "hamstring"
//                                    {
//                                        BodyPartNameL = "F-L-ham"
//                                    }
//                                    else if Female == "gastrocnemius"
//                                    {
//                                        BodyPartNameL = "F-L-calf"
//                                    }
//                                    else if Female == "quadracepts"
//                                    {
//                                        BodyPartNameL = "F-L-quad"
//                                    }
//                                    else if Female == "iliotibal tract"
//                                    {
//                                        BodyPartNameL = "F-L-IT band"
//                                    }
//                                    else if Female == "tibalis anterior"
//                                    {
//                                        BodyPartNameL = "F-L-tibialis"
//                                    }
//                                    else if Female == "deltoid"
//                                    {
//                                        BodyPartNameL = "F-L-shoulder"
//                                    }
//                                    else if Female == "pectoralis"
//                                    {
//                                        BodyPartNameL = "F-L-pect"
//                                    }
//                                    else if Female == "glutiusmaximus"
//                                    {
//                                        BodyPartNameL = "F-L-glut"
//                                    }
//
//                                    for FemaleR in arrHumanBodyNameRight {
//
//                                             var BodyPartNameR = String()
//                                            if FemaleR == "upperback"
//                                            {
//                                                BodyPartNameR = "F-R-trap"
//                                            }
//                                            else if FemaleR == "lowerback"
//                                            {
//                                                BodyPartNameR = "F-R-lower back"
//                                            }
//                                            else if FemaleR == "hamstring"
//                                            {
//                                                BodyPartNameR = "F-R-ham"
//                                            }
//                                            else if FemaleR == "gastrocnemius"
//                                            {
//                                                BodyPartNameR = "F-R-calf"
//                                            }
//                                            else if FemaleR == "quadracepts"
//                                            {
//                                                BodyPartNameR = "F-R-quad"
//                                            }
//                                            else if FemaleR == "iliotibal tract"
//                                            {
//                                                BodyPartNameR = "F-R-IT band"
//                                            }
//                                            else if FemaleR == "tibalis anterior"
//                                            {
//                                                BodyPartNameR = "F-R-tibialis"
//                                            }
//                                            else if FemaleR == "deltoid"
//                                            {
//                                                BodyPartNameR = "F-R-shoulder"
//                                            }
//                                            else if FemaleR == "pectoralis"
//                                            {
//                                                BodyPartNameR = "F-R-pect"
//                                            }
//                                            else if FemaleR == "glutiusmaximus"
//                                            {
//                                                BodyPartNameR = "F-R-glut"
//                                            }
//                                            let image = UIImage(named: BodyPartNameR)
//                                            let imageView = UIImageView(image: image)
//                                            imageView.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
//                                            self.ImageAddView.addSubview(imageView)
//
//                                    }
//                                    let image = UIImage(named: BodyPartNameL)
//                                    let imageView = UIImageView(image: image)
//                                    imageView.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
//                                    self.ImageAddView.addSubview(imageView)
//
//
//                                }
//                            }else{
//                               // self.ImgBody.image = UIImage(named: "grey male body back")
//                                for MaleL in arrHumanBodyNameLeft {
//                                    var BodyPartNameL = String()
//                                    if MaleL == "upperback"
//                                    {
//                                        BodyPartNameL = "L-trap"
//                                    }
//                                    else if MaleL == "lowerback"
//                                    {
//                                        BodyPartNameL = "L-lower back"
//                                    }
//                                    else if MaleL == "hamstring"
//                                    {
//                                        BodyPartNameL = "L-ham"
//                                    }
//                                    else if MaleL == "gastrocnemius"
//                                    {
//                                        BodyPartNameL = "L-calf"
//                                    }
//                                    else if MaleL == "quadracepts"
//                                    {
//                                        BodyPartNameL = "L-quad"
//                                    }
//                                    else if MaleL == "iliotibal tract"
//                                    {
//                                        BodyPartNameL = "L-IT band"
//                                    }
//                                    else if MaleL == "tibalis anterior"
//                                    {
//                                        BodyPartNameL = "L-tibialis"
//                                    }
//                                    else if MaleL == "deltoid"
//                                    {
//                                        BodyPartNameL = "L-shoulder"
//                                    }
//                                    else if MaleL == "pectoralis"
//                                    {
//                                        BodyPartNameL = "L-pect"
//                                    }
//                                    else if MaleL == "glutiusmaximus"
//                                    {
//                                        BodyPartNameL = "L-glut"
//                                    }
//
//                                    for MaleR in arrHumanBodyNameRight {
//
//                                             var BodyPartNameR = String()
//                                            if MaleR == "upperback"
//                                            {
//                                                BodyPartNameR = "R-trap"
//                                            }
//                                            else if MaleR == "lowerback"
//                                            {
//                                                BodyPartNameR = "R-lower back"
//                                            }
//                                            else if MaleR == "hamstring"
//                                            {
//                                                BodyPartNameR = "R-ham"
//                                            }
//                                            else if MaleR == "gastrocnemius"
//                                            {
//                                                BodyPartNameR = "R-calf"
//                                            }
//                                            else if MaleR == "quadracepts"
//                                            {
//                                                BodyPartNameR = "R-quad"
//                                            }
//                                            else if MaleR == "iliotibal tract"
//                                            {
//                                                BodyPartNameR = "R-IT band"
//                                            }
//                                            else if MaleR == "tibalis anterior"
//                                            {
//                                                BodyPartNameR = "R-tibialis"
//                                            }
//                                            else if MaleR == "deltoid"
//                                            {
//                                                BodyPartNameR = "R-shoulder"
//                                            }
//                                            else if MaleR == "pectoralis"
//                                            {
//                                                BodyPartNameR = "R-pect"
//                                            }
//                                            else if MaleR == "glutiusmaximus"
//                                            {
//                                                BodyPartNameR = "R-glut"
//                                            }
//                                            let image = UIImage(named: BodyPartNameR)
//                                            let imageView = UIImageView(image: image)
//                                            imageView.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
//                                            self.ImageAddView.addSubview(imageView)
//
//                                    }
//                                    let image = UIImage(named: BodyPartNameL)
//                                    let imageView = UIImageView(image: image)
//                                    imageView.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
//                                    self.ImageAddView.addSubview(imageView)
//                                }
//                            }
//                        }
//                        else
//                        {
//                          //  self.ImgBody.image = UIImage(named: "grey male body back")
//                        }
//                     }
//
//
//
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        lblSegmentCount.text = String(format: "%d Segment", arrSegmentList.count)
                        
                        if arrSegmentList.count == 0 {
                            showToast(message: "Segments not available under this routine")
                        }else {
                            
                            let arrValue = arrSegmentList.count
                            
                            for i in 0..<arrSegmentList.count {
                                totalSegCount += 1
                                self.fillData(index: i)
                            }
                            
                            if selectedTools.count > 0 {
                                for i in 0..<selectedTools.count {
                                    let selectValue: String = String(format: "%@", selectedTools[i])
                                             
                                    if selectValue == "inline" {
                                        btnTools[0].isSelected = true
                                    }
                                    
                                    if selectValue == "omni" {
                                        btnTools[1].isSelected = true
                                    }
                                    
                                    if selectValue == "percussion" {
                                        btnTools[2].isSelected = true
                                    }
                                    
                                    if selectValue == "point" {
                                        btnTools[3].isSelected = true
                                    }
                                    
                                    if selectValue == "sport" {
                                        btnTools[4].isSelected = true
                                    }
                                }
                            }
                            
                        if selectedPaths.count > 0 {
                                for i in 0..<selectedPaths.count {
                                    
                                    let selectValue: String = String(format: "%@", selectedPaths[i])
                                        
                                    if selectValue == "circular" {
                                        btnSPath[0].isSelected = true
                                    }
                                    
                                    if selectValue == "linear" {
                                        btnSPath[1].isSelected = true
                                    }
                                    
                                    if selectValue == "point" {
                                        btnSPath[2].isSelected = true
                                    }
                                    
                                    if selectValue == "random" {
                                        btnSPath[3].isSelected = true
                                    }
                                }
                            }
                        }
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func fillData(index: Int) {
        
        let segmentData = arrSegmentList[index]
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        let strLeftTool: String = segmentData.getString(key: "tool_l")
        let strRightTool: String = segmentData.getString(key: "tool_r")
        let strLeftPath: String = segmentData.getString(key: "path_l")
        let strRightPath: String = segmentData.getString(key: "path_r")
        let strLeftLoction: String = segmentData.getString(key: "location_l")
        let strRightLocation: String = segmentData.getString(key: "location_r")
        let strDuration: String = segmentData.getString(key: "duration")
        let strRightForce: String = segmentData.getString(key: "force_r")
        let strLeftForce: String = segmentData.getString(key: "force_l")
        let strLeftSpeed: String = segmentData.getString(key: "speed_l")
        let strRightSpeed: String = segmentData.getString(key: "speed_r")
               
        self.arrStoreTools.append(strLeftTool.replacingOccurrences(of: " ", with: "").lowercased())
        self.arrStoreTools.append(strRightTool.replacingOccurrences(of: " ", with: "").lowercased())
       // self.arrStoreTools.append(strLeftPath.replacingOccurrences(of: " ", with: "").lowercased())
       // self.arrStoreTools.append(strRightPath.replacingOccurrences(of: " ", with: "").lowercased())
        
        for i in 0..<arrStoreTools.count {
            let strToolPath = String(format: "%@", arrStoreTools[i])
            
            if !self.arrSegmentTools.contains(strToolPath) {
                self.arrSegmentTools.append(strToolPath)
            }
        }
        
        let convertToInt = Int(strDuration) ?? 0
        let intDuration = convertToInt/60
        
        self.arrSegmentDuration.append(intDuration)
        
        if arrSegmentList.count == index + 1 {
            
            let totalDuration = self.arrSegmentDuration.reduce(0, {x, y in x + y})
            print("DurationTotal>>>>>>> \(totalDuration)")
            
            let durCalculate: Float = Float((totalDuration*100)/60)
            let ProValue: Float = durCalculate/100
            print("ProVal????>>>>\(durCalculate)")
            print("123456>>>>>>>> \(ProValue)")
            
           // self.progressSegment.progress = ProValue
            self.collectionTool.reloadData()
        }
        
        
        if !selectedTools.contains(strLeftTool.lowercased()) {
            selectedTools.append(strLeftTool.lowercased())
        }

        if !selectedTools.contains(strRightTool.lowercased()) {
            selectedTools.append(strRightTool.lowercased())
        }

        if !selectedPaths.contains(strLeftPath.lowercased()) {
            selectedPaths.append(strLeftPath.lowercased())
        }

        if !selectedPaths.contains(strRightPath.lowercased()) {
            selectedPaths.append(strRightPath.lowercased())
        }
        
//        let intSpeed_L = Int(strLeftSpeed) ?? 0
//        let intSpeed_R = Int(strRightSpeed) ?? 0
//
//        let intForce_L = Int(strLeftForce) ?? 0
//        let intForce_R = Int(strRightForce) ?? 0
//
//        intAvgSpeedCount = intAvgSpeedCount + intSpeed_L + intSpeed_R
//        intAvgPressureCount = intAvgPressureCount + intForce_L + intForce_R
        
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let datetime = formatter.string(from: now)
        print(datetime)

        let timeAndDate = datetime.components(separatedBy: " ")

        let strDate: String = String(format: "%@", timeAndDate[0])
        let strTime: String = String(format: "%@", timeAndDate[1])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSegmentTools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! RoutineDetailCell
        
        if self.arrSegmentTools.count > 0  {
            
            cell.lblToolName.text = self.arrSegmentTools[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
           
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 78.0, height: 78.0)
    }
    
    @IBAction func btnSettingAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewCreateSegmentVC") as! NewCreateSegmentVC
        vc.StrRoutingID = strRoutingID!
        vc.strPath = "NotCreateRoutine"
        vc.strRoutingUID = strRoutineUID
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onClickPlaySegmentBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SegmentPlayVC") as! SegmentPlayVC
        vc.strRoutingID = strRoutingID
        
        if arrSegmentList.count == 0 {
            vc.strIsEnable = "No"
        }else {
            vc.strIsEnable = "Yes"
        }
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onClickMoreDetailBtn(_ sender: Any) {
        bottomBarView.isHidden = true
        routineDetailView.isHidden = false
    }
    
    @IBAction func onClickDownBtn(_ sender: Any) {
        bottomBarView.isHidden = false
        routineDetailView.isHidden = true
    }
    
    @IBAction func onClickAilmentBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnAilment.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnAilment.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        if constHeightAilment.constant == 562 {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnAilment.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
            })
            constHeightAilment.constant = 34.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnAilment.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnAilment.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            constHeightAilment.constant = 562.0
        }
        
        self.getRoutineDetailHeight()
    }
        
    @IBAction func onClickDescriptionBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnDescription.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnDescription.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        if constHeightDescription.constant == 182.0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnDescription.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
            })
            constHeightDescription.constant = 32.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnDescription.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnDescription.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            constHeightDescription.constant = 182.0
        }
        
        self.getRoutineDetailHeight()
    }
    
    @IBAction func onClickLocationBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnLocation.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnLocation.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        if constHeightLocation.constant == 207.0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnLocation.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
            })
            constHeightLocation.constant = 34.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnLocation.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnLocation.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            constHeightLocation.constant = 207.0
        }
        
        self.getRoutineDetailHeight()
    }
    
    @IBAction func onClickPathBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnPath.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnPath.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        if constHeightPath.constant == 207 {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnPath.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
            })
            
            constHeightPath.constant = 34.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnPath.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnPath.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            
            constHeightPath.constant = 207.0
        }
        
        self.getRoutineDetailHeight()
    }
    
    @IBAction func onClickShowSegmentListBtn(_ sender: Any) {
        
    }
    
    @IBAction func onClickTagsBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnTags.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnTags.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        if constHeightTags.constant == 111 {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnTags.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
            })
            
            constHeightTags.constant = 34.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnTags.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnTags.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            
            constHeightTags.constant = 111.0
        }
        
        self.getRoutineDetailHeight()
    }
    
    @IBAction func onClickToolsBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnTool.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnTool.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        if constHeightTools.constant == 248 {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnTool.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
            })
            constHeightTools.constant = 34.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnTool.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnTool.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            constHeightTools.constant = 248.0
        }
        
        self.getRoutineDetailHeight()
    }
    
      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let index: Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        print("Index Count:::\(index)")
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
        if arrFrontBodyData.count > 0 && arrBackBodyData.count > 0
        {
//            guard let sublayers = ImageAddView.layer.sublayers else { return }
//            for layer in sublayers {
//            layer.removeFromSuperlayer()
//            }
            self.ImageCreateAndRemove.layer.sublayers = nil;


                
                
            if index == 0 {
                for Data in arrFrontBodyData
                {
                    let location_r = Data["location_r"] as? String ?? ""
                    let location_l = Data["location_l"] as? String ?? ""
                    let FrontAndBack = Data["body_location"] as? String ?? ""
                    self.ImageBodyPartSetAndFrontBack(LLocation: location_l, RLocation: location_r, Body: FrontAndBack, Gender: self.Gender)
                }
            } else if index == 1 {
                for Data in arrBackBodyData
                {
                    let location_r = Data["location_r"] as? String ?? ""
                    let location_l = Data["location_l"] as? String ?? ""
                    let FrontAndBack = Data["body_location"] as? String ?? ""
                    self.ImageBodyPartSetAndFrontBack(LLocation: location_l, RLocation: location_r, Body: FrontAndBack, Gender: self.Gender)
                }
            }
           
        }
        
      }
}

extension RoutineDetailDisplayVC: TagListViewDelegate
{
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        sender.removeTagView(tagView)
        if viewTagList.tagViews.count == 0
        {
            txtNewTagName.placeholder = "Enter a new tag"
        }
        else
        {
            txtNewTagName.placeholder = "+ tag"
        }
    }
}

extension RoutineDetailDisplayVC
{
    func ConfigurePageControl(Count:Int) {
          // The total number of pages that are available is based on how many available colors we have.
          self.pageControl.numberOfPages = Count
          self.pageControl.currentPage = 0
          self.pageControl.tintColor = UIColor.red
          self.pageControl.pageIndicatorTintColor = UIColor.black
          self.pageControl.currentPageIndicatorTintColor = UIColor.blue
          self.ImageAddView.addSubview(pageControl)
      }
    
    func ImageBodyPartSetAndFrontBack(LLocation: String,RLocation:String,Body:String,Gender:String)
    {
        if Gender == "F" {
            if Body == "B" {
                self.ImgBody.image = UIImage(named: "F-grey female body back")
                self.SetBodyPartFemale(R: RLocation, L: LLocation)
            }else{
                self.ImgBody.image = UIImage(named: "F-grey female body front")
                self.SetBodyPartFemale(R: RLocation, L: LLocation)
            }
        } else {
            if Body == "B" {
                self.ImgBody.image = UIImage(named: "grey male body back")
                self.SetBodyPartMale(R: RLocation, L: LLocation)
            }else{
                self.ImgBody.image = UIImage(named: "grey male body front")
                self.SetBodyPartMale(R: RLocation, L: LLocation)
            }
        }
    }
    func SetBodyPartMale(R:String,L:String)
    {
        var LName = String()
        var RName = String()
        
        if L == "upperback"
        {
            LName = "L-trap"
        }
        else if L == "lowerback"
        {
            LName = "L-lower back"
        }
        else if L == "hamstring"
        {
            LName = "L-ham"
        }
        else if L == "gastrocnemius"
        {
            LName = "L-calf"
        }
        else if L == "quadracepts"
        {
            LName = "L-quad"
        }
        else if L == "iliotibal tract"
        {
            LName = "L-IT band"
        }
        else if L == "tibalis anterior"
        {
            LName = "L-tibialis"
        }
        else if L == "deltoid"
        {
            LName = "L-shoulder"
        }
        else if L == "pectoralis"
        {
            LName = "L-pect"
        }
        else if L == "glutiusmaximus"
        {
            LName = "L-glut"
        }else if L == "knee" {
            LName = "L-knee"
        }
        
        if R == "upperback"
        {
            RName = "R-trap"
        }
        else if R == "lowerback"
        {
            RName = "R-lower back"
        }
        else if R == "hamstring"
        {
            RName = "R-ham"
        }
        else if R == "gastrocnemius"
        {
            RName = "R-calf"
        }
        else if R == "quadracepts"
        {
            RName = "R-quad"
        }
        else if R == "iliotibal tract"
        {
            RName = "R-IT band"
        }
        else if R == "tibalis anterior"
        {
            RName = "R-tibialis"
        }
        else if R == "deltoid"
        {
            RName = "R-shoulder"
        }
        else if R == "pectoralis"
        {
            RName = "R-pect"
        }
        else if R == "glutiusmaximus"
        {
            RName = "R-glut"
        } else if R == "knee" {
            RName = "R-knee"
        }
        
        let imageR = UIImage(named: RName)
        let imageViewR = UIImageView(image: imageR)
        imageViewR.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
        self.ImageCreateAndRemove.addSubview(imageViewR)
        
        
        let imageL = UIImage(named: LName)
        let imageViewL = UIImageView(image: imageL)
        imageViewL.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
        self.ImageCreateAndRemove.addSubview(imageViewL)
    }
    func SetBodyPartFemale(R:String,L:String)
    {
        var LName = String()
        var RName = String()
        
        if L == "upperback"
        {
            LName = "F-L-trap"
        }
        else if L == "lowerback"
        {
            LName = "F-L-lower back"
        }
        else if L == "hamstring"
        {
            LName = "F-L-ham"
        }
        else if L == "gastrocnemius"
        {
            LName = "F-L-calf"
        }
        else if L == "quadracepts"
        {
            LName = "F-L-quad"
        }
        else if L == "iliotibal tract"
        {
            LName = "F-L-IT band"
        }
        else if L == "tibalis anterior"
        {
            LName = "F-L-tibialis"
        }
        else if L == "deltoid"
        {
            LName = "F-L-shoulder"
        }
        else if L == "pectoralis"
        {
            LName = "F-L-pect"
        }
        else if L == "glutiusmaximus"
        {
            LName = "F-L-glut"
        } else if L == "knee" {
            LName = "F-L-knee"
        }
        
        if R == "upperback"
        {
            RName = "F-R-trap"
        }
        else if R == "lowerback"
        {
            RName = "F-R-lower back"
        }
        else if R == "hamstring"
        {
            RName = "F-R-ham"
        }
        else if R == "gastrocnemius"
        {
            RName = "F-R-calf"
        }
        else if R == "quadracepts"
        {
            RName = "F-R-quad"
        }
        else if R == "iliotibal tract"
        {
            RName = "F-R-IT band"
        }
        else if R == "tibalis anterior"
        {
            RName = "F-R-tibialis"
        }
        else if R == "deltoid"
        {
            RName = "F-R-shoulder"
        }
        else if R == "pectoralis"
        {
            RName = "F-R-pect"
        }
        else if R == "glutiusmaximus"
        {
            RName = "F-R-glut"
        } else if R == "knee" {
            RName = "F-R-knee"
        }
        
        let imageR = UIImage(named: RName)
        let imageViewR = UIImageView(image: imageR)
        imageViewR.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
        self.ImageCreateAndRemove.addSubview(imageViewR)
        
        let imageL = UIImage(named: LName)
        let imageViewL = UIImageView(image: imageL)
        imageViewL.frame = CGRect(x:ImgBody.frame.origin.x, y:ImgBody.frame.origin.y, width: self.ImgBody.bounds.width, height: self.ImgBody.bounds.height)
        self.ImageCreateAndRemove.addSubview(imageViewL)
    }
}


extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
