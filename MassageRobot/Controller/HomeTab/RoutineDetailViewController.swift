//
//  RoutineDetailViewController.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 29/06/21.
//

import UIKit
import TagListView
import Firebase
import IQKeyboardManagerSwift
import EasyTipView

class RoutineDetailViewController: UIViewController {
    
    @IBOutlet var constHeightSafeArea: NSLayoutConstraint!
    @IBOutlet var constHeightDetail: NSLayoutConstraint!
    @IBOutlet var constHeightAuther: NSLayoutConstraint!
    @IBOutlet var constHeightDate: NSLayoutConstraint!
    @IBOutlet var constHeightAilment: NSLayoutConstraint!
    @IBOutlet var constHeightSubCategory: NSLayoutConstraint!
    @IBOutlet var constHeightDescription: NSLayoutConstraint!
    @IBOutlet var constHeightTags: NSLayoutConstraint!
    
    @IBOutlet weak var imgRoutine: UIImageView!
        
    @IBOutlet weak var viewTagList: TagListView!
    @IBOutlet weak var viewTagListTemp: TagListView!
    
    @IBOutlet var btnAilment: UIButton!
    @IBOutlet var btnDescription: UIButton!
    @IBOutlet var btnTags: UIButton!
    @IBOutlet var btnDiseases: [UIButton]!
    @IBOutlet weak var btnSelectImage: UIButton!
    
    @IBOutlet var bottomBarView: UIView!
    @IBOutlet var routineDetailView: UIView!
    
    @IBOutlet weak var txtCategory: UnderlineTextField!
    @IBOutlet weak var txtSubCategory: UnderlineTextField!
    @IBOutlet weak var txtType: UnderlineTextField!
    @IBOutlet weak var txtUser: UnderlineTextField!
    @IBOutlet weak var txtNewTagName: UITextField!
    @IBOutlet weak var txtRoutineName: UITextField!
    @IBOutlet weak var txtAuthorName: UITextField!
    @IBOutlet weak var txtRoutineCreateTime: UITextField!
    @IBOutlet weak var lblAliment: UILabel!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var lblTagListTemp: UILabel!
    
    @IBOutlet weak var txtDescription: UITextView!
    
    var picker: UIPickerView!
    
    var arrSubCategoryList = [String]()
    var selectedDiseases = [String]()
    var detailSelectOPT = [String]()
    
    var strRoutingID: String!
    var strProImgName: String = ""
    var urlImgPath: NSURL!
    let storage = Storage.storage()
    
    let arrCategoryList = ["Activities","Ailments", "Browse", "Discover", "Lifestyle", "New Releases", "Performance", "Relaxation", "Sports", "Target Areas", "Therapy", "Wellness", "Workout"]
    
    let arrWorkOut = ["Gym", "Recovery", "Studio", "Warm up"]
    let arrWellness = ["Daily Wellness", "Sleep", "Wake"]
    let arrBrowse = ["Following", "Private", "Shared"]
    let arrAilments = ["Carpal Tunnel", "Knots", "Muscle Cramps", "Plantar Fascities", "Sciatica",  "Shin Splints"]
    let arrActivites = ["Driving", "Gaming", "Run", "Stairs", "Walk"]
    let arrLifeStyle = ["Break", "Jet Lag", "Travel", "Work From Home"]
    let arrSports = ["Baseball", "Basketball", "Cycling", "Football", "Golf", "Hockey", "Lacrose", "Softball", "Surfing", "Swim", "Tennis", "Volleyball"]
    let arrTASubCat = ["Abs", "Biceps", "Calves", "Chest", "Feet", "Forearms", "Glutes", "Hamstrings", "Hip Flexors", "Lower Back", "Neck", "Quads", "Shins", "Sholders", "Triceps", "Upper Back"]
    let arrDisSubCat = ["Introduction"]
    var arrType = ["Cranial Sacral Therapy", "Deep Tissue Massage", "Geriatric Massage", "Prenatal Massage", "Reflexology", "Sports Massage", "Swedish Massage", "Percussion Massage", "Trigger Point Acupressure"]
    var arrUser = ["Adult","Athlete","Geriatric", "Pregnant", "Youth"]
    var arrUserDetail = [[String: Any]]()
    let arrTools = ["Inline", "Omni", "Percussion", "Point", "Sport"]
    
    let arrPath = ["Circular", "Linear", "Point", "Random"]
    
    let arrDiseases = ["Anxiety", "Fatiue", "Headache/Migraines", "Inflammation", "Injury", "Insomnia", "Muscle Spasm", "Pain", "Relaxation", "Stress", "Hand", "Tension"]
    
    @IBOutlet weak var ImgBodyImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
        
        constHeightSafeArea.constant = 44.0
        constHeightAilment.constant = 46.0
        constHeightDescription.constant = 42.0
        constHeightTags.constant = 44.0
        constHeightSubCategory.constant = 40.0
        constHeightAuther.constant = 0.0
        constHeightDate.constant = 0.0
        
        self.getRoutineDetailHeight()
              
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        txtCategory.inputView = picker
        txtCategory.delegate = self
        
        txtSubCategory.inputView = picker
        txtSubCategory.delegate = self
        
        txtUser.inputView = picker
        txtUser.delegate = self
        
        txtType.inputView = picker
        txtType.delegate = self
        
        txtNewTagName.delegate = self
        viewTagList.delegate = self
        viewTagListTemp.delegate = self
        
        //txtCategory.text = "Activites"
        //txtSubCategory.text = "Driving"
        //txtType.text = "Cranial Sacral Therapy"
        //txtUser.text = "Athlete"
        
        lblAliment.text = "Select Aliment"
        lblAliment.textColor = UIColor.lightGray
           
        lbldescription.text = "Enter Description"
        lbldescription.textColor = UIColor.lightGray
        
        
        txtDescription.delegate = self
        txtRoutineCreateTime.delegate = self
        
        arrSubCategoryList.removeAll()
        arrSubCategoryList.append(contentsOf: arrActivites)
                
        let dfDisplay = DateFormatter()
        dfDisplay.dateFormat = "MMM dd, yyyy HH:mm a"
        txtRoutineCreateTime.text = dfDisplay.string(from: Date())
        
        let userName = UserDefaults.standard.object(forKey: USERNAME) as? String ?? ""
        
        txtAuthorName.text = userName
        
        print("Date>>> \(dfDisplay.string(from: Date()))")
        self.getUserDetailAPICall()
    }
    func getUserDetailAPICall() {
                           
      //  let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='select r.userid, r.*,u.firstname, u.lastname, u.email from routine r left join userdata u on r.userid=u.userid where r.routineid ='\(strRoutingID ?? "")''"
        
        strRoutingID = randomRoutineId()
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""

        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Userprofile where userid='\(userID)''"

        
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
                          
                            if Gender == "F"
                            {
                                self.ImgBodyImage.image = UIImage(named: "F-grey female body back")
                            }else{
                                self.ImgBodyImage.image = UIImage(named: "grey male body back")
                            }
                        }else{
                            self.ImgBodyImage.image = UIImage(named: "grey male body back")
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
    
    func saveImageToDocumentsDirectory(image: UIImage, withName: String) -> String? {
        if let data = image.pngData() {
            let dirPath = getDocumentDirectoryPath()
            let imageFileUrl = URL(fileURLWithPath: dirPath.appendingPathComponent(withName) as String)
            do {
                try data.write(to: imageFileUrl)
                print("Successfully saved image at path: \(imageFileUrl)")
                return imageFileUrl.absoluteString
            } catch {
                print("Error saving image: \(error)")
            }
        }
        return nil
    }
    
    func getDocumentDirectoryPath() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
    func getfileUniqueNameWithextention(strExtention: String) -> String {
        let date = NSDate(timeIntervalSince1970: 1415637900)
        var strRandomeName: String = String(format: "%f", date)
        strRandomeName = strRandomeName.replacingOccurrences(of: ".", with: "")

        strRandomeName = String(format: "%@.%@", strRandomeName,strExtention)
        return strRandomeName
    }
        
    func getRoutineDetailHeight() {
        constHeightDetail.constant = constHeightAilment.constant + constHeightDescription.constant + constHeightTags.constant + constHeightSubCategory.constant + 1064//1144//529
    }
    
    @IBAction func btnSelectImageAction(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()

        let actionSheet = UIAlertController(title: "Take image", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in

            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.delegate = self
                imagePicker.isEditing = true
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                print("Camera Not Available")
                self.showToast(message: "Camera Not Available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (action) in

            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.delegate = self
            imagePicker.isEditing = true
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))

        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickMoreDetailBtn(_ sender: Any) {
                
        if txtRoutineName.text == "" {
            showToast(message: "Please insert routine name.")
            return
        }
        
        txtRoutineName.resignFirstResponder()
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
            constHeightAilment.constant = 46.0
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
            constHeightDescription.constant = 42.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnDescription.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnDescription.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            constHeightDescription.constant = 182.0
        }
        
        
        if txtDescription.text.count > 0
        {
            lbldescription.text = txtDescription.text
            lbldescription.textColor = .black
        }
        else
        {
            lbldescription.text = "Enter Description"
            lbldescription.textColor = UIColor.lightGray
        }
        
        
        self.getRoutineDetailHeight()
    }
            
    @IBAction func btnDiseaseAction(_ sender: UIButton) {
        
        btnDiseases[sender.tag].isSelected = !btnDiseases[sender.tag].isSelected
        if selectedDiseases.contains(arrDiseases[sender.tag])
        {
            selectedDiseases.remove(at: selectedDiseases.lastIndex(of: arrDiseases[sender.tag])!)
            detailSelectOPT.remove(at: detailSelectOPT.lastIndex(of: arrDiseases[sender.tag])!)
        }
        else
        {
            selectedDiseases.append(arrDiseases[sender.tag])
            detailSelectOPT.append(arrDiseases[sender.tag].lowercased())
        }
        
        
        if selectedDiseases.count > 0
        {
            let formattedArray = (selectedDiseases.map{String($0)}).joined(separator: ",")
            lblAliment.text = formattedArray
            lblAliment.textColor = UIColor.black
        }
        else
        {
            lblAliment.text = "Select Aliment"
            lblAliment.textColor = UIColor.lightGray
        }
        
    }
            
    @IBAction func onClickTagsBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnTags.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnTags.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        if constHeightTags.constant == 123.0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnTags.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
            })
            
            constHeightTags.constant = 44.0
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.btnTags.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
                self.btnTags.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
            })
            
            constHeightTags.constant = 123.0
        }
        
        
        if viewTagList.tagViews.count > 0
        {
            lblTagListTemp.isHidden = true
        }
        else
        {
            lblTagListTemp.isHidden = false
        }
        
        
        self.getRoutineDetailHeight()
    }
             
//    @IBAction func onChangePressureValue(_ sender: Any) {
//        if progressPressure.value < 0.25 {
//            //Light
//        }else if progressPressure.value > 0.25 && progressPressure.value < 0.50 {
//            //Medium
//        }else if progressPressure.value > 0.50 && progressPressure.value < 0.75 {
//            //Firm
//        }else if progressPressure.value > 0.75 {
//            //Deep
//        }
//
//        print("progressPressure>>>>>>>\(progressPressure.value)")
//    }
//
//    @IBAction func onChangeSpeedValue(_ sender: Any) {
//        if progressSpeed.value < 0.25 {
//            //Light
//        }else if progressSpeed.value > 0.25 && progressPressure.value < 0.50 {
//            //Medium
//        }else if progressSpeed.value > 0.50 && progressPressure.value < 0.75 {
//            //Firm
//        }else if progressSpeed.value > 0.75 {
//            //Deep
//        }
//
//        print("progressSpeed>>>>>>>\(progressSpeed.value)")
//    }
    
    func isValidData() -> Bool {
        
        if lblAliment.textColor == UIColor.lightGray
        {
            showToast(message: "Please select Aliment.")
            return false
        }else if txtCategory.text == "" {
            showToast(message: "Please select category.")
            return false
        }else if txtType.text == "" {
            showToast(message: "Please select type.")
            return false
        }else if txtUser.text == "" {
            showToast(message: "Please select user type.")
            return false
        }
        /*else if viewTagList.tagViews.count == 0 {
            showToast(message: "Please enter tags properly by using enter.")
            return false
        }else if txtDescription.text == "" {
            showToast(message: "Please insert description.")
            return false
        }*/
        
        return true
    }
    
    @IBAction func onAddRoutineBtn(_ sender: Any) {
        if strProImgName != "" {
            if urlImgPath.absoluteString != "" {
                self.segmentImgFirebase()
            }
        }
        
        self.setAddRoutineServiceCall()
    }
    
    func setAddRoutineServiceCall() {
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""

        if userID != "" {
            if isValidData() {

                let dfPass = DateFormatter()
                dfPass.dateFormat = "yyyy-MM-dd HH:mm"

                let diseases = detailSelectOPT.joined(separator: ",")
                var tags = ""
                for tag in viewTagList.tagViews {
                    tags += (tag.titleLabel?.text ?? "") + ","
                }

                if tags.count > 0 {
                    tags.removeLast()
                }

                strRoutingID = randomRoutineId()

                let url = """
                https://massage-robotics-website.uc.r.appspot.com/wt?tablename=Routine&row=[('\(strRoutingID!)',
                '\(userID)',
                '\(dfPass.string(from: Date()))',
                'public',
                '\(txtRoutineName.text!.lowercased())',
                '\(txtDescription.text!.lowercased())',
                '\(dfPass.string(from: Date()))',
                '5',
                '2',
                'best and good',
                '\(strProImgName)',
                '',
                '\(txtCategory.text!.lowercased())',
                '\(txtType.text!.lowercased())',
                '\(txtUser.text!.lowercased())',
                '\(diseases)',
                '\(tags)',
                '\(txtSubCategory.text!.lowercased())')]
                """
                print(url)

                let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                callAPI(url: encodedUrl!) { [self] (json, data) in
                    print(json)
                    self.hideLoading()
                    if json.getString(key: "Response") == "Success" {

                        showToast(message: "Routine created successfully!")

                        txtRoutineName.text = ""
                        txtDescription.text = ""
                        txtCategory.text = ""
                        txtType.text = ""
                        txtUser.text = ""

                        selectedDiseases.removeAll()
                        detailSelectOPT.removeAll()
                        
                        for btn in btnDiseases {
                            btn.isSelected = false
                        }
                        
                        viewTagList.removeAllTags()

                        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "NewCreateSegmentVC") as! NewCreateSegmentVC
                        vc.StrRoutingID = strRoutingID!
                        vc.strPath = "CreateRoutine"
                        navigationController?.pushViewController(vc, animated: false)
                    }
                }

            }
        }
    }
}

extension RoutineDetailViewController: TagListViewDelegate
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

extension RoutineDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if txtCategory.isEditing{
            return arrCategoryList.count
        }else if txtSubCategory.isEditing{
            return arrSubCategoryList.count
        }else if txtType.isEditing {
            return arrType.count
        }else if txtUser.isEditing {
            return arrUser.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtCategory.isEditing{
            return arrCategoryList[row]
        }else if txtSubCategory.isEditing{
            return arrSubCategoryList[row]
        }else if txtType.isEditing{
            return arrType[row]
        }else if txtUser.isEditing{
            return arrUser[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtCategory.isEditing{
            txtCategory.text = arrCategoryList[row]
            txtCategory.tag = row
        }else if txtSubCategory.isEditing{
            txtSubCategory.text = arrSubCategoryList[row]
            txtSubCategory.tag = row
        }else if txtType.isEditing{
            txtType.text = arrType[row]
            txtType.tag = row
        }else if txtUser.isEditing{
            txtUser.text = arrUser[row]
            txtUser.tag = row
        }
    }
    
}

extension RoutineDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if txtNewTagName == textField && txtNewTagName.text != ""
        {
            viewTagList.addTag(textField.text!)
            textField.text = ""
            if viewTagList.tagViews.count == 0
            {
                textField.placeholder = "Enter a new tag"
            }
            else
            {
                textField.placeholder = "+ tag"
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
        //viewFullTapGesture.isHidden = false
        
        if txtCategory.isEditing{
            txtCategory.text = arrCategoryList[textField.tag]
            picker.selectRow(txtCategory.tag, inComponent: 0, animated: true)
        }else if txtSubCategory.isEditing{
            txtSubCategory.text = arrSubCategoryList[textField.tag]
            picker.selectRow(txtCategory.tag, inComponent: 0, animated: true)
        }else if txtType.isEditing {
            txtType.text = arrType[textField.tag]
            picker.selectRow(txtType.tag, inComponent: 0, animated: true)
        }else if txtUser.isEditing {
            txtUser.text = arrUser[textField.tag]
            picker.selectRow(txtUser.tag, inComponent: 0, animated: true)
        }
        
        if textField == txtCategory || textField == txtSubCategory || textField == txtUser || textField == txtType {
            picker.reloadAllComponents()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
                
        if textField == txtUser || textField == txtType {
            if textField == txtType {
                txtType.text = textField.text
                
            }else if textField == txtUser {
                txtUser.text = textField.text
            }
        }else if textField == txtRoutineName {
            txtRoutineName.text = textField.text
        }else if textField == txtNewTagName {
            
        }else {
            if txtCategory.text == "Activites" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Driving"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrActivites)
            }else if txtCategory.text == "Ailments" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Carpal Tunnel"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrAilments)
            }else if txtCategory.text == "Browse" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Following"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrBrowse)
            }else if txtCategory.text == "Discover" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Introduction"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrDisSubCat)
            }else if txtCategory.text == "Favorites" {
                constHeightSubCategory.constant = 0.0
            }else if txtCategory.text == "For You" {
                constHeightSubCategory.constant = 0.0
            }else if txtCategory.text == "Lifestyle" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Break"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrLifeStyle)
            }else if txtCategory.text == "New Releases" {
                constHeightSubCategory.constant = 0.0
            }else if txtCategory.text == "Performance" {
                constHeightSubCategory.constant = 0.0
            }else if txtCategory.text == "Relaxation" {
                constHeightSubCategory.constant = 0.0
            }else if txtCategory.text == "Sports" {
                
                if textField != txtSubCategory  {
                    txtSubCategory.text = "Baseball"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrSports)
            }else if txtCategory.text == "Target Areas" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Feet"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrTASubCat)
            }else if txtCategory.text == "Therapy" {
                constHeightSubCategory.constant = 0.0
            }else if txtCategory.text == "Wellness" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Daily"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrWellness)
            }else if txtCategory.text == "Workout" {
                
                if textField != txtSubCategory {
                    txtSubCategory.text = "Gym"
                }else {
                    txtSubCategory.text = textField.text
                }
                
                constHeightSubCategory.constant = 40.0
                arrSubCategoryList.removeAll()
                arrSubCategoryList.append(contentsOf: arrWorkOut)
            }
        }
        
        self.getRoutineDetailHeight()
    }
}

extension RoutineDetailViewController: UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if txtDescription == textView
        {
            //lblDescriptionPlaceholder.isHidden = (txtDescription.text + text).count != 0
        }
        return true
    }
}

extension RoutineDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as! UIImage
        let fixedImaage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
        // fixedImaage.resize(scale: 0.25)
        imgRoutine.contentMode = .scaleAspectFill
        imgRoutine.image = fixedImaage
        btnSelectImage.setImage(nil, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
        
        strProImgName = randomImg()
        strProImgName = strProImgName + ".png"
        
        let pathToSavedImage = saveImageToDocumentsDirectory(image: imgRoutine.image!, withName: "\(strProImgName)")
        if (pathToSavedImage == nil) {
            print("Failed to save image")
        }

        let image1 = loadImageFromDocumentsDirectory(imageName: "\(strProImgName)")
        if image1 == nil {
            print ("Failed to load image")
        }
        
        let fileURL = (self.getDocumentDirectoryPath() as NSString).appendingPathComponent("\(strProImgName)")
        urlImgPath = NSURL(fileURLWithPath: fileURL)
    }
    
    func loadImageFromDocumentsDirectory(imageName: String) -> UIImage? {
        let tempDirPath = getDocumentDirectoryPath()
        let imageFilePath = tempDirPath.appendingPathComponent(imageName)
        return UIImage(contentsOfFile:imageFilePath)
    }
        
    func segmentImgFirebase () {
        
        let storageRef = storage.reference()
        
        // File located on disk
        let localFile = URL(string: urlImgPath.absoluteString!)!

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/\(strProImgName)")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            self.showToast(message: "Some issue, profile image not upload")
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
                self.showToast(message: "Some issue, profile image not upload")
              return
            }
          }
        }
    }
}

