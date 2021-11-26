//
//  SearchFilterVC.swift
//  MassageRobot
//
//  Created by Emp-Mac on 18/11/21.
//

import UIKit
import TagListView

class SearchFilterVC: UIViewController {

    //MARK:- Outlet
    @IBOutlet weak var sliderview: UIView!
    @IBOutlet weak var lblSliderText: UILabel!
    @IBOutlet weak var SliderValue: UISlider!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var tblData: UITableView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var DurationView: UIView!
    @IBOutlet weak var colleduration: UICollectionView!
    @IBOutlet weak var btnDurationViewHide: UIButton!
    
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
    private var arrDurationSelectedIndex = [Int]()
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
    
    //MARK:- Action
    @IBAction func btnApply(_ sender: Any) {
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
        SliderValue.reloadInputViews()
        self.sliderview.isHidden = true
        self.lblSliderText.text = "0"
        self.SliderValue.value = 0
    }
    @IBAction func btnDurationViewHide(_ sender: Any) {
        self.DurationView.isHidden = true
        self.arrDurationSelectedIndex.removeAll()
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
        
        self.tblData.reloadData()
        self.SliderValue.reloadInputViews()
        self.lblSliderText.text = "0"
        self.SliderValue.value = 0
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DataCell
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
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 35))
        
        let label = UILabel()
        label.frame = CGRect.init(x:20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = arrSection[section]
        label.font = UIFont(name: "futura", size: 18)
        label.textColor = .black
        
        let Image = UIImageView()
        Image.frame = CGRect(x: headerView.frame.width - 30, y: 10, width: 20, height: 13)
        Image.image = UIImage(named: "DownArrow")
        
        headerView.addSubview(Image)
        headerView.addSubview(label)
        
        headerView.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(self.HideSection(_:)))
        headerView.addGestureRecognizer(headerTapGesture)
        
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
        return 35
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

//MARK:- UICollectionViewDelegate And UICollectionViewDataSource Method
extension SearchFilterVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = colleduration.dequeueReusableCell(withReuseIdentifier: "DuractionCell", for: indexPath) as! DuractionCell
        cell.lblDuration.text = "\(indexPath.row + 1)"
        cell.contentView.backgroundColor = UIColor.white
                
        if arrDurationSelectedIndex.count > 2 {
            let Star = self.arrDurationSelectedIndex.min()!
            let End = self.arrDurationSelectedIndex.max()!
            let Last = self.arrDurationSelectedIndex.last!

            let NewEnd = min(End, Last)
            let StarMex = max(Star, Last)
            let StarMin = min(Star, Last)
            let NewStar = min(StarMex, StarMin)
            
            self.StartDuration = NewStar
            self.EndDuration = NewEnd
            
            if NewStar <= indexPath.row && NewEnd >= indexPath.row {
                cell.contentView.backgroundColor = UIColor.yellow
            } else {
                cell.contentView.backgroundColor = UIColor.white
            }
            
        } else if arrDurationSelectedIndex.count > 1 {
            let Star = self.arrDurationSelectedIndex.min()!
            let End = self.arrDurationSelectedIndex.max()!
            self.StartDuration = Star
            self.EndDuration = End
            if Star <= indexPath.row && End >= indexPath.row {
                cell.contentView.backgroundColor = UIColor.yellow
            } else {
                cell.contentView.backgroundColor = UIColor.white
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.arrDurationSelectedIndex.append(indexPath.row)
        self.colleduration.reloadData()
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension SearchFilterVC : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
    
    override func awakeFromNib()
    {
        self.txtTag.delegate = self
        self.TagListShow.delegate = self
        
        txtTextArea.delegate = self
        txtTextArea.text = "Placeholder text goes right here..."
        txtTextArea.textColor = UIColor.lightGray
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if txtTextArea.textColor == UIColor.lightGray {
            txtTextArea.text = ""
            txtTextArea.textColor = UIColor.black
        }
    }
}

//MARK:- UICollectionViewCell Class
class DuractionCell: UICollectionViewCell {
    @IBOutlet weak var lblDuration: UILabel!
}
