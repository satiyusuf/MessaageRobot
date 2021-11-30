//
//  SearchFilterVC.swift
//  MassageRobot
//
//  Created by Emp-Mac on 18/11/21.
//

import UIKit
import TagListView
import RangeSeekSlider

class SearchFilterVC: UIViewController {

    //MARK:- Outlet
    @IBOutlet weak var sliderview: UIView!
    @IBOutlet weak var lblSliderText: UILabel!
    @IBOutlet weak var SliderValue: UISlider!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var tblData: UITableView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var DurationView: UIView!
    @IBOutlet weak var btnDurationViewHide: UIButton!
    @IBOutlet weak var DurationRange: RangeSeekSlider!
    
    //MARK:- Variable
    private var hiddenSections = Set<Int>()
    private var  arrSection = ["Ailments","All","Auther","Category","Date","Description","Duration","Location","Path","Pressure","Rating","Segment","Speed","Tag","Tools","Type","User"]
    
    private let arrAilments = ["Carpal Tunnel", "Knots", "Muscle Cramps", "Plantar Fascities", "Sciatica",  "Shin Splints"]
    private let arrTools = ["Inline", "Omni", "Percussion", "Point", "Sport"]
    private let arrPath = ["Circular", "Linear", "Point", "Random"]
    private var arrUser = ["Adult","Athlete","Geriatric", "Pregnant", "Youth"]
    private var arrType = ["Cranial Sacral Therapy", "Deep Tissue Massage", "Geriatric Massage", "Prenatal Massage", "Reflexology", "Sports Massage", "Swedish Massage", "Percussion Massage", "Trigger Point Acupressure"]
    private let arrCategoryList = ["Activites","Ailments", "Browse", "Discover", "Lifestyle", "New Releases", "Performance", "Relaxation", "Sports", "Target Areas", "Therapy", "Wellness", "Workout"]
    private let arrLocatin = ["Pectoralis","iliotibal Tract","Quadracepts","knee","Tibalis Anterior","Deltoid","Upperback","Lowerback","Gastrocnemius","Hamstring","Glutiusmaximus"]
    
    private var arrAilmentsSelected = [String]()
    private var arrToolsSelected = [String]()
    private var arrPathSelected = [String]()
    private var arrUserSelected = [String]()
    private var arrTypeSelected = [String]()
    private var arrCategoryListSelected = [String]()
    private var arrLocatinSelected = [String]()
    
    private var SpeedOrForceCheck = String()
    private var StrSpeedValue = String()
    private var StrForceValue = String()
    
    private var StartDuration = Int()
    private var EndDuration = Int()
    private var tagslist = ""
    private var DescriptionText = ""
    private var HeaderViewHeight = Int()
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DurationRange.delegate = self
        
        self.btnDurationViewHide.setTitle("", for: .normal)
        self.DurationView.isHidden = true
        self.TopView.layer.masksToBounds = false
        self.TopView.layer.shadowRadius = 4
        self.TopView.layer.shadowOpacity = 0.5
        self.TopView.layer.shadowColor = UIColor.gray.cgColor
        self.TopView.layer.shadowOffset = CGSize(width: 0 , height:3)
        
        if #available(iOS 15.0, *) {
            self.tblData.sectionHeaderTopPadding = 0
        }
    }
    
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
    @IBAction func btnApply(_ sender: Any) {
             
        let AilmentsComa = self.arrAilmentsSelected.joined(separator: ",")
        let CategoryComa = self.self.arrCategoryListSelected.joined(separator: ",")
        let LocationComa = self.arrLocatinSelected.joined(separator: ",")
        let PathComa = self.arrPathSelected.joined(separator: ",")
        let ToolsComa = self.arrToolsSelected.joined(separator: ",")
        let TypeComa = self.arrTypeSelected.joined(separator: ",")
        let UserComa = self.arrUserSelected.joined(separator: ",")
        
        let Ailments = ["ailments":AilmentsComa.lowercased()]
        let Category = ["category":CategoryComa.lowercased()]
        let Description = ["description":self.DescriptionText]
        let Duration = ["duration":"\(self.StartDuration) to \(self.EndDuration)"]
        let Location = ["location":LocationComa.lowercased()]
        let Path = ["path":PathComa.lowercased()]
        let Pressure = ["pressure":self.StrForceValue]
        let Speed = ["speed":self.StrSpeedValue]
        let Tag = ["tag":tagslist]
        let Tools = ["tools":ToolsComa.lowercased()]
        let Type = ["type":TypeComa.lowercased()]
        let User = ["user":UserComa.lowercased()]
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchDataVC") as! SearchDataVC
        vc.DictFilterData = [Ailments,Category,Description,Duration,Location,Path,Pressure,Speed,Tag,Tools,Type,User]
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnReset(_ sender: Any) {
        self.ResetValue()
    }
    
    @IBAction func btnClose(_ sender: Any) {
    }
    @IBAction func SliderAction(_ sender: UISlider ) {
        
        sender.value = roundf(sender.value)
        let trackRect = sender.trackRect(forBounds: sender.frame)
        let thumbRect = sender.thumbRect(forBounds: sender.bounds, trackRect: trackRect, value: sender.value)
        lblSliderText.center = CGPoint(x: thumbRect.midX, y: lblSliderText.center.y)
        lblSliderText.text = "\(Int(sender.value))"
    }
    @IBAction func btnSliderHide(_ sender: Any) {
        
        if SpeedOrForceCheck == "Force" {
            self.StrForceValue = "\(Int(SliderValue.value))"
        } else if SpeedOrForceCheck == "Speed" {
            self.StrSpeedValue = "\(Int(SliderValue.value))"
        }
        self.tblData.reloadData()
        SliderValue.reloadInputViews()
        self.sliderview.isHidden = true
        self.lblSliderText.text = "0"
        self.SliderValue.value = 0
    }
    @IBAction func btnDurationViewHide(_ sender: Any) {
        self.DurationView.isHidden = true
        self.tblData.reloadData()
    }
}
//MARK:- Private Functio Used For Class
extension SearchFilterVC {
    
    private func ResetValue(){
        
        self.arrAilmentsSelected.removeAll()
        self.arrToolsSelected.removeAll()
        self.arrPathSelected.removeAll()
        self.arrUserSelected.removeAll()
        self.arrTypeSelected.removeAll()
        self.arrCategoryListSelected.removeAll()
        self.arrLocatinSelected.removeAll()
        
        self.SpeedOrForceCheck = ""
        self.StrSpeedValue = ""
        self.StrForceValue = ""
        
        
        self.SliderValue.reloadInputViews()
        self.lblSliderText.text = "0"
        self.SliderValue.value = 0
        
        self.StartDuration = 0
        self.EndDuration = 0
        self.tagslist = ""
        self.DescriptionText = ""
        self.HeaderViewHeight = 0
        
        NotificationCenter.default.post(name: Notification.Name("Reset"), object: nil, userInfo: ["Reset":"true"])
        
        self.tblData.reloadData()
    }
}
//MARK:- UITableView DataSource And DeleGate Method
extension SearchFilterVC :UITableViewDelegate ,UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrSection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.hiddenSections.contains(section) {
            
            if arrSection[section] == "Ailments" {
                return arrAilments.count
            }else if arrSection[section] == "All" {
                return 0
            } else if arrSection[section] == "Auther" {
                return 0
            } else if arrSection[section] == "Category" {
                return arrCategoryList.count
            } else if arrSection[section] == "Date" {
                return 0
            } else if arrSection[section] == "Description" {
                return 1
            } else if arrSection[section] == "Duration" {
                return 0
            } else if arrSection[section] == "Location" {
                return arrLocatin.count
            }else if arrSection[section] == "Path" {
                return arrPath.count
            } else if arrSection[section] == "Pressure" {
                return 0
            } else if arrSection[section] == "Rating" {
                return 0
            } else if arrSection[section] == "Segment" {
                return 0
            } else if arrSection[section] == "Speed" {
                return 0
            } else if arrSection[section] == "Tag" {
                return 1
            } else if arrSection[section] == "Tools" {
                return arrTools.count
            } else if arrSection[section] == "Type" {
                return arrType.count
            } else if arrSection[section] == "User"{
                return arrUser.count
            } else {
                return 0
            }
        } else {
         
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as! DataCell
        cell.selectionStyle = .none

        if arrSection[indexPath.section] == "Ailments" {
            cell.MainView.isHidden = false
            cell.DescView.isHidden = true
            cell.TagView.isHidden = true
            
            let Title = arrAilments[indexPath.row]
            cell.lbltitle.text = Title
            if self.arrAilmentsSelected.contains(Title) {
                cell.ImgRadio.image = UIImage(named: "SelectIcon")
            }else{
                cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            }
        }else if arrSection[indexPath.section] == "All" {
            
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            
        } else if arrSection[indexPath.section] == "Auther" {
            
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            
        } else if arrSection[indexPath.section] == "Category" {
            cell.MainView.isHidden = false
            cell.DescView.isHidden = true
            cell.TagView.isHidden = true
            
            let Title = arrCategoryList[indexPath.row]
            cell.lbltitle.text = Title
            if self.arrCategoryListSelected.contains(Title) {
                cell.ImgRadio.image = UIImage(named: "SelectIcon")
            }else{
                cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            }
            
        } else if arrSection[indexPath.section] == "Date" {
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")

        } else if arrSection[indexPath.section] == "Description" {
            
            cell.DescData = self
            cell.MainView.isHidden = true
            cell.DescView.isHidden = false
            cell.TagView.isHidden = true
            
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")

        } else if arrSection[indexPath.section] == "Duration" {
            
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            
        } else if arrSection[indexPath.section] == "Location" {
            
            cell.MainView.isHidden = false
            cell.DescView.isHidden = true
            cell.TagView.isHidden = true
            
            let Title = arrLocatin[indexPath.row]
            cell.lbltitle.text = Title
            if self.arrLocatinSelected.contains(Title) {
                cell.ImgRadio.image = UIImage(named: "SelectIcon")
            }else{
                cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            }
            
        }else if arrSection[indexPath.section] == "Path" {
            cell.MainView.isHidden = false
            cell.DescView.isHidden = true
            cell.TagView.isHidden = true
            
            let Title = arrPath[indexPath.row]
            cell.lbltitle.text = Title
            if self.arrPathSelected.contains(Title) {
                cell.ImgRadio.image = UIImage(named: "SelectIcon")
            }else{
                cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            }
            
        } else if arrSection[indexPath.section] == "Pressure" {
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            
        } else if arrSection[indexPath.section] == "Rating" {
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")

        } else if arrSection[indexPath.section] == "Segment" {
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")

        } else if arrSection[indexPath.section] == "Speed" {
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")

        } else if arrSection[indexPath.section] == "Tag" {
            
            cell.MainView.isHidden = true
            cell.DescView.isHidden = true
            cell.TagView.isHidden = false
            
            cell.TagData = self
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")

        } else if arrSection[indexPath.section] == "Tools" {
            
            cell.MainView.isHidden = false
            cell.DescView.isHidden = true
            cell.TagView.isHidden = true
            
            let Title = arrTools[indexPath.row]
            cell.lbltitle.text = Title
            if self.arrToolsSelected.contains(Title) {
                cell.ImgRadio.image = UIImage(named: "SelectIcon")
            }else{
                cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            }
            
        } else if arrSection[indexPath.section] == "Type" {
            cell.MainView.isHidden = false
            cell.DescView.isHidden = true
            cell.TagView.isHidden = true
            
            let Title = arrType[indexPath.row]
            cell.lbltitle.text = Title
            if self.arrTypeSelected.contains(Title) {
                cell.ImgRadio.image = UIImage(named: "SelectIcon")
            }else{
                cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            }
            
        } else if arrSection[indexPath.section] == "User"{
            
            cell.MainView.isHidden = false
            cell.DescView.isHidden = true
            cell.TagView.isHidden = true
            
            let Title = arrUser[indexPath.row]
            cell.lbltitle.text = Title
            if self.arrUserSelected.contains(Title) {
                cell.ImgRadio.image = UIImage(named: "SelectIcon")
            }else{
                cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
            }
            
        } else {
            cell.lbltitle.text = ""
            cell.ImgRadio.image = UIImage(named: "UnSelectIcon")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 35 ))
       // headerView.layer.backgroundColor = UIColor.yellow.cgColor
        
        let Titlelabel = UILabel()
        Titlelabel.frame = CGRect.init(x:20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        Titlelabel.text = arrSection[section]
        Titlelabel.font = UIFont(name: "futura", size: 18)
        Titlelabel.textColor = .black
        
        let Image = UIImageView()
        Image.frame = CGRect(x: headerView.frame.width - 30, y: 10, width: 20, height: 13)
        Image.image = UIImage(named: "DownArrow")
        
        headerView.addSubview(Image)
        headerView.addSubview(Titlelabel)
        
        headerView.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(self.HideSection(_:)))
        headerView.addGestureRecognizer(headerTapGesture)
        
        if arrSection[section] == "Ailments" {
            if arrAilmentsSelected.count > 0 {
                for (index, element) in arrAilmentsSelected.enumerated() {
                    let SetTop = index * 20
                    let label = UILabel()
                    label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + CGFloat(SetTop) , width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = element //arrAilmentsSelected[index]
                    label.font = UIFont(name: "futura", size: 12)
                    label.textColor = .black
                    headerView.addSubview(label)
                }
            }
        }else if arrSection[section] == "All" {

        } else if arrSection[section] == "Auther" {

        } else if arrSection[section] == "Category" {
            if arrCategoryListSelected.count > 0 {
                for (index, element) in arrCategoryListSelected.enumerated() {
                    let SetTop = index * 20
                    let label = UILabel()
                    label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + CGFloat(SetTop) , width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = element//arrCategoryListSelected[index]
                    label.font = UIFont(name: "futura", size: 12)
                    label.textColor = .black
                    headerView.addSubview(label)
                }
            }
        } else if arrSection[section] == "Date" {

        } else if arrSection[section] == "Description" {
            if DescriptionText.isEmpty == false {
                let label = UILabel()
                label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + 5 , width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = DescriptionText
                label.font = UIFont(name: "futura", size: 12)
                label.textColor = .black
                headerView.addSubview(label)
            }

        } else if arrSection[section] == "Duration" {
            if StartDuration == 0 && EndDuration == 0 {
            } else {
                let label = UILabel()
                label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + 5 , width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = "\(StartDuration) To \(EndDuration)"
                label.font = UIFont(name: "futura", size: 12)
                label.textColor = .black
                headerView.addSubview(label)
            }
        } else if arrSection[section] == "Location" {
            if arrLocatinSelected.count > 0 {
                for (index, element) in arrLocatinSelected.enumerated() {
                    let SetTop = index * 20
                    let label = UILabel()
                    label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + CGFloat(SetTop) , width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = element//arrLocatinSelected[index]
                    label.font = UIFont(name: "futura", size: 12)
                    label.textColor = .black
                    headerView.addSubview(label)
                }
            }
        }else if arrSection[section] == "Path" {
            if arrPathSelected.count > 0 {
                for (index, element) in arrPathSelected.enumerated() {
                    let SetTop = index * 20
                    let label = UILabel()
                    label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + CGFloat(SetTop) , width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = element//arrPathSelected[index]
                    label.font = UIFont(name: "futura", size: 12)
                    label.textColor = .black
                    headerView.addSubview(label)
                }
            }
        } else if arrSection[section] == "Pressure" {
            if StrForceValue.isEmpty == false {
                let label = UILabel()
                label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + 5 , width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = "Pressure:\(StrForceValue)"
                label.font = UIFont(name: "futura", size: 12)
                label.textColor = .black
                headerView.addSubview(label)
            }

        } else if arrSection[section] == "Rating" {

        } else if arrSection[section] == "Segment" {

        } else if arrSection[section] == "Speed" {
            if StrSpeedValue.isEmpty == false {
                let label = UILabel()
                label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + 5 , width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = "Speed:\(StrSpeedValue)"
                label.font = UIFont(name: "futura", size: 12)
                label.textColor = .black
                headerView.addSubview(label)
            }

        } else if arrSection[section] == "Tag" {
            
            if tagslist.count > 0 {
                let label = UILabel()
                label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + 5 , width: headerView.frame.width-10, height: headerView.frame.height-10)
                label.text = tagslist
                label.font = UIFont(name: "futura", size: 12)
                label.textColor = .black
                headerView.addSubview(label)
            }

        } else if arrSection[section] == "Tools" {
            if arrToolsSelected.count > 0 {
                for (index, element) in arrToolsSelected.enumerated() {
                    let SetTop = index * 20
                    let label = UILabel()
                    label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + CGFloat(SetTop) , width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = element//arrToolsSelected[index]
                    label.font = UIFont(name: "futura", size: 12)
                    label.textColor = .black
                    headerView.addSubview(label)
                }
            }
        } else if arrSection[section] == "Type" {
            if arrTypeSelected.count > 0 {
                for (index, element) in arrTypeSelected.enumerated() {
                    let SetTop = index * 20
                    let label = UILabel()
                    label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + CGFloat(SetTop) , width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = element//arrTypeSelected[index]
                    label.font = UIFont(name: "futura", size: 12)
                    label.textColor = .black
                    headerView.addSubview(label)
                }
            }
        } else if arrSection[section] == "User"{
            if arrUserSelected.count > 0 {
                for (index, element) in arrUserSelected.enumerated() {
                    let SetTop = index * 20
                    let label = UILabel()
                    label.frame = CGRect.init(x:30, y: Titlelabel.frame.height + CGFloat(SetTop) , width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = element //arrUserSelected[index]
                    label.font = UIFont(name: "futura", size: 12)
                    label.textColor = .black
                    headerView.addSubview(label)
                }
            }
        }
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 5 {
            return 100
        } else if indexPath.section == 13 {
            return 100
        } else {
            return 30
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if arrSection[section] == "Ailments" {
            if arrAilmentsSelected.count > 0 {
               let height = self.arrAilmentsSelected.count * 20
                HeaderViewHeight = height
                return CGFloat(HeaderViewHeight + 35)
            } else {
                return 35
            }
        }else if arrSection[section] == "All" {
            return 35
        } else if arrSection[section] == "Auther" {
            return 35
        } else if arrSection[section] == "Category" {
            if arrCategoryListSelected.count > 0 {
               let height = self.arrCategoryListSelected.count * 20
                HeaderViewHeight = height
                return CGFloat(HeaderViewHeight + 35)
            } else {
                return 35
            }
        } else if arrSection[section] == "Date" {
            return 35
        } else if arrSection[section] == "Description" {
            if DescriptionText.isEmpty == false {
                return 55
            } else {
                return 35
            }
        } else if arrSection[section] == "Duration" {
            if StartDuration == 0 && EndDuration == 0 {
                return 35
            } else {
                return 55
            }
        } else if arrSection[section] == "Location" {
            if arrLocatinSelected.count > 0 {
               let height = self.arrLocatinSelected.count * 20
                HeaderViewHeight = height
                return CGFloat(HeaderViewHeight + 35)
            } else {
                return 35
            }
        }else if arrSection[section] == "Path" {
            if arrPathSelected.count > 0 {
               let height = self.arrPathSelected.count * 20
                HeaderViewHeight = height
                return CGFloat(HeaderViewHeight + 35)
            } else {
                return 35
            }
        } else if arrSection[section] == "Pressure" {
            if StrForceValue.isEmpty == false {
                return 55
            } else {
                return 35
            }
           
        } else if arrSection[section] == "Rating" {
            return 35
        } else if arrSection[section] == "Segment" {
            return 35
        } else if arrSection[section] == "Speed" {
            if StrSpeedValue.isEmpty == false {
                return 55
            } else {
                return 35
            }
            
        } else if arrSection[section] == "Tag" {
            if tagslist.count > 0 {
                return 55
            } else {
                return 35
            }
           
        } else if arrSection[section] == "Tools" {
            if arrToolsSelected.count > 0 {
               let height = self.arrToolsSelected.count * 20
                HeaderViewHeight = height
                return CGFloat(HeaderViewHeight + 35)
            } else {
                return 35
            }
        } else if arrSection[section] == "Type" {
            if arrTypeSelected.count > 0 {
               let height = self.arrTypeSelected.count * 20
                HeaderViewHeight = height
                return CGFloat(HeaderViewHeight + 35)
            } else {
                return 35
            }
        } else if arrSection[section] == "User"{
            if arrUserSelected.count > 0 {
               let height = self.arrUserSelected.count * 20
                HeaderViewHeight = height
                return CGFloat(HeaderViewHeight + 35)
            } else {
                return 35
            }
        } else {
            return 35
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if arrSection[indexPath.section] == "Ailments" {
            let Title = arrAilments[indexPath.row]
            
            if self.arrAilmentsSelected.contains(Title) {
                if let index = arrAilmentsSelected.firstIndex(of: Title) {
                    arrAilmentsSelected.remove(at: index)
                }
            }else{
                arrAilmentsSelected.append(Title)
            }
            self.tblData.reloadData()
        }else if arrSection[indexPath.section] == "All" {
           
        } else if arrSection[indexPath.section] == "Auther" {
            
        } else if arrSection[indexPath.section] == "Category" {
            let Title = arrCategoryList[indexPath.row]
            
            if self.arrCategoryListSelected.contains(Title) {
                if let index = arrCategoryListSelected.firstIndex(of: Title) {
                    arrCategoryListSelected.remove(at: index)
                }
            }else{
                arrCategoryListSelected.append(Title)
            }
            self.tblData.reloadData()
            
        } else if arrSection[indexPath.section] == "Date" {
            
        } else if arrSection[indexPath.section] == "Description" {
            
        } else if arrSection[indexPath.section] == "Duration" {
           
        } else if arrSection[indexPath.section] == "Location" {
            
            let Title = arrLocatin[indexPath.row]
            
            if self.arrLocatinSelected.contains(Title) {
                if let index = arrLocatinSelected.firstIndex(of: Title) {
                    arrLocatinSelected.remove(at: index)
                }
            }else{
                arrLocatinSelected.append(Title)
            }
            self.tblData.reloadData()
            
        }else if arrSection[indexPath.section] == "Path" {
            
            let Title = arrPath[indexPath.row]
            
            if self.arrPathSelected.contains(Title) {
                if let index = arrPathSelected.firstIndex(of: Title) {
                    arrPathSelected.remove(at: index)
                }
            }else{
                arrPathSelected.append(Title)
            }
            self.tblData.reloadData()
            
        } else if arrSection[indexPath.section] == "Pressure" {
            
        } else if arrSection[indexPath.section] == "Rating" {
           
        } else if arrSection[indexPath.section] == "Segment" {
           
        } else if arrSection[indexPath.section] == "Speed" {
            
        } else if arrSection[indexPath.section] == "Tag" {
           
        } else if arrSection[indexPath.section] == "Tools" {
            
            let Title = arrTools[indexPath.row]
            
            if self.arrToolsSelected.contains(Title) {
                if let index = arrToolsSelected.firstIndex(of: Title) {
                    arrToolsSelected.remove(at: index)
                }
            }else{
                arrToolsSelected.append(Title)
            }
            self.tblData.reloadData()
            
        } else if arrSection[indexPath.section] == "Type" {
            
            let Title = arrType[indexPath.row]
            
            if self.arrTypeSelected.contains(Title) {
                if let index = arrTypeSelected.firstIndex(of: Title) {
                    arrTypeSelected.remove(at: index)
                }
            }else{
                arrTypeSelected.append(Title)
            }
            self.tblData.reloadData()
           
        } else if arrSection[indexPath.section] == "User"{
           
            let Title = arrUser[indexPath.row]
            
            if self.arrUserSelected.contains(Title) {
                if let index = arrUserSelected.firstIndex(of: Title) {
                    arrUserSelected.remove(at: index)
                }
            }else{
                arrUserSelected.append(Title)
            }
            self.tblData.reloadData()
        }
    }
    
    //MARK:- Private Function
    @objc
    private func HideSection(_ sender: UITapGestureRecognizer) {
        let section = sender.view?.tag
        print("SectionTag:- \(String(describing: section))")
        
        let Name = arrSection[section!]
        
        if Name == "Pressure" {
            self.SpeedOrForceCheck = "Force"
            self.sliderview.isHidden = false
        } else if Name == "Speed" {
            self.SpeedOrForceCheck = "Speed"
            self.sliderview.isHidden = false
        } else if Name == "Duration" {
            self.DurationView.isHidden = false
        } else {
            func indexPathsForSection() -> [IndexPath] {
                var indexPaths = [IndexPath]()
                
                for row in 0 ..< arrSection[section!].count {
                    indexPaths.append(IndexPath(row: row,
                                                section: section!))
                }
                return indexPaths
            }
            
            if self.hiddenSections.contains(section!) {
                self.hiddenSections.remove(section!)
                self.tblData.reloadData()
            } else {
                self.hiddenSections.insert(section!)
                self.tblData.reloadData()
            }
        }
    }
}

//MARK:- UITableViewCell Class
class DataCell: UITableViewCell, UITextFieldDelegate, TagListViewDelegate, UITextViewDelegate {
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var ImgRadio: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var DescView: UIView!
    @IBOutlet weak var txtTextArea: UITextView!
    @IBOutlet weak var TagView: UIView!
    @IBOutlet weak var txtTag: UITextField!
    @IBOutlet weak var TagListShow: TagListView!
    
    var TagData:TagDataPass?
    var DescData : DescripctiopDataPass?
    
    override func awakeFromNib()
    {
        self.txtTag.delegate = self
        self.TagListShow.delegate = self
        
        txtTextArea.delegate = self
        txtTextArea.text = "Placeholder text goes right here..."
        txtTextArea.textColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.Reset(notification:)), name: Notification.Name("Reset"), object: nil)

    }
    
    @objc func Reset(notification: Notification) {
        
        let Data = notification.userInfo! as NSDictionary
        let IsLink = Data["Reset"] as? String ?? ""
        print(IsLink)
        if IsLink == "true" {
            self.TagListShow.removeAllTags()
        } 
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        sender.removeTagView(tagView)
        if TagListShow.tagViews.count == 0
        {
            txtTag.placeholder = "Enter a new tag"
        }
        else
        {
            txtTag.placeholder = "+ tag"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if txtTag == textField && txtTag.text != ""
        {
            TagListShow.addTag(textField.text!)
            textField.text = ""
            if TagListShow.tagViews.count == 0
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
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
        if textField == txtTag {
            
            var tags = ""
            for tag in TagListShow.tagViews {
                tags += (tag.titleLabel?.text ?? "") + ","
            }

            if tags.count > 0 {
                tags.removeLast()
            }
            
            TagData?.TagData(Tag:tags)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if txtTextArea.textColor == UIColor.lightGray {
            txtTextArea.text = ""
            txtTextArea.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView == txtTextArea {
            DescData?.DescripctiopDataPass(text: txtTextArea.text)
        }
    }
}

// MARK: - RangeSeekSliderDelegate
extension SearchFilterVC : RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === DurationRange {
            self.StartDuration = Int(minValue)
            self.EndDuration = Int(maxValue)
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }
    }
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
extension SearchFilterVC : TagDataPass {
    func TagData(Tag: String) {
        print(Tag)
        self.tagslist = Tag
    }
}
extension SearchFilterVC : DescripctiopDataPass {
    func DescripctiopDataPass(text: String) {
        print(text)
        self.DescriptionText = text
    }
}


protocol TagDataPass {
    func TagData(Tag:String)
}
protocol DescripctiopDataPass {
    func DescripctiopDataPass(text:String)
}
