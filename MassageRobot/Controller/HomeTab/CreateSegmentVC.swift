//
//  CreateSegmentVC.swift
//  MassageRobot
//
//  Created by Augmenta on 21/07/21.
//

import UIKit

class CreateSegmentVC: UIViewController, UIScrollViewDelegate  {
    
    @IBOutlet weak var viewSliderPopup: UIView!
    @IBOutlet weak var viewLocationPopup: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var lblSliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    //@IBOutlet weak var constContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var svContainer: UIScrollView!
    @IBOutlet weak var viewRuler: UIView!
    @IBOutlet weak var viewAddSegment: UIView!
    @IBOutlet weak var viewCSegment: UIView!

    @IBOutlet weak var btnLinkUnLink: UIButton!
    
    @IBOutlet weak var lblRoutineUName: UILabel!
    
    @IBOutlet weak var BodyPartImage: UIImageView!
    @IBOutlet weak var ImageAddView: UIView!
    @IBOutlet weak var ImageLeft: UIImageView!
    @IBOutlet weak var ImageRight: UIImageView!
    let picker = UIPickerView()

    var triLeftSpeed: TriangleView!
    var triRightSpeed: TriangleView!
    var triLeftForce: TriangleView!
    var triRightForce: TriangleView!

    var sliderValue = 0
    var numberOfRoutine = 0
    var delegate: SliderValueSetDelegate?
    var delegateLocation: LocationDelegate?
    var delegateChangeData: isChangeDataDelegate?
    var delegateCopyData: isSegmentDataCopy?
    
    var arrRoutines = [RoutineParam]()
    var arrRuler = [UIView]()
    var arrSegmentList = [[String: Any]]()

    var strLocationAction: String!
    var strLeftLocation: String!
    var strRightLocation: String!
    var strSliderValue: String!
    var strLeftSpeed: String = ""
    var strRightSpeed: String = ""
    var strLeftForce: String = ""
    var strRightForce: String = ""
    var strRoutingID: String!
    var strRoutingUID: String!
    var strPath: String!
    var strRoutineName: String!
    var strType: String!
    var strUser: String!
    var strCategory: String!
    var strSubCategory: String!
    var strDescription: String!
    var strDate: String!
    var strAutherName: String!
    var strTagList: String!
    var strProImgName: String = ""
    
    var arrRoutingData = [[String: Any]]()
    
    var selectedDiseases = [String]()
    var arrUserDetail = [[String: Any]]()
    var intRuler: Int = 0
    var intStoreRuler: Int = 0
    var intCurrentIndex: Int = 0
    var intSegmentCount: Int = 0

    var isRulerAdd: Bool = false
    var isUpdateSegmentData: Bool = false
    var isLink: Bool = true
    var isCopy: Bool = false
    var arrSaveLocation = [[String:Any]]()
    var Gender = String()
    var IndexData : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? "9ccx8ms5pc0000000000"
        
        if strPath == "CreateRoutine" {
            viewAddSegment.isHidden = false
            viewCSegment.isHidden = true
        }else {
            if userID == strRoutingUID {
                viewAddSegment.isHidden = false
                viewCSegment.isHidden = true
            }else {
                viewAddSegment.isHidden = true
                viewCSegment.isHidden = false
            }
            
            let routineUName: String = UserDefaults.standard.object(forKey: RoutineUName) as? String ?? "-"
            lblRoutineUName.text = "Auther Name: " + "\(routineUName )"
        }
        
        UserDefaults.standard.set("true", forKey: SEGMENTCOPY)
                
        btnLinkUnLink.isSelected = false
        
        UserDefaults.standard.set("1", forKey: SEGMENTCOUNT)
                
        self.addRoutineSegmentView()
    }
        
    override func viewDidAppear(_ animated: Bool) {
//        constContainerWidth.constant = CGFloat(numberOfRoutine) * screenWidth
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserDetailAPICall()
        
       // self.BodyPartImage.image = UIImage(named: "grey male body back")
     //   self.getRoutinSegmentDataListServiceCall()
        if strPath == "NotCreateRoutine" {
            self.getRoutinSegmentDataListServiceCall()
//            self.setRoutingDataServiceCall()
        }
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
                            let Gender = routingData.getString(key: "gender")
                            self.Gender = Gender
                            if Gender == "F"
                            {
                                self.BodyPartImage.image = UIImage(named: "F-grey female body back")
                            }else{
                                self.BodyPartImage.image = UIImage(named: "grey male body back")
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

    /*func setRoutingDataServiceCall() {
                        
        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = '9ccx8ms5pc0000000000' and f.routineid = r.routineid) as is_favourite from Routine as r where r.routineId='\(strRoutingID!)''"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            if json.getString(key: "status") == "false"
            {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        arrRoutingData.append(contentsOf: jsonArray)
                        if arrRoutingData.count > 0 {
                            let routingData = arrRoutingData[0]
                            
                            strRoutineName = routingData.getString(key: "routinename")
                            strType = routingData.getString(key: "routine_type")
                            strUser = routingData.getString(key: "user_type")
                            strCategory = routingData.getString(key: "routine_category")
                            strSubCategory = routingData.getString(key: "routine_subcategory")
                            strDescription = routingData.getString(key: "description")
                            
                            let strCreateDate = routingData.getString(key: "creation").replacingOccurrences(of: " GMT", with: "")
                               
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "E, d MMM yyyy HH:mm:ss"

                            let dateFormatterPrint = DateFormatter()
                            dateFormatterPrint.dateFormat = "E, d MMM yyyy"

                            let date: NSDate? = dateFormatterGet.date(from: strCreateDate) as NSDate?
                            print(dateFormatterPrint.string(from: date! as Date))
                                                    
                            strDate = dateFormatterPrint.string(from: date! as Date)
                                                    
                            let points = routingData.getString(key: "user_details")
                            selectedDiseases = points.components(separatedBy: ",")
                                                        
                            strAutherName = routingData.getString(key: "userid")
                                                        
                            strTagList = routingData.getString(key: "routine_tags")
                            
                            strProImgName = routingData.getString(key: "thumbnail")
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
        
    func setAddRoutineServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        if userID != "" {
                            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm"
            
            let diseases = selectedDiseases.joined(separator: ",")
                     
            strRoutingID = randomRoutineId()
            
            let url = """
            https://massage-robotics-website.uc.r.appspot.com/wt?tablename=Routine&row=[('\(strRoutingID!)',
            '\(userID)',
            '\(df.string(from: Date()))',
            'public',
            '\(strRoutineName ?? "")',
            '\(strDescription ?? "")',
            '\(df.string(from: Date()))',
            '5',
            '2',
            'best and good',
            '\(strProImgName)',
            '',
            '\(strCategory ?? "")',
            '\(strType ?? "")',
            '\(strUser ?? "")',
            '\(diseases)',
            '\(strTagList ?? "")',
            '\(strSubCategory ?? "")')]
            """
            print(url)
            
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            callAPI(url: encodedUrl!) { [self] (json, data) in
                print(json)
                if json.getString(key: "Response") == "Success" {
                    showToast(message: "Routine created successfully!")
                    self.fillData_1(index: intSegmentCount)
                }
            }
        }
    }
    
    func fillData_1(index: Int) {
        
        if arrSegmentList.count > 0 {
            let segmentData = arrSegmentList[index]
            
            let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
            let strLeftTool: String = segmentData.getString(key: "tool_l")
            let strRightTool: String = segmentData.getString(key: "tool_r")
            let strLeftPath: String = segmentData.getString(key: "path_l")
            let strRightPath: String = segmentData.getString(key: "path_r")
            let strLeftLoction: String = segmentData.getString(key: "location_l")
            let strRightLocation: String = segmentData.getString(key: "location_r")
            let strExTime: String = segmentData.getString(key: "duration")
            let strRightForce: String = segmentData.getString(key: "force_r")
            let strLeftForce: String = segmentData.getString(key: "force_l")
            let strLeftSpeed: String = segmentData.getString(key: "speed_l")
            let strRightSpeed: String = segmentData.getString(key: "speed_r")
                            
            let now = Date()

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"

            let datetime = formatter.string(from: now)
            print(datetime)

            let timeAndDate = datetime.components(separatedBy: " ")

            let strDate: String = String(format: "%@", timeAndDate[0])
            let strTime: String = String(format: "%@", timeAndDate[1])
            
            if userID != "" {
                let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=RoutineEntity&row=[('sagmet\(randomSegmentId())','\(strExTime)','\(strLeftForce)','\(strRightForce)','\(strLeftLoction)','\(strRightLocation)','\(strLeftPath)','\(strRightPath)','\(strLeftSpeed)','\(strRightSpeed)','\(strDate),\(strTime)','\(strLeftTool)','\(strRightTool)','1','\(strRoutingID!)')]"

                print(url)

                let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                callAPI(url: encodedUrl!) { [self] (json, data1) in
                    print(json)
                    if json.getString(key: "Response") == "Success" {
                        
                        intSegmentCount+=1
                        if intSegmentCount < arrSegmentList.count{
                            self.fillData(index: intSegmentCount)
                        }else {
                            showToast(message: "Routine segment added successfully!")
                        }
                    }
                }
            }
        }
    }
    */
    
    func addRoutineSegmentView() {

        let viewRoutine = RoutineParam.instanceFromNib()
        viewRoutine.delegate = self
        viewRoutine.delegateRuler = self
        viewRoutine.delegateLocation = self
        viewRoutine.delegateChangeData = self
        viewRoutine.delegateCopyData = self
        delegateCopyData = viewRoutine
        delegate = viewRoutine
        svContainer.delegate = self
        delegateLocation = viewRoutine
        viewRoutine.currentViewTag = numberOfRoutine
        svContainer.addSubview(viewRoutine)
        svContainer.contentSize = CGSize(width: screenWidth * 1, height: viewRoutine.frame.height)
        numberOfRoutine += 1
        arrRoutines.append(viewRoutine)
        viewRoutine.tag = arrRoutines.count

        if isLink == false {
            delegateCopyData?.setSegmentDataCopy(isLink: false, iscopy: false)
        }else {
            delegateCopyData?.setSegmentDataCopy(isLink: true, iscopy: false)
        }
        
        let view = UIView(frame: CGRect(x: 12, y: 32, width: 28, height: 36))
        view.backgroundColor = UIColor.SegmentCountBGColor

        let lblSegCount = UILabel(frame: CGRect(x: 4, y: 8, width: 20, height: 20))
        lblSegCount.font = lblSegCount.font.withSize(10)
        lblSegCount.textAlignment = .center
        lblSegCount.text = "01"
        lblSegCount.textColor = UIColor.black
        lblSegCount.backgroundColor = UIColor.white
        lblSegCount.layer.masksToBounds = true
        lblSegCount.layer.cornerRadius = 10.0

        view.addSubview(lblSegCount)
        viewRuler.addSubview(view)
        arrRuler.append(view)

        UserDefaults.standard.set("0", forKey: RULERWIDTH)
    }

    func getRoutinSegmentDataListServiceCall() {

        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Routineentity where routineID = '\(strRoutingID!)''"

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
                        intCurrentIndex = arrSegmentList.count
                        
                        for i in 0..<arrSegmentList.count + 1 {
                            if i > 0 {
                                self.addNewSegmentView()
                            }
                            self.fillData(index: i)
                        }
                        if arrSegmentList.count > 0
                        {
                            let FirstIndex = arrSegmentList[0] as NSDictionary
                            let Location_R = FirstIndex["location_r"] as? String ?? ""
                            let Location_L = FirstIndex["location_l"] as? String ?? ""
                            self.SetImagePart(Location_L: Location_L, Location_R: Location_R)
                        }
                      
                        self.svContainer.setContentOffset(.zero, animated: false)
                        self.changeColorOfRuler(index: 1)
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
        if svContainer.subviews.count >= index, let view1 = svContainer.subviews.first(where: { ($0 as? RoutineParam)?.currentViewTag == index }) as? RoutineParam, arrSegmentList.count > index {

            let segmentData = arrSegmentList[index]

            if index > 10 {
                view1.lblSegmentNo.text = String(format: "%d", index)
            }else {
                view1.lblSegmentNo.text = String(format: "0%d", index)
            }

            view1.lblSegmentStart.text = segmentData.getString(key: "")
            view1.lblSegmentEnd.text = segmentData.getString(key: "")

            let size_du = (segmentData.getString(key: "duration") as NSString).integerValue

            if size_du >= 60 {

                let size_Cal = size_du/60

                let view = arrRuler[index]
                view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: CGFloat(28 * size_Cal), height: view.frame.height)
                intRuler = 28 * size_Cal
                isRulerAdd = true
                arrRuler[index] = view

                view1.txtTime.text = String(format: "%d", size_Cal)
            }else {
                view1.txtTime.text = segmentData.getString(key: "duration")
            }

            view1.txtLeftTool.text = segmentData.getString(key: "tool_l")
            view1.txtRightTool.text = segmentData.getString(key: "tool_r")
            view1.txtLeftPath.text = segmentData.getString(key: "path_l")
            view1.txtRightPath.text = segmentData.getString(key: "path_r")
            view1.txtLeftLocation.text = segmentData.getString(key: "location_l")
            view1.txtRightLocation.text = segmentData.getString(key: "location_r")

            view1.btnLocationLeft.setTitleColor(.black, for: .normal)
            view1.btnLocationLeft.setTitle(segmentData.getString(key: "location_l"), for: .normal)

            view1.btnLocationRight.setTitleColor(.black, for: .normal)
            view1.btnLocationRight.setTitle(segmentData.getString(key: "location_r"), for: .normal)

            let speed_l = (segmentData.getString(key: "speed_l") as NSString).floatValue
            let speed_r = (segmentData.getString(key: "speed_r") as NSString).floatValue
            let force_l = (segmentData.getString(key: "force_l") as NSString).floatValue
            let force_r = (segmentData.getString(key: "force_r") as NSString).floatValue

            view1.sliderValueSet(value: speed_l, strAction: "", index: 0)
            view1.sliderValueSet(value: speed_r, strAction: "", index: 1)
            view1.sliderValueSet(value: force_l, strAction: "", index: 2)
            view1.sliderValueSet(value: force_r, strAction: "", index: 3)

            viewSliderPopup.isHidden = true

            UserDefaults.standard.set(view1.txtLeftTool.text, forKey: LTOOL)
            UserDefaults.standard.set(view1.txtRightTool.text, forKey: RTOOL)
            UserDefaults.standard.set(view1.txtLeftPath.text, forKey: LPATH)
            UserDefaults.standard.set(view1.txtRightPath.text, forKey: RPATH)
            UserDefaults.standard.set(view1.lblSegmentEnd.text, forKey: EXTIME)
            UserDefaults.standard.set(segmentData.getString(key: "location_l"), forKey: LLOCATION)
            UserDefaults.standard.set(segmentData.getString(key: "location_r"), forKey: RLOCATION)

            strLeftForce = segmentData.getString(key: "force_l")
            strRightForce = segmentData.getString(key: "force_r")
            strLeftSpeed = segmentData.getString(key: "speed_l")
            strRightSpeed = segmentData.getString(key: "speed_r")
            
            let Location_R = arrSegmentList[index]["location_r"] as? String ?? ""
            let Location_L = arrSegmentList[index]["location_l"] as? String ?? ""
            self.SetImagePart(Location_L: Location_L, Location_R: Location_R)
            
           
        }
        else if svContainer.subviews.count >= index, let view1 = svContainer.subviews.first(where: { ($0 as? RoutineParam)?.currentViewTag == index }) as? RoutineParam, arrSaveLocation.count > index
        {
//            if arrSaveLocation.count == arrRoutines.count - 1 &&  arrSaveLocation.count < index
//            {
                let Location_R = arrSaveLocation[index]["location_r"] as? String ?? ""
                let Location_L = arrSaveLocation[index]["location_l"] as? String ?? ""
                self.SetImagePart(Location_L: Location_L, Location_R: Location_R)
//            }
            
        }
        else
        {
            self.ImageLeft.image = UIImage(named: "")
            self.ImageRight.image = UIImage(named: "")
        }
        
        
    }
    
    

    @IBAction func btnCopyRoutineAction(_ sender: UIButton) {
//        self.setAddRoutineServiceCall()
        
        if btnLinkUnLink.isSelected == false {
            btnLinkUnLink.isSelected = true
            isLink = false
            isCopy = true
            UserDefaults.standard.set("false", forKey: SEGMENTCOPY)
            delegateCopyData?.setSegmentDataCopy(isLink: isLink, iscopy: isCopy)
        }else {
            btnLinkUnLink.isSelected = false
            isLink = true
            isCopy = false
            UserDefaults.standard.set("true", forKey: SEGMENTCOPY)
            delegateCopyData?.setSegmentDataCopy(isLink: isLink, iscopy: isCopy)
        }
    }
    
    @IBAction func btnBackToHome(_ sender: UIButton) {

        if strPath == "CreateRoutine" {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {

        sender.value = roundf(sender.value)

        let trackRect = sender.trackRect(forBounds: sender.frame)
        let thumbRect = sender.thumbRect(forBounds: sender.bounds, trackRect: trackRect, value: sender.value)
        lblSliderValue.center = CGPoint(x: thumbRect.midX, y: lblSliderValue.center.y)

        lblSliderValue.text = "\(Int(sender.value))"
    }

    @IBAction func btnPopupClose(_ sender: UIButton) {
        print("Slider Value \(sliderValue)")
        viewSliderPopup.isHidden = true

        isUpdateSegmentData = true

        if strSliderValue == "LeftSpeed" {
            strLeftSpeed = String(format: "%.f", slider.value)
            strRightSpeed = String(format: "%.f", slider.value)
            delegate?.sliderValueSet(value: slider.value, strAction: "", index: 0)
            
            if isLink == true {
                strRightSpeed = String(format: "%.f", slider.value)
                strLeftSpeed = String(format: "%.f", slider.value)
                delegate?.sliderValueSet(value: slider.value, strAction: "", index: 1)
            }
        }else if strSliderValue == "RightSpeed" {
            strRightSpeed = String(format: "%.f", slider.value)
            strLeftSpeed = String(format: "%.f", slider.value)
            delegate?.sliderValueSet(value: slider.value, strAction: "", index: 1)
            
            if isLink == true {
                strLeftSpeed = String(format: "%.f", slider.value)
                strRightSpeed = String(format: "%.f", slider.value)
                delegate?.sliderValueSet(value: slider.value, strAction: "", index: 0)
            }
        }else if strSliderValue == "LeftForce" {
            strLeftForce = String(format: "%.f", slider.value)
            strRightForce = String(format: "%.f", slider.value)
            delegate?.sliderValueSet(value: slider.value, strAction: "", index: 2)
            
            if isLink == true {
                strLeftForce = String(format: "%.f", slider.value)
                strRightForce = String(format: "%.f", slider.value)
                delegate?.sliderValueSet(value: slider.value, strAction: "", index: 3)
            }
        }else {
            strLeftForce = String(format: "%.f", slider.value)
            strRightForce = String(format: "%.f", slider.value)
            delegate?.sliderValueSet(value: slider.value, strAction: "", index: 3)
            
            if isLink == true {
                strLeftForce = String(format: "%.f", slider.value)
                strRightForce = String(format: "%.f", slider.value)
                delegate?.sliderValueSet(value: slider.value, strAction: "", index: 2)
            }
        }
    }

    func setRemoveSegmentServiceCall() {

        let segmentData = arrSegmentList[intCurrentIndex]

        let strSegmentID: String = String(format: "%@", segmentData.getString(key: "segmentid"))

        if strSegmentID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='DELETE FROM Routineentity WHERE segmentid='\(strSegmentID)''"

            print(url)

            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                self.hideLoading()
                if json.getString(key: "Response") == "DELETE query executed Successfully"
                {
                    showToast(message: "Segment delete successfully")
                }
            }
        }
    }

    @IBAction func btnMinusAction(_ sender: UIButton) {

        if arrRoutines.count != 1 {

            numberOfRoutine -= 1
            intCurrentIndex -= 1
            
            let viewRoutine = arrRoutines.removeLast()
            viewRoutine.removeFromSuperview()

            if viewRuler.subviews.count > 1, let view1 = viewRuler.subviews[viewRuler.subviews.count - 1] as? UIView {
                view1.removeFromSuperview()
                self.changeColorOfRuler(index: viewRuler.subviews.count - 1)
            }

            if svContainer.subviews.count >= numberOfRoutine, let view1 = svContainer.subviews.first(where: { ($0 as? RoutineParam)?.currentViewTag == numberOfRoutine }) as? RoutineParam, arrSegmentList.count > numberOfRoutine {
                view1.removeFromSuperview()
            }

            let strRulerWidth: String = UserDefaults.standard.object(forKey: RULERWIDTH) as? String ?? "0"

            let intRWidth = Int(strRulerWidth)

            intStoreRuler = intRWidth! - 28

            UserDefaults.standard.set("\(intStoreRuler)", forKey: RULERWIDTH)

            svContainer.contentSize = CGSize(width: screenWidth * CGFloat(numberOfRoutine), height: viewRoutine.frame.height)
            
            
            self.setRemoveSegmentServiceCall()
        }
    }

    @IBAction func btnPlusAction(_ sender: UIButton) {
        
        if strPath == "NotCreateRoutine" {
            
//            if isUpdateSegmentData == true && arrSegmentList.count < IndexData //arrSegmentList.count == IndexData + 2
//            {
//                self.addNewSegmentView()
//            }
//            else
//            {
//                self.addNewSegmentIntoRoutine()
//            }
            if arrSegmentList.count < intCurrentIndex + 1
            {
                self.addNewSegmentIntoRoutine()
            }else {
                 intCurrentIndex += 1
                self.addNewSegmentView()
            }
        }else {
            self.addNewSegmentIntoRoutine()
        }
    }

    func addNewSegmentIntoRoutine() {

        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        let strLeftTool: String = UserDefaults.standard.object(forKey: LTOOL) as? String ?? ""
        let strRightTool: String = UserDefaults.standard.object(forKey: RTOOL) as? String ?? ""
        let strLeftPath: String = UserDefaults.standard.object(forKey: LPATH) as? String ?? ""
        let strRightPath: String = UserDefaults.standard.object(forKey: RPATH) as? String ?? ""
        let strLeftLoction: String = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let strRightLocation: String = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        var strExTime: String = UserDefaults.standard.object(forKey: EXTIME) as? String ?? "60"
        let strSegCount: String = UserDefaults.standard.object(forKey: SEGMENTCOUNT) as? String ?? "1"

        if strExTime == "" {
            strExTime = "60"
        }

        let now = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let datetime = formatter.string(from: now)
        print(datetime)

        let timeAndDate = datetime.components(separatedBy: " ")

        let strDate: String = String(format: "%@", timeAndDate[0])
        let strTime: String = String(format: "%@", timeAndDate[1])

        if strLeftTool == ""
        {
            showToast(message: "Please insert left tool.")
            return
        }

        if strRightTool == ""
        {
            showToast(message: "Please insert right tool.")
            return
        }


        if strLeftLoction == ""
        {
            showToast(message: "Please insert left loction.")
            return
        }

        if strRightLocation == ""
        {
            showToast(message: "Please insert right loction.")
            return
        }

        if strLeftPath == ""
        {
            showToast(message: "Please insert left path.")
            return
        }

        if strRightPath == ""
        {
            showToast(message: "Please insert right path.")
            return
        }

        if strLeftSpeed == ""
        {
            showToast(message: "Please insert left Speed.")
            return
        }

        if strRightSpeed == ""
        {
            showToast(message: "Please insert right Speed.")
            return
        }

        if strLeftForce == ""
        {
            showToast(message: "Please insert left Force.")
            return
        }

        if strRightForce == ""
        {
            showToast(message: "Please insert right Force.")
            return
        }

//        https://massage-robotics-website.uc.r.appspot.com/wt?tablename=RoutineEntity&row=[('sagmet3qiZJMzCncH0Zuk7M7hr','1','23','76','iliotibal tract','Hamstring','Linear','Circular','48','55','2021-03-19,12:42','Inline','Point','1','oapuvvjy6ln1w9wioqv4')]

        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=RoutineEntity&row=[('sagmet\(randomSegmentId())','\(strExTime)','\(strLeftForce)','\(strRightForce)','\(strLeftLoction.lowercased())','\(strRightLocation.lowercased())','\(strLeftPath)','\(strRightPath)','\(strLeftSpeed)','\(strRightSpeed)','\(strDate),\(strTime)','\(strLeftTool)','\(strRightTool)','\(strSegCount)','\(strRoutingID!)')]"

            print(url)
            
            let Location_L = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
            let Location_R = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
            let Dict = ["location_r":Location_R.lowercased(),"location_l":Location_L.lowercased()]
            self.arrSaveLocation.append(Dict)
            
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                self.ImageLeft.image = UIImage(named: "")
                self.ImageRight.image = UIImage(named: "")
                self.hideLoading()
                if json.getString(key: "Response") == "Success"
                {
                    UserDefaults.standard.set("", forKey: LTOOL)
                    UserDefaults.standard.set("", forKey: RTOOL)
                    UserDefaults.standard.set("", forKey: LPATH)
                    UserDefaults.standard.set("", forKey: RPATH)
                    UserDefaults.standard.set("", forKey: LLOCATION)
                    UserDefaults.standard.set("", forKey: RLOCATION)
                    UserDefaults.standard.set("", forKey: EXTIME)

                    strLeftSpeed = ""
                    strRightSpeed = ""
                    strLeftForce = ""
                    strRightForce = ""

//                    self.addNewSegmentView()
                    let viewRoutine = RoutineParam.instanceFromNib()

                    viewRoutine.delegate = self
                    delegate = viewRoutine
                    viewRoutine.delegateChangeData = self
                    viewRoutine.delegateLocation = self
                    delegateLocation = viewRoutine
                    viewRoutine.delegateRuler = self
                    viewRoutine.delegateCopyData = self
                    delegateCopyData = viewRoutine
                    viewRoutine.frame = CGRect(x: screenWidth * CGFloat(numberOfRoutine), y: 0, width: screenWidth, height: viewRoutine.frame.height)

                    if isLink == false {
                        delegateCopyData?.setSegmentDataCopy(isLink: false, iscopy: false)
                    }else {
                        delegateCopyData?.setSegmentDataCopy(isLink: true, iscopy: false)
                    }
                    
                    viewRoutine.currentViewTag = numberOfRoutine
                    svContainer.addSubview(viewRoutine)
                    arrRoutines.append(viewRoutine)
                    viewRoutine.tag = arrRoutines.count

                    numberOfRoutine += 1

                    svContainer.contentSize = CGSize(width: screenWidth * CGFloat(numberOfRoutine), height: viewRoutine.frame.height)
            //        if strPath != "NotCreateRoutine" {
                        if isRulerAdd == false {
                            intRuler = 28
                        }else {
                            isRulerAdd = false
                        }
            //        }

                    let strRulerWidth: String = UserDefaults.standard.object(forKey: RULERWIDTH) as? String ?? "0"

                    let intRWidth = Int(strRulerWidth)

                    intStoreRuler = intRWidth! + intRuler

                    UserDefaults.standard.set("\(intStoreRuler)", forKey: RULERWIDTH)

                    let view = UIView(frame: CGRect(x: 12 + intStoreRuler, y: 32, width: 28, height: 36))

                    let i = viewRuler.subviews.count

                    view.backgroundColor = UIColor.SegmentCountBGColor

                    let lblSegCount = UILabel(frame: CGRect(x: 4, y: 8, width: 20, height: 20))
                    lblSegCount.font = lblSegCount.font.withSize(10)
                    lblSegCount.textAlignment = .center

                    var strSegCo: String = ""

                    if i+1 > 10 {
                        lblSegCount.text = String(format: "%d", i)
                        strSegCo = String(format: "%d", i)
                    }else {
                        lblSegCount.text = String(format: "0%d", i)
                        strSegCo = String(format: "%d", i)
                    }

                    UserDefaults.standard.set(strSegCo, forKey: SEGMENTCOUNT)

                    lblSegCount.textColor = UIColor.black
                    lblSegCount.backgroundColor = UIColor.white
                    lblSegCount.layer.masksToBounds = true
                    lblSegCount.layer.cornerRadius = 10.0

                    view.addSubview(lblSegCount)

                    viewRuler.addSubview(view)
                    arrRuler.append(view)

                    viewRuler.subviews.map({  if !$0.isKind(of: UIImageView.self) { $0.backgroundColor = UIColor.btnBGColor } })

                    if let viewLast = viewRuler.subviews.last as? UIView {
                        viewLast.backgroundColor = UIColor.SegmentCountBGColor
                    }
                    svContainer.contentOffset.x = screenWidth * CGFloat(Double(numberOfRoutine) - 1.0)
                }
            }
        }
    }

    func addNewSegmentView() {

        let strLeftTool: String = UserDefaults.standard.object(forKey: LTOOL) as? String ?? ""
        let strRightTool: String = UserDefaults.standard.object(forKey: RTOOL) as? String ?? ""
        let strLeftPath: String = UserDefaults.standard.object(forKey: LPATH) as? String ?? ""
        let strRightPath: String = UserDefaults.standard.object(forKey: RPATH) as? String ?? ""
        let strLeftLoction: String = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let strRightLocation: String = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        var strExTime: String = UserDefaults.standard.object(forKey: EXTIME) as? String ?? "60"

        if strExTime == "" {
            strExTime = "60"
        }

        if strLeftTool == ""
        {
            showToast(message: "Please insert left tool.")
            return
        }

        if strRightTool == ""
        {
            showToast(message: "Please insert right tool.")
            return
        }

        if strLeftLoction == ""
        {
            showToast(message: "Please insert left loction.")
            return
        }

        if strRightLocation == ""
        {
            showToast(message: "Please insert right loction.")
            return
        }

        if strLeftPath == ""
        {
            showToast(message: "Please insert left path.")
            return
        }

        if strRightPath == ""
        {
            showToast(message: "Please insert right path.")
            return
        }

        if strLeftSpeed == ""
        {
            showToast(message: "Please insert left Speed.")
            return
        }

        if strRightSpeed == ""
        {
            showToast(message: "Please insert right Speed.")
            return
        }

        if strLeftForce == ""
        {
            showToast(message: "Please insert left Force.")
            return
        }

        if strRightForce == ""
        {
            showToast(message: "Please insert right Force.")
            return
        }

        if isUpdateSegmentData == true && arrSegmentList.count >= intCurrentIndex - 1
        {

            isUpdateSegmentData = false

            let segmentData = arrSegmentList[IndexData]//arrSegmentList[intCurrentIndex]

            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='UPDATE Routineentity SET duration= '\(strExTime)',force_l= '\(strLeftForce)',force_r= '\(strRightForce)',location_l= '\(strLeftLoction.lowercased())',location_r= '\(strRightLocation.lowercased())',path_l= '\(strLeftPath)',path_r= '\(strRightPath) ',speed_l= '\(strLeftSpeed)',speed_r= '\(strRightSpeed)',tool_l= '\(strLeftTool)',tool_r= '\(strRightTool)' WHERE segmentid= '\(segmentData.getString(key: "segmentid"))''"

                print(url)

                let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                callAPI(url: encodedUrl!) { [self] (json, data1) in
                    print(json)
                    self.hideLoading()
                    if json.getString(key: "Response") == "UPDATE query executed Successfully"
                    {
                        UserDefaults.standard.set("", forKey: LTOOL)
                        UserDefaults.standard.set("", forKey: RTOOL)
                        UserDefaults.standard.set("", forKey: LPATH)
                        UserDefaults.standard.set("", forKey: RPATH)
                        UserDefaults.standard.set("", forKey: LLOCATION)
                        UserDefaults.standard.set("", forKey: RLOCATION)
                        UserDefaults.standard.set("", forKey: EXTIME)

                        strLeftSpeed = ""
                        strRightSpeed = ""
                        strLeftForce = ""
                        strRightForce = ""

                        showToast(message: "Segment Updated Successfully.")

                        let viewRoutine = RoutineParam.instanceFromNib()

                        viewRoutine.delegate = self
                        delegate = viewRoutine
                        viewRoutine.delegateChangeData = self
                        viewRoutine.delegateLocation = self
                        delegateLocation = viewRoutine
                        viewRoutine.delegateRuler = self
                        viewRoutine.delegateCopyData = self
                        delegateCopyData = viewRoutine
                        viewRoutine.frame = CGRect(x: screenWidth * CGFloat(numberOfRoutine), y: 0, width: screenWidth, height: viewRoutine.frame.height)

                        viewRoutine.currentViewTag = numberOfRoutine
                        svContainer.addSubview(viewRoutine)
                        arrRoutines.append(viewRoutine)
                        viewRoutine.tag = arrRoutines.count

                        numberOfRoutine += 1

                        svContainer.contentSize = CGSize(width: screenWidth * CGFloat(numberOfRoutine), height: viewRoutine.frame.height)
                //        if strPath != "NotCreateRoutine" {
                            if isRulerAdd == false {
                                intRuler = 28
                            }else {
                                isRulerAdd = false
                            }
                //        }

                        let strRulerWidth: String = UserDefaults.standard.object(forKey: RULERWIDTH) as? String ?? "0"

                        let intRWidth = Int(strRulerWidth)

                        intStoreRuler = intRWidth! + intRuler

                        UserDefaults.standard.set("\(intStoreRuler)", forKey: RULERWIDTH)

                        let view = UIView(frame: CGRect(x: 12 + intStoreRuler, y: 32, width: 28, height: 36))

                        let i = viewRuler.subviews.count

                        view.backgroundColor = UIColor.SegmentCountBGColor

                        let lblSegCount = UILabel(frame: CGRect(x: 4, y: 8, width: 20, height: 20))
                        lblSegCount.font = lblSegCount.font.withSize(10)
                        lblSegCount.textAlignment = .center

                        if i+1 > 10 {
                            lblSegCount.text = String(format: "%d", i)
                        }else {
                            lblSegCount.text = String(format: "0%d", i)
                        }

                        lblSegCount.textColor = UIColor.black
                        lblSegCount.backgroundColor = UIColor.white
                        lblSegCount.layer.masksToBounds = true
                        lblSegCount.layer.cornerRadius = 10.0

//                        view.addSubview(lblSegCount)
//
//                        viewRuler.addSubview(view)
//                        arrRuler.append(view)

                        viewRuler.subviews.map({  if !$0.isKind(of: UIImageView.self) { $0.backgroundColor = UIColor.btnBGColor } })

                        if let viewLast = viewRuler.subviews.last as? UIView {
                            viewLast.backgroundColor = UIColor.SegmentCountBGColor
                        }
                        svContainer.contentOffset.x = screenWidth * CGFloat(Double(numberOfRoutine) - 1.0)
                      //  getRoutinSegmentDataListUpdate()
                    }
                }
        }else {

            UserDefaults.standard.set("", forKey: LTOOL)
            UserDefaults.standard.set("", forKey: RTOOL)
            UserDefaults.standard.set("", forKey: LPATH)
            UserDefaults.standard.set("", forKey: RPATH)
            UserDefaults.standard.set("", forKey: LLOCATION)
            UserDefaults.standard.set("", forKey: RLOCATION)
            UserDefaults.standard.set("", forKey: EXTIME)

            strLeftSpeed = ""
            strRightSpeed = ""
            strLeftForce = ""
            strRightForce = ""

            let viewRoutine = RoutineParam.instanceFromNib()

            viewRoutine.delegate = self
            delegate = viewRoutine
            viewRoutine.delegateChangeData = self
            viewRoutine.delegateLocation = self
            delegateLocation = viewRoutine
            viewRoutine.delegateRuler = self
            viewRoutine.delegateCopyData = self
            delegateCopyData = viewRoutine
            viewRoutine.frame = CGRect(x: screenWidth * CGFloat(numberOfRoutine), y: 0, width: screenWidth, height: viewRoutine.frame.height)

            viewRoutine.currentViewTag = numberOfRoutine
            svContainer.addSubview(viewRoutine)
            arrRoutines.append(viewRoutine)
            viewRoutine.tag = arrRoutines.count

            numberOfRoutine += 1
            
            svContainer.contentSize = CGSize(width: screenWidth * CGFloat(numberOfRoutine), height: viewRoutine.frame.height)
    //        if strPath != "NotCreateRoutine" {
                if isRulerAdd == false {
                    intRuler = 28
                }else {
                    isRulerAdd = false
                }
    //        }

            let strRulerWidth: String = UserDefaults.standard.object(forKey: RULERWIDTH) as? String ?? "0"

            let intRWidth = Int(strRulerWidth)

            intStoreRuler = intRWidth! + intRuler

            UserDefaults.standard.set("\(intStoreRuler)", forKey: RULERWIDTH)

            let view = UIView(frame: CGRect(x: 12 + intStoreRuler, y: 32, width: 28, height: 36))

            let i = viewRuler.subviews.count

            view.backgroundColor = UIColor.SegmentCountBGColor

            let lblSegCount = UILabel(frame: CGRect(x: 4, y: 8, width: 20, height: 20))
            lblSegCount.font = lblSegCount.font.withSize(10)
            lblSegCount.textAlignment = .center

            var strSegCo: String = ""

            if i+1 > 10 {
                lblSegCount.text = String(format: "%d", i)
                strSegCo = String(format: "%d", i)
            }else {
                lblSegCount.text = String(format: "0%d", i)
                strSegCo = String(format: "%d", i)
            }

            UserDefaults.standard.set(strSegCo, forKey: SEGMENTCOUNT)

            lblSegCount.textColor = UIColor.black
            lblSegCount.backgroundColor = UIColor.white
            lblSegCount.layer.masksToBounds = true
            lblSegCount.layer.cornerRadius = 10.0

            view.addSubview(lblSegCount)

            viewRuler.addSubview(view)
            arrRuler.append(view)

            viewRuler.subviews.map({  if !$0.isKind(of: UIImageView.self) { $0.backgroundColor = UIColor.btnBGColor } })

            if let viewLast = viewRuler.subviews.last as? UIView {
                viewLast.backgroundColor = UIColor.SegmentCountBGColor
            }
            svContainer.contentOffset.x = screenWidth * CGFloat(Double(numberOfRoutine) - 1.0)
        }
    }

    @IBAction func btnLocationPopUpClose(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
    }

    @IBAction func btnBodyPartPectoralisAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Pectoralis", for: .normal)
        data.btnLocationRight.setTitle("Pectoralis", for: .normal)
        
        self.selectBodyPartToHiddenView()
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Pectoralis", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
        
        
    }

    @IBAction func btnBodyPartQuadraceptsAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Quadracepts", for: .normal)
        data.btnLocationRight.setTitle("Quadracepts", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Quadracepts", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
        
       
        
    }

    @IBAction func btnBodyPartIliotibalTractAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("iliotibal tract", for: .normal)
        data.btnLocationRight.setTitle("iliotibal tract", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "iliotibal tract", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnBodyPartTibalisAnteriorAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Tibalis Anterior", for: .normal)
        data.btnLocationRight.setTitle("Tibalis Anterior", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Tibalis Anterior", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnBodyPartBodyparamAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("bodyparam", for: .normal)
        data.btnLocationRight.setTitle("bodyparam", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "bodyparam", currentIndex: intCurrentIndex )
        
    }

    @IBAction func btnBodyPartDeltoidAction(_ sender: UIButton) {
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Deltoid", for: .normal)
        data.btnLocationRight.setTitle("Deltoid", for: .normal)

        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Deltoid", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnBodyPartUpperbackAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Upperback", for: .normal)
        data.btnLocationRight.setTitle("Upperback", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Upperback", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnBodyPartLowerbackAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Lowerback", for: .normal)
        data.btnLocationRight.setTitle("Lowerback", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Lowerback", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnBodyPartGlutiusmaximusAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Glutiusmaximus", for: .normal)
        data.btnLocationRight.setTitle("Glutiusmaximus", for: .normal)

        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Glutiusmaximus", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnBodyPartHamstringAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Hamstring", for: .normal)
        data.btnLocationRight.setTitle("Hamstring", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Hamstring", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnBodyPartGastrocnemiusAction(_ sender: UIButton) {
        isUpdateSegmentData = true
        self.selectBodyPartToHiddenView()
        let data = arrRoutines[self.IndexData]
        data.btnLocationLeft.setTitle("Gastrocnemius", for: .normal)
        data.btnLocationRight.setTitle("Gastrocnemius", for: .normal)
        
        delegateLocation?.locationViewAnimation(strLRLocation: strLocationAction, strBodyPart: "Gastrocnemius", currentIndex: intCurrentIndex)
        let LLocation = UserDefaults.standard.object(forKey: LLOCATION) as? String ?? ""
        let RLocation = UserDefaults.standard.object(forKey: RLOCATION) as? String ?? ""
        self.SetImagePart(Location_L: LLocation.lowercased(), Location_R: RLocation.lowercased())
    }

    @IBAction func btnFirstSegmentAction(_ sender: UIButton)
    {
        if strPath == "NotCreateRoutine"
        {
            let viewRoutine = RoutineParam.instanceFromNib()
            viewRoutine.delegate = self
            delegate = viewRoutine
            viewRoutine.delegateChangeData = self
            viewRoutine.delegateLocation = self
            delegateLocation = viewRoutine
            viewRoutine.delegateRuler = self
            viewRoutine.delegateCopyData = self
            delegateCopyData = viewRoutine
            viewRoutine.frame = CGRect(x: screenWidth * CGFloat(0), y: 0, width: screenWidth, height: viewRoutine.frame.height)

            viewRoutine.currentViewTag = 0
            svContainer.addSubview(viewRoutine)
            arrRoutines.append(viewRoutine)
            viewRoutine.tag = arrRoutines.count

        }else
        {
            let viewRoutine = RoutineParam.instanceFromNib()
            viewRoutine.delegate = self
            delegate = viewRoutine
            viewRoutine.delegateChangeData = self
            viewRoutine.delegateLocation = self
            delegateLocation = viewRoutine
            viewRoutine.delegateRuler = self
            viewRoutine.delegateCopyData = self
            delegateCopyData = viewRoutine
            viewRoutine.frame = CGRect(x: screenWidth * CGFloat(0), y: 0, width: screenWidth, height: viewRoutine.frame.height)

            viewRoutine.currentViewTag = 0
            svContainer.addSubview(viewRoutine)
            arrRoutines.append(viewRoutine)
            viewRoutine.tag = arrRoutines.count
        }
        print("First Segment")
    }
    
    @IBAction func btnLastSegmentAction(_ sender: UIButton) {
//        let LastIndex = arrRoutines.count
//        if strPath == "NotCreateRoutine" {
//
//            intCurrentIndex = index
//            changeColorOfRuler(index: index + 1)
//
//            fillData(index: index)
//            }else {
//                let data = arrSegmentList[LastIndex]
//                self.IndexDataSwapDataSet(index: LastIndex, segmentData: data)
//            }
      //  print("Last Segment\(LastIndex)")
    }
    
    @IBAction func btnNextSegmentAction(_ sender: UIButton) {
        let index = intCurrentIndex + 1
        
        fillData(index: index)
        print("Next Click\(index)")
    }
    
    @IBAction func btnPreviousSegmentAction(_ sender: UIButton) {
        let index = intCurrentIndex - 1
        
        fillData(index: index)
        print("Previous Click\(index)")
    }
    
    func selectBodyPartToHiddenView()  {
        //viewLocation.animHide()

        self.viewLocationPopup.isHidden = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // This will be called every time the user scrolls the scroll view with their finger
        // so each time this is called, contentOffset should be different.

        //print("Scroll View")

        //Additional workaround here.
        
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("END Scrolling \(scrollView.contentOffset.x / scrollView.bounds.size.width)")
        let index: Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        print("Index Count:::\(index)")

            intCurrentIndex = index
        self.IndexData = index
            changeColorOfRuler(index: index + 1)

            fillData(index: index)
    }

    func changeColorOfRuler(index: Int) {
        viewRuler.subviews.map({  if !$0.isKind(of: UIImageView.self ) { $0.backgroundColor = UIColor.btnBGColor } })

        if let viewLast = viewRuler.subviews[index] as? UIView {
            viewLast.backgroundColor = UIColor.SegmentCountBGColor
        }
    }
}

extension CreateSegmentVC: isChangeDataDelegate {

    func setChangeSegmentData() {

        if strPath == "NotCreateRoutine" {
            isUpdateSegmentData = true
        }else {
            isUpdateSegmentData = false
        }
    }
}

extension CreateSegmentVC: SliderValueSetDelegate {
    func sliderValueSet(value: Float, strAction: String, index: Int) {
        strSliderValue = strAction
        viewSliderPopup.isHidden = false
        slider.value = Float(value)

        let trackRect = slider.trackRect(forBounds: slider.frame)
        let thumbRect = slider.thumbRect(forBounds: slider.bounds, trackRect: trackRect, value: slider.value)
        lblSliderValue.center = CGPoint(x: thumbRect.midX, y: lblSliderValue.center.y)
        lblSliderValue.text = "\(Int(slider.value))"
    }
}

extension CreateSegmentVC: RulerSizeDelegate {
    func rulerSize(size: Int, index: Int) {
        let view = arrRuler[index]
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: CGFloat(28 * size), height: view.frame.height)
        intRuler = 28 * size
        isRulerAdd = true
        arrRuler[index] = view
    }
}

extension CreateSegmentVC: LocationDelegate {
    func locationViewAnimation(strLRLocation: String, strBodyPart: String, currentIndex: Int) {
        viewLocationPopup.isHidden = false
        //viewLocation.animShow()

        strLocationAction = strLRLocation
    }
    
    
//    func locationViewAnimation(strLRLocation: String, strBodyPart: String, currentIndex: Int) {
//        viewLocationPopup.isHidden = false
//        //viewLocation.animShow()
//
//        strLocationAction = strLRLocation
//    }
}

extension CreateSegmentVC: isSegmentDataCopy {
    func setSegmentDataCopy(isLink: Bool, iscopy: Bool) {
        print("Data Print Copy")
    }
}

extension CreateSegmentVC
{
    private func SetImagePart(Location_L:String,Location_R:String)
    {
        
        if Location_L.isEmpty == true && Location_R.isEmpty == true
        {
            self.ImageLeft.image = UIImage(named: "")
            self.ImageRight.image = UIImage(named: "")
        }
        else
        {
            if arrUserDetail.count > 0 {
                let routingData = arrUserDetail[0]
                let Gender = routingData.getString(key: "gender")
                if Gender == "F"
                {
                    var ImageL = String()
                    var ImageR = String()
                    if Location_L == "upperback"
                    {
                        ImageL = "F-L-trap"
                    }
                    else if Location_L == "lowerback"
                    {
                        ImageL = "F-L-lower back"
                    }
                    else if Location_L == "hamstring"
                    {
                        ImageL = "F-L-ham"
                    }
                    else if Location_L == "gastrocnemius"
                    {
                        ImageL = "F-L-calf"
                    }
                    else if Location_L == "quadracepts"
                    {
                        ImageL = "F-L-quad"
                    }
                    else if Location_L == "iliotibal tract"
                    {
                        ImageL = "F-L-IT band"
                    }
                    else if Location_L == "tibalis anterior"
                    {
                        ImageL = "F-L-tibialis"
                    }
                    else if Location_L == "deltoid"
                    {
                        ImageL = "F-L-shoulder"
                    }
                    else if Location_L == "pectoralis"
                    {
                        ImageL = "F-L-pect"
                    }
                    else if Location_L == "glutiusmaximus"
                    {
                        ImageL = "F-L-glut"
                    }
                    
                    
                    
                    if Location_R == "upperback"
                    {
                        ImageR = "F-R-trap"
                    }
                    else if Location_R == "lowerback"
                    {
                        ImageR = "F-R-lower back"
                    }
                    else if Location_R == "hamstring"
                    {
                        ImageR = "F-R-ham"
                    }
                    else if Location_R == "gastrocnemius"
                    {
                        ImageR = "F-R-calf"
                    }
                    else if Location_R == "quadracepts"
                    {
                        ImageR = "F-R-quad"
                    }
                    else if Location_R == "iliotibal tract"
                    {
                        ImageR = "F-R-IT band"
                    }
                    else if Location_R == "tibalis anterior"
                    {
                        ImageR = "F-R-tibialis"
                    }
                    else if Location_R == "deltoid"
                    {
                        ImageR = "F-R-shoulder"
                    }
                    else if Location_R == "pectoralis"
                    {
                        ImageR = "F-R-pect"
                    }
                    else if Location_R == "glutiusmaximus"
                    {
                        ImageR = "F-R-glut"
                    }
                    self.ImageLeft.image = UIImage(named: ImageL)
                    self.ImageRight.image = UIImage(named: ImageR)
                }else{
                    var ImageL = String()
                    var ImageR = String()
                    if Location_L == "upperback"
                    {
                        ImageL = "L-trap"
                    }
                    else if Location_L == "lowerback"
                    {
                        ImageL = "L-lower back"
                    }
                    else if Location_L == "hamstring"
                    {
                        ImageL = "L-ham"
                    }
                    else if Location_L == "gastrocnemius"
                    {
                        ImageL = "L-calf"
                    }
                    else if Location_L == "quadracepts"
                    {
                        ImageL = "L-quad"
                    }
                    else if Location_L == "iliotibal tract"
                    {
                        ImageL = "L-IT band"
                    }
                    else if Location_L == "tibalis anterior"
                    {
                        ImageL = "L-tibialis"
                    }
                    else if Location_L == "deltoid"
                    {
                        ImageL = "L-shoulder"
                    }
                    else if Location_L == "pectoralis"
                    {
                        ImageL = "L-pect"
                    }
                    else if Location_L == "glutiusmaximus"
                    {
                        ImageL = "L-glut"
                    }
                    
                    
                    
                    if Location_R == "upperback"
                    {
                        ImageR = "R-trap"
                    }
                    else if Location_R == "lowerback"
                    {
                        ImageR = "R-lower back"
                    }
                    else if Location_R == "hamstring"
                    {
                        ImageR = "R-ham"
                    }
                    else if Location_R == "gastrocnemius"
                    {
                        ImageR = "R-calf"
                    }
                    else if Location_R == "quadracepts"
                    {
                        ImageR = "R-quad"
                    }
                    else if Location_R == "iliotibal tract"
                    {
                        ImageR = "R-IT band"
                    }
                    else if Location_R == "tibalis anterior"
                    {
                        ImageR = "R-tibialis"
                    }
                    else if Location_R == "deltoid"
                    {
                        ImageR = "R-shoulder"
                    }
                    else if Location_R == "pectoralis"
                    {
                        ImageR = "R-pect"
                    }
                    else if Location_R == "glutiusmaximus"
                    {
                        ImageR = "R-glut"
                    }
                    self.ImageLeft.image = UIImage(named: ImageL)
                    self.ImageRight.image = UIImage(named: ImageR)
                }
            }
        }
    }
    func CreateDataGetSegmant() {

        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Routineentity where routineID = '\(strRoutingID!)''"

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
                        if arrSegmentList.count > 0
                        {
                            let FirstIndex = arrSegmentList[0] as NSDictionary
                            let Location_R = FirstIndex["location_r"] as? String ?? ""
                            let Location_L = FirstIndex["location_l"] as? String ?? ""
                            self.SetImagePart(Location_L: Location_L, Location_R: Location_R)
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
    
    private func IndexDataSwapDataSet(index:Int,segmentData:[String:Any])
    {
        let view1 = svContainer.subviews.first(where: { ($0 as? RoutineParam)?.currentViewTag == index }) as? RoutineParam
        
        //let segmentData = arrSegmentList[index]

        if index > 10 {
            view1!.lblSegmentNo.text = String(format: "%d", index)
        }else {
            view1!.lblSegmentNo.text = String(format: "0%d", index)
        }

        view1!.lblSegmentStart.text = segmentData.getString(key: "")
        view1!.lblSegmentEnd.text = segmentData.getString(key: "")

        let size_du = (segmentData.getString(key: "duration") as NSString).integerValue

        if size_du >= 60 {

            let size_Cal = size_du/60

            let view = arrRuler[index]
            view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: CGFloat(28 * size_Cal), height: view.frame.height)
            intRuler = 28 * size_Cal
            isRulerAdd = true
            arrRuler[index] = view

            view1!.txtTime.text = String(format: "%d", size_Cal)
        }else {
            view1!.txtTime.text = segmentData.getString(key: "duration")
        }

        view1!.txtLeftTool.text = segmentData.getString(key: "tool_l")
        view1!.txtRightTool.text = segmentData.getString(key: "tool_r")
        view1!.txtLeftPath.text = segmentData.getString(key: "path_l")
        view1!.txtRightPath.text = segmentData.getString(key: "path_r")
        view1!.txtLeftLocation.text = segmentData.getString(key: "location_l")
        view1!.txtRightLocation.text = segmentData.getString(key: "location_r")

        view1!.btnLocationLeft.setTitleColor(.black, for: .normal)
        view1!.btnLocationLeft.setTitle(segmentData.getString(key: "location_l"), for: .normal)

        view1!.btnLocationRight.setTitleColor(.black, for: .normal)
        view1!.btnLocationRight.setTitle(segmentData.getString(key: "location_r"), for: .normal)

        let speed_l = (segmentData.getString(key: "speed_l") as NSString).floatValue
        let speed_r = (segmentData.getString(key: "speed_r") as NSString).floatValue
        let force_l = (segmentData.getString(key: "force_l") as NSString).floatValue
        let force_r = (segmentData.getString(key: "force_r") as NSString).floatValue

        view1!.sliderValueSet(value: speed_l, strAction: "", index: 0)
        view1!.sliderValueSet(value: speed_r, strAction: "", index: 1)
        view1!.sliderValueSet(value: force_l, strAction: "", index: 2)
        view1!.sliderValueSet(value: force_r, strAction: "", index: 3)

        viewSliderPopup.isHidden = true

        UserDefaults.standard.set(view1!.txtLeftTool.text, forKey: LTOOL)
        UserDefaults.standard.set(view1!.txtRightTool.text, forKey: RTOOL)
        UserDefaults.standard.set(view1!.txtLeftPath.text, forKey: LPATH)
        UserDefaults.standard.set(view1!.txtRightPath.text, forKey: RPATH)
        UserDefaults.standard.set(view1!.lblSegmentEnd.text, forKey: EXTIME)
        UserDefaults.standard.set(segmentData.getString(key: "location_l"), forKey: LLOCATION)
        UserDefaults.standard.set(segmentData.getString(key: "location_r"), forKey: RLOCATION)

        strLeftForce = segmentData.getString(key: "force_l")
        strRightForce = segmentData.getString(key: "force_r")
        strLeftSpeed = segmentData.getString(key: "speed_l")
        strRightSpeed = segmentData.getString(key: "speed_r")
    }
    
    func getRoutinSegmentDataListUpdate() {

        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Routineentity where routineID = '\(strRoutingID!)''"

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
                        intCurrentIndex = arrSegmentList.count
                        
                        if arrSegmentList.count > 0
                        {
                            let FirstIndex = arrSegmentList[0] as NSDictionary
                            let Location_R = FirstIndex["location_r"] as? String ?? ""
                            let Location_L = FirstIndex["location_l"] as? String ?? ""
                            self.SetImagePart(Location_L: Location_L, Location_R: Location_R)
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
}
