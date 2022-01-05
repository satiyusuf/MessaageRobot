//
//  NewCreateSegmentVC.swift
//  MassageRobot
//
//  Created by Emp-Mac on 01/11/21.
//

import UIKit
import Foundation

class NewCreateSegmentVC: UIViewController, UIScrollViewDelegate {

    //MARK:- Outlet
    @IBOutlet weak var btnIsLink: UIButton!
    @IBOutlet weak var ImgImage: UIImageView!
    @IBOutlet weak var ImgLeft: UIImageView!
    @IBOutlet weak var ImgRight: UIImageView!
    @IBOutlet weak var RuleView: UIView!
    @IBOutlet weak var RoutinScroll: UIScrollView!
    
    //SegmentCreateViewOutlet
    @IBOutlet weak var SegmentCreateView: UIView!
    @IBOutlet weak var btnMinesh: UIButton!
    @IBOutlet weak var btnPlush: UIButton!
    
    //BodySelectionOutlet
    @IBOutlet weak var ImgMaleBodyPartImage: UIImageView!
    @IBOutlet weak var MaleBodyPartSelectionView: UIView!
    @IBOutlet weak var FemaleBodyPartSelectionView: UIView!
    @IBOutlet weak var ImgFemaleBodyPartImage: UIImageView!
    
    //Slider Value Change Outlet
    @IBOutlet weak var SliderView: UIView!
    @IBOutlet weak var lblSliderValue: UILabel!
    @IBOutlet weak var SliderValue: UISlider!
    //CollectionView
    @IBOutlet weak var ColleData: UICollectionView!
    @IBOutlet weak var ColleRuler: UICollectionView!
    @IBOutlet weak var ViewAdd: UIView!

    @IBOutlet weak var FemaleLeftSideFirstHe: NSLayoutConstraint!
    @IBOutlet weak var FemaleLeftSideSecondHe: NSLayoutConstraint!
    @IBOutlet weak var MaleHeight: NSLayoutConstraint!
    @IBOutlet weak var MaleFirstButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var MaleLeadingFirst: NSLayoutConstraint!
    @IBOutlet weak var MaleSecondTop: NSLayoutConstraint!
    @IBOutlet weak var MaleBackTrailing: NSLayoutConstraint!
    @IBOutlet weak var MaleBackSecondTopHe: NSLayoutConstraint!
    @IBOutlet weak var MaleBackFirstLeading: NSLayoutConstraint!
    @IBOutlet weak var MaleBackThirdTop: NSLayoutConstraint!
    @IBOutlet weak var MaleBackFourTop: NSLayoutConstraint!
    @IBOutlet weak var MaleBackFiveTop: NSLayoutConstraint!
    @IBOutlet weak var MaleBackSixTop: NSLayoutConstraint!
    @IBOutlet weak var ToolsView: UIView!
    
    //MARK:- Variable
    var arrSegmentList = [[String: Any]]()
    var arrRulerCount = [[String: Any]]()
    var CellWidth = 28
    var arrUserDetail = [[String: Any]]()
    var CurrentIndex:Int = 0
    var FrontAndBackImage = String()
    var StrLeftRightLocation = String()
    var StrLeftImagePart = String()
    var StrRightImagePart = String()
    var SliderValueSet = String()
    var SliderLeftRight = String()
    var strPath: String!
    var strRoutingUID: String!
    var StrGender = String()
    var StrRoutingID = String()
    let picker = UIPickerView()
    var ToolsLeftRight = String()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.ColleRuler.delegate = self
        self.ColleRuler.dataSource = self
        
        self.getUserDetailAPICall()
        let nib = UINib(nibName: "SegmentCreate", bundle: nil)
        ColleData.register(nib, forCellWithReuseIdentifier: "SegmentCreate")
        NotificationCenter.default.addObserver(self, selector: #selector(self.TimeReceivedNotification(notification:)), name: Notification.Name("Time"), object: nil)
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? "9ccx8ms5pc0000000000"
        
        if strPath == "CreateRoutine" {
            SegmentCreateView.isHidden = false
        }else {
            if userID == strRoutingUID {
                SegmentCreateView.isHidden = false
            }else {
                SegmentCreateView.isHidden = true
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.FemaleLeftSideFirstHe.constant = 120
            self.FemaleLeftSideSecondHe.constant = 105
            self.MaleHeight.constant = 620
            self.MaleFirstButtonHeight.constant = 40
            self.MaleLeadingFirst.constant = -205
            self.MaleSecondTop.constant = 145
            self.MaleBackTrailing.constant = 200
            self.MaleBackSecondTopHe.constant = 140
            self.MaleBackFirstLeading.constant = 85
            self.MaleBackThirdTop.constant = 41
            self.MaleBackFourTop.constant = 30
            self.MaleBackFiveTop.constant = 34
            self.MaleBackSixTop.constant = 60
        } 
    }
    
    //MARK:- Action
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnToolsHide(_ sender: Any) {
        self.ToolsView.isHidden = true
    }
    @IBAction func btnInline(_ sender: Any) {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        if self.btnIsLink.isSelected == true {
            if ToolsLeftRight == "RightTools" {
                cell.txtRightTool.text = "Inline"
            } else if ToolsLeftRight == "LeftTools" {
                cell.txtLeftTool.text = "Inline"
            }
        }else {
            cell.txtRightTool.text = "Inline"
            cell.txtLeftTool.text = "Inline"
        }
        self.ToolsView.isHidden = true
    }
    
    @IBAction func btnOmni(_ sender: Any) {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        if self.btnIsLink.isSelected == true {
            if ToolsLeftRight == "RightTools" {
                cell.txtRightTool.text = "Omni"
            } else if ToolsLeftRight == "LeftTools" {
                cell.txtLeftTool.text = "Omni"
            }
        }else {
            cell.txtRightTool.text = "Omni"
            cell.txtLeftTool.text = "Omni"
        }
        self.ToolsView.isHidden = true
    }
    @IBAction func btnPoint(_ sender: Any) {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        if self.btnIsLink.isSelected == true {
            if ToolsLeftRight == "RightTools" {
                cell.txtRightTool.text = "Point"
            } else if ToolsLeftRight == "LeftTools" {
                cell.txtLeftTool.text = "Point"
            }
        }else {
            cell.txtRightTool.text = "Point"
            cell.txtLeftTool.text = "Point"
        }
        self.ToolsView.isHidden = true
    }
    @IBAction func Shiatsu(_ sender: Any) {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        if self.btnIsLink.isSelected == true {
            if ToolsLeftRight == "RightTools" {
                cell.txtRightTool.text = "Shiatsu"
            } else if ToolsLeftRight == "LeftTools" {
                cell.txtLeftTool.text = "Shiatsu"
            }
        }else {
            cell.txtRightTool.text = "Shiatsu"
            cell.txtLeftTool.text = "Shiatsu"
        }
        self.ToolsView.isHidden = true
    }
    @IBAction func btnSport(_ sender: Any) {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        if self.btnIsLink.isSelected == true {
            if ToolsLeftRight == "RightTools" {
                cell.txtRightTool.text = "Sport"
            } else if ToolsLeftRight == "LeftTools" {
                cell.txtLeftTool.text = "Sport"
            }
        }else {
            cell.txtRightTool.text = "Sport"
            cell.txtLeftTool.text = "Sport"
        }
        self.ToolsView.isHidden = true
    }
    @IBAction func Percussion(_ sender: Any) {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        if self.btnIsLink.isSelected == true {
            if ToolsLeftRight == "RightTools" {
                cell.txtRightTool.text = "Precussion"
            } else if ToolsLeftRight == "LeftTools" {
                cell.txtLeftTool.text = "Precussion"
            }
        }else {
            cell.txtRightTool.text = "Precussion"
            cell.txtLeftTool.text = "Precussion"
        }
        self.ToolsView.isHidden = true
    }
    @IBAction func Vibration(_ sender: Any) {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        if self.btnIsLink.isSelected == true {
            if ToolsLeftRight == "RightTools" {
                cell.txtRightTool.text = "vibration"
            } else if ToolsLeftRight == "LeftTools" {
                cell.txtLeftTool.text = "vibration"
            }
        }else {
            cell.txtRightTool.text = "vibration"
            cell.txtLeftTool.text = "vibration"
        }
        self.ToolsView.isHidden = true
    }
    
    
    @IBAction func btnReset(_ sender: Any) {
        self.ReSetData()
    }
    @IBAction func btnIsLink(_ sender: Any) {
        
        if btnIsLink.isSelected == false {
            self.btnIsLink.isSelected = true
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["Islink":"true"])
            print("isSelected true")
        } else if btnIsLink.isSelected == true {
            self.btnIsLink.isSelected = false
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["Islink":"false"])
            print("isSelected false")
        }
    }
    @IBAction func btnFirstSegment(_ sender: Any) {
        
        CurrentIndex = 0
        let indexPath = IndexPath(item: CurrentIndex , section: 0)
        ColleData.scrollToItem(at: indexPath, at: .left, animated: true)
        defer {
            self.DataFill(Index: CurrentIndex)
        }
        self.ColleRuler.reloadData()
    }
   
    @IBAction func btnMinesh(_ sender: Any) {
        
        if arrSegmentList.count > 1 {
            let last = arrSegmentList.count - 1
            if last == CurrentIndex {
                
            } else {
                
                self.SegmentDelete(Index: CurrentIndex)
            }
        }
    }
    @IBAction func btnPlush(_ sender: Any)
    {
        
        
        if strPath == "NotCreateRoutine" {
            if arrSegmentList.count > 1 {
                let LastIndex = arrSegmentList.count - 1
                if LastIndex == CurrentIndex{
                self.SegmentCreateDataEmty()
                } else {
                    self.SegmentUpdateDataEmty()
                }
            }
            else {
                self.SegmentUpdateDataEmty()
            }
           
        }else {
            
            if arrSegmentList.count > 1 {
                let LastIndex = arrSegmentList.count - 1
                if LastIndex == CurrentIndex{
                    self.SegmentCreateDataEmty()
                } else {
                    self.SegmentUpdateDataEmty()
                }
            } else {
                self.SegmentCreateDataEmty()
            }
        }
    }
   
    @IBAction func btnLastSegment(_ sender: Any) {
        
        CurrentIndex = arrSegmentList.count - 1
        let indexPath = IndexPath(item: CurrentIndex , section: 0)
        ColleData.scrollToItem(at: indexPath, at: .right, animated: true)
        defer {
            self.DataFill(Index: CurrentIndex)
        }
        self.ColleRuler.reloadData()
    }
    @IBAction func btnPrevi(_ sender: Any) {
        
        if ColleData.contentOffset.x > 0 {
            CurrentIndex -= 1
            let indexPath = IndexPath(item: CurrentIndex , section: 0)
            ColleData.scrollToItem(at: indexPath, at: .left, animated: true)
            defer {
                self.DataFill(Index: CurrentIndex)
            }
            self.ColleRuler.reloadData()
        }
    }
    @IBAction func btnNext(_ sender: Any) {
        
        if ColleData.contentOffset.x < self.view.bounds.width * CGFloat(arrSegmentList.count - 1)
        {
            CurrentIndex += 1
            let indexPath = IndexPath(item: CurrentIndex , section: 0)
            ColleData.scrollToItem(at: indexPath, at: .right, animated: true)
            defer {
                self.DataFill(Index: CurrentIndex)
            }
            self.ColleRuler.reloadData()
        }
    }
    //MARK:- Slider Value Change Action
    
    @IBAction func SliderValue(_ sender: UISlider) {
        
        sender.value = roundf(sender.value)
        let trackRect = sender.trackRect(forBounds: sender.frame)
        let thumbRect = sender.thumbRect(forBounds: sender.bounds, trackRect: trackRect, value: sender.value)
        lblSliderValue.center = CGPoint(x: thumbRect.midX, y: lblSliderValue.center.y)
        lblSliderValue.text = "\(Int(sender.value))"
    }
    @IBAction func btnSliderViewHide(_ sender: Any) {
        
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        
        if SliderValueSet == "speed" {

            if self.btnIsLink.isSelected == true {
                if SliderLeftRight == "Left" {
                   
                    cell.LeftSpeedTree.layer.sublayers = nil;
                    cell.LeftSpeedText.text = "\(Int(SliderValue.value))%"
                    let triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
                    triLeftSpeed.backgroundColor = .white
                    triLeftSpeed.setFillValue(value: CGFloat(SliderValue.value / 100))
                    cell.LeftSpeedTree.addSubview(triLeftSpeed)
                } else if SliderLeftRight == "Right" {
                    cell.RightSpeedTree.layer.sublayers = nil;
                    cell.RightSpeedText.text = "\(Int(SliderValue.value))%"
                    let triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
                    triRightSpeed.backgroundColor = .white
                    triRightSpeed.setFillValue(value: CGFloat( SliderValue.value / 100))
                    cell.RightSpeedTree.addSubview(triRightSpeed)
                }
            } else {

                cell.RightSpeedTree.layer.sublayers = nil;
                cell.LeftSpeedTree.layer.sublayers = nil;
                
                cell.LeftSpeedText.text = "\(Int(SliderValue.value))%"
                let triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
                triLeftSpeed.backgroundColor = .white
                triLeftSpeed.setFillValue(value: CGFloat(SliderValue.value / 100))
                cell.LeftSpeedTree.addSubview(triLeftSpeed)

                cell.RightSpeedText.text = "\(Int(SliderValue.value))%"
                let triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
                triRightSpeed.backgroundColor = .white
                triRightSpeed.setFillValue(value: CGFloat( SliderValue.value / 100))
                cell.RightSpeedTree.addSubview(triRightSpeed)
            }

        } else if SliderValueSet == "force" {

            if self.btnIsLink.isSelected == true {
                if SliderLeftRight == "Left" {
                    cell.LeftForceTree.layer.sublayers = nil;
                    cell.LeftForceText.text = "\(Int(SliderValue.value))%"
                    let triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: 140 , height: 33))
                    triLeftForce.backgroundColor = .white
                    triLeftForce.setFillValue(value: CGFloat(SliderValue.value / 100))
                    cell.LeftForceTree.addSubview(triLeftForce)
                } else if SliderLeftRight == "Right" {
                    cell.RightForceTree.layer.sublayers = nil;
                    cell.RightForceText.text = "\(Int(SliderValue.value))%"
                    let triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
                    triRightForce.backgroundColor = .white
                    triRightForce.setFillValue(value: CGFloat( SliderValue.value / 100))
                    cell.RightForceTree.addSubview(triRightForce)
                }
            } else {
                cell.LeftForceTree.layer.sublayers = nil;
                cell.RightForceTree.layer.sublayers = nil;
                
                cell.LeftForceText.text = "\(Int(SliderValue.value))%"
                let triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: 140 , height: 33))
                triLeftForce.backgroundColor = .white
                triLeftForce.setFillValue(value: CGFloat(SliderValue.value / 100))
                cell.LeftForceTree.addSubview(triLeftForce)

                cell.RightForceText.text = "\(Int(SliderValue.value))%"
                let triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
                triRightForce.backgroundColor = .white
                triRightForce.setFillValue(value: CGFloat( SliderValue.value / 100))
                cell.RightForceTree.addSubview(triRightForce)
            }
        }

        SliderValue.reloadInputViews()
        
        self.SliderView.isHidden = true
    }
    // **************************************   Female Body   **************************************
    //FemaleFrontRightSide
    @IBAction func btnFemaleFrontRightPectoralis(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
                self.StrLeftImagePart = "pectoralis"
            } else if StrLeftRightLocation == "Right" {
                
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
                self.StrRightImagePart = "pectoralis"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
            cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
            self.StrRightImagePart = "pectoralis"
            self.StrLeftImagePart = "pectoralis"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontRightIliotibalTract(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrLeftImagePart = "iliotibal tract"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrRightImagePart = "iliotibal tract"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
            cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
            self.StrLeftImagePart = "iliotibal tract"
            self.StrRightImagePart = "iliotibal tract"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontRightQuadracepts(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
                self.StrLeftImagePart = "quadracepts"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
                self.StrRightImagePart = "quadracepts"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
            cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
            self.StrRightImagePart = "quadracepts"
            self.StrLeftImagePart = "quadracepts"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontRightBodyparam(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("knee", for: .normal)
                self.StrLeftImagePart = "knee"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("knee", for: .normal)
                self.StrRightImagePart = "knee"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("knee", for: .normal)
            cell.btnRightLocation.setTitle("knee", for: .normal)
            self.StrRightImagePart = "knee"
            self.StrLeftImagePart = "knee"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontRightTibalisAnterior(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrRightImagePart = "tibalis anterior"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
            cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
            self.StrLeftImagePart = "tibalis anterior"
            self.StrRightImagePart = "tibalis anterior"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    //FemaleFrontLeftSide
    @IBAction func btnFemaleFrontLeftPectoralis(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
                self.StrLeftImagePart = "pectoralis"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
                self.StrRightImagePart = "pectoralis"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
            cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
            self.StrLeftImagePart = "pectoralis"
            self.StrRightImagePart = "pectoralis"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontLeftIliotibalTract(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrLeftImagePart = "iliotibal tract"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrRightImagePart = "iliotibal tract"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
            cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
            self.StrLeftImagePart = "iliotibal tract"
            self.StrRightImagePart = "iliotibal tract"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontLeftQuadracepts(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
                self.StrLeftImagePart = "quadracepts"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
                self.StrRightImagePart = "quadracepts"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
            cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
            self.StrRightImagePart = "quadracepts"
            self.StrLeftImagePart = "quadracepts"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontLeftBodyparam(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("knee", for: .normal)
                self.StrLeftImagePart = "knee"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("knee", for: .normal)
                self.StrRightImagePart = "knee"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("knee", for: .normal)
            cell.btnLeftLocation.setTitle("knee", for: .normal)
            self.StrLeftImagePart = "knee"
            self.StrRightImagePart = "knee"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleFrontLeftTibalisAnterior(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrRightImagePart = "tibalis anterior"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
            cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
            self.StrLeftImagePart = "tibalis anterior"
            self.StrRightImagePart = "tibalis anterior"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    //FemaleBackRightSide
    @IBAction func btnFemaleBackRightDeltoid(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
                self.StrLeftImagePart = "deltoid"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Deltoid", for: .normal)
                self.StrRightImagePart = "deltoid"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
            cell.btnRightLocation.setTitle("Deltoid", for: .normal)
            self.StrLeftImagePart = "deltoid"
            self.StrRightImagePart = "deltoid"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackRightUpperback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Upperback", for: .normal)
                self.StrLeftImagePart = "upperback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Upperback", for: .normal)
                self.StrRightImagePart = "upperback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Upperback", for: .normal)
            cell.btnRightLocation.setTitle("Upperback", for: .normal)
            self.StrLeftImagePart = "upperback"
            self.StrRightImagePart = "upperback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackRightLowerback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
                self.StrLeftImagePart = "lowerback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Lowerback", for: .normal)
                self.StrRightImagePart = "lowerback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
            cell.btnRightLocation.setTitle("Lowerback", for: .normal)
            self.StrRightImagePart = "lowerback"
            self.StrLeftImagePart = "lowerback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackRightGastrocnemius(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrLeftImagePart = "gastrocnemius"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrRightImagePart = "gastrocnemius"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
            cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
            self.StrLeftImagePart = "gastrocnemius"
            self.StrRightImagePart = "gastrocnemius"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackRightHamstring(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
       if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
                self.StrLeftImagePart = "hamstring"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Hamstring", for: .normal)
                self.StrRightImagePart = "hamstring"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
            cell.btnRightLocation.setTitle("Hamstring", for: .normal)
            self.StrLeftImagePart = "hamstring"
            self.StrRightImagePart = "hamstring"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackRightGlutiusmaximus(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Calves", for: .normal)
                self.StrLeftImagePart = "calves"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Calves", for: .normal)
                self.StrRightImagePart = "calves"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Calves", for: .normal)
            cell.btnRightLocation.setTitle("Calves", for: .normal)
            self.StrLeftImagePart = "calves"
            self.StrRightImagePart = "calves"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    //FemaleBackLeftSide
    @IBAction func btnFemaleBackLeftDeltoid(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
                self.StrLeftImagePart = "deltoid"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Deltoid", for: .normal)
                self.StrRightImagePart = "deltoid"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
            cell.btnRightLocation.setTitle("Deltoid", for: .normal)
            self.StrLeftImagePart = "deltoid"
            self.StrRightImagePart = "deltoid"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackLeftUpperback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Upperback", for: .normal)
                self.StrLeftImagePart = "upperback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Upperback", for: .normal)
                self.StrRightImagePart = "upperback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Upperback", for: .normal)
            cell.btnRightLocation.setTitle("Upperback", for: .normal)
            self.StrLeftImagePart = "upperback"
            self.StrRightImagePart = "upperback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackLeftLowerback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
                self.StrLeftImagePart = "lowerback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Lowerback", for: .normal)
                self.StrRightImagePart = "lowerback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
            cell.btnRightLocation.setTitle("Lowerback", for: .normal)
            self.StrLeftImagePart = "lowerback"
            self.StrRightImagePart = "lowerback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackLeftGastrocnemius(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrLeftImagePart = "gastrocnemius"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrRightImagePart = "gastrocnemius"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
            cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
            self.StrLeftImagePart = "gastrocnemius"
            self.StrRightImagePart = "gastrocnemius"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackLeftHamstring(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
                self.StrLeftImagePart = "hamstring"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Hamstring", for: .normal)
                self.StrRightImagePart = "hamstring"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
            cell.btnRightLocation.setTitle("Hamstring", for: .normal)
            self.StrLeftImagePart = "hamstring"
            self.StrRightImagePart = "hamstring"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFemaleBackLeftGlutiusmaximus(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Calves", for: .normal)
                self.StrLeftImagePart = "calves"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Calves", for: .normal)
                self.StrRightImagePart = "calves"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Calves", for: .normal)
            cell.btnRightLocation.setTitle("Calves", for: .normal)
            self.StrLeftImagePart = "calves"
            self.StrRightImagePart = "calves"

        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    // **************************************   Male Body   **************************************
    //MaleFrontRightSide
    @IBAction func btnFrontRightPectoralis(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
                self.StrLeftImagePart = "pectoralis"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
                self.StrRightImagePart = "pectoralis"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
            cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
            self.StrRightImagePart = "pectoralis"
            self.StrLeftImagePart = "pectoralis"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightIliotibalTract(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrLeftImagePart = "iliotibal tract"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrRightImagePart = "iliotibal tract"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
            cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
            self.StrLeftImagePart = "iliotibal tract"
            self.StrRightImagePart = "iliotibal tract"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightQuadracepts(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
                self.StrLeftImagePart = "quadracepts"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
                self.StrRightImagePart = "quadracepts"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
            cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
            self.StrRightImagePart = "quadracepts"
            self.StrLeftImagePart = "quadracepts"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightBodyparam(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("knee", for: .normal)
                self.StrLeftImagePart = "knee"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("knee", for: .normal)
                self.StrRightImagePart = "knee"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("knee", for: .normal)
            cell.btnRightLocation.setTitle("knee", for: .normal)
            self.StrRightImagePart = "knee"
            self.StrLeftImagePart = "knee"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightTibalisAnterior(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrRightImagePart = "tibalis anterior"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
            cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
            self.StrLeftImagePart = "tibalis anterior"
            self.StrRightImagePart = "tibalis anterior"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    //MaleFrontLeftSide
    @IBAction func btnFrontLeftPectoralis(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
                self.StrLeftImagePart = "pectoralis"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
                self.StrRightImagePart = "pectoralis"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
            cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
            self.StrLeftImagePart = "pectoralis"
            self.StrRightImagePart = "pectoralis"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftIliotibalTract(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrLeftImagePart = "iliotibal tract"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrRightImagePart = "iliotibal tract"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
            cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
            self.StrLeftImagePart = "iliotibal tract"
            self.StrRightImagePart = "iliotibal tract"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftQuadracepts(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
                self.StrLeftImagePart = "quadracepts"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
                self.StrRightImagePart = "quadracepts"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
            cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
            self.StrRightImagePart = "quadracepts"
            self.StrLeftImagePart = "quadracepts"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftBodyparam(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("knee", for: .normal)
                self.StrLeftImagePart = "knee"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("knee", for: .normal)
                self.StrRightImagePart = "knee"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("knee", for: .normal)
            cell.btnLeftLocation.setTitle("knee", for: .normal)
            self.StrLeftImagePart = "knee"
            self.StrRightImagePart = "knee"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftTibalisAnterior(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "F"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrRightImagePart = "tibalis anterior"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
            cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
            self.StrLeftImagePart = "tibalis anterior"
            self.StrRightImagePart = "tibalis anterior"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    //MaleBackRightSide
    @IBAction func btnBackRightDeltoid(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
                self.StrLeftImagePart = "deltoid"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Deltoid", for: .normal)
                self.StrRightImagePart = "deltoid"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
            cell.btnRightLocation.setTitle("Deltoid", for: .normal)
            self.StrLeftImagePart = "deltoid"
            self.StrRightImagePart = "deltoid"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightUpperback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Upperback", for: .normal)
                self.StrLeftImagePart = "upperback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Upperback", for: .normal)
                self.StrRightImagePart = "upperback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Upperback", for: .normal)
            cell.btnRightLocation.setTitle("Upperback", for: .normal)
            self.StrLeftImagePart = "upperback"
            self.StrRightImagePart = "upperback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightLowerback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
                self.StrLeftImagePart = "lowerback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Lowerback", for: .normal)
                self.StrRightImagePart = "lowerback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
            cell.btnRightLocation.setTitle("Lowerback", for: .normal)
            self.StrRightImagePart = "lowerback"
            self.StrLeftImagePart = "lowerback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRIghtGastrocnemius(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrLeftImagePart = "gastrocnemius"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrRightImagePart = "gastrocnemius"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
            cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
            self.StrLeftImagePart = "gastrocnemius"
            self.StrRightImagePart = "gastrocnemius"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightHamstring(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
       if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
                self.StrLeftImagePart = "hamstring"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Hamstring", for: .normal)
                self.StrRightImagePart = "hamstring"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
            cell.btnRightLocation.setTitle("Hamstring", for: .normal)
            self.StrLeftImagePart = "hamstring"
            self.StrRightImagePart = "hamstring"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightGlutiusmaximus(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Calves", for: .normal)
                self.StrLeftImagePart = "calves"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Calves", for: .normal)
                self.StrRightImagePart = "calves"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Calves", for: .normal)
            cell.btnRightLocation.setTitle("Calves", for: .normal)
            self.StrLeftImagePart = "calves"
            self.StrRightImagePart = "calves"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    
    //MaleBackLeftSide
    @IBAction func btnBackLeftDeltoid(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
                self.StrLeftImagePart = "deltoid"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Deltoid", for: .normal)
                self.StrRightImagePart = "deltoid"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
            cell.btnRightLocation.setTitle("Deltoid", for: .normal)
            self.StrLeftImagePart = "deltoid"
            self.StrRightImagePart = "deltoid"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftUpperback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Upperback", for: .normal)
                self.StrLeftImagePart = "upperback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Upperback", for: .normal)
                self.StrRightImagePart = "upperback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Upperback", for: .normal)
            cell.btnRightLocation.setTitle("Upperback", for: .normal)
            self.StrLeftImagePart = "upperback"
            self.StrRightImagePart = "upperback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftLowerback(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
                self.StrLeftImagePart = "lowerback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Lowerback", for: .normal)
                self.StrRightImagePart = "lowerback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
            cell.btnRightLocation.setTitle("Lowerback", for: .normal)
            self.StrLeftImagePart = "lowerback"
            self.StrRightImagePart = "lowerback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftGastrocnemius(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrLeftImagePart = "gastrocnemius"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrRightImagePart = "gastrocnemius"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
            cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
            self.StrLeftImagePart = "gastrocnemius"
            self.StrRightImagePart = "gastrocnemius"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftHamstring(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
                self.StrLeftImagePart = "hamstring"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Hamstring", for: .normal)
                self.StrRightImagePart = "hamstring"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
            cell.btnRightLocation.setTitle("Hamstring", for: .normal)
            self.StrLeftImagePart = "hamstring"
            self.StrRightImagePart = "hamstring"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftGlutiusmaximus(_ sender: Any) {
        if self.FrontAndBackImage.isEmpty == true {
           self.FrontAndBackImage = "B"
        }
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Calves", for: .normal)
                self.StrLeftImagePart = "calves"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Calves", for: .normal)
                self.StrRightImagePart = "calves"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Calves", for: .normal)
            cell.btnRightLocation.setTitle("Calves", for: .normal)
            self.StrLeftImagePart = "calves"
            self.StrRightImagePart = "calves"

        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.MaleBodyPartSelectionView.isHidden = true
    }
    
    @IBAction func btnBodyLocationSectionHide(_ sender: Any) {
        self.MaleBodyPartSelectionView.isHidden = true
        self.FemaleBodyPartSelectionView.isHidden = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

      let index: Int = Int(ColleData.contentOffset.x / ColleData.bounds.size.width)
      print("CurrentIndex::\(index)")
      self.CurrentIndex = index
      self.DataFill(Index: index)
        
      
      self.ColleRuler.reloadData()

        
    }
}
//MARK:- Call Api Function
extension NewCreateSegmentVC
{

    private func getUserDetailAPICall() {
        
        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='select r.userid, us.gender,u.firstname, u.lastname, u.email from routine r left join userdata u on r.userid=u.userid left join Userprofile us on  us.userid=u.userid where r.routineid ='\(StrRoutingID ?? "")''"

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
                            self.StrGender = Gender
                            if Gender == "F"
                            {
                                self.ImgImage.image = UIImage(named: "F-grey female body front")
                            }else{
                                self.ImgImage.image = UIImage(named: "grey male body front")
                            }
                            
                            if strPath == "NotCreateRoutine" {
                                self.GetAllSegmentListApiCall(Type: "Fetch")
                            }else {
                                let Dict = ["segment":"false"]
                                let Dict1 = ["segment":"false","duration":"28"]
                                arrSegmentList.append(Dict)
                                arrRulerCount.append(Dict1)
                                self.ColleData.reloadData()
                                self.ColleRuler.reloadData()
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
    
    func SegmentDelete(Index:Int) {
        
        let segmentData = arrSegmentList[Index]

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
                    self.GetAllSegmentListApiCall(Type: "Delete")
                }
            }
        }
    }
    private func CreateSegmentApiCAll()
    {
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let datetime = formatter.string(from: now)
        print(datetime)

        let timeAndDate = datetime.components(separatedBy: " ")

        let strDateC: String = String(format: "%@", timeAndDate[0])
        let strTimeC: String = String(format: "%@", timeAndDate[1])
        
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        let strTime = Int(cell.txtTime.text!)! * 60
        let strLeftForce = cell.LeftForceText.text!.stripped
        let strRightForce = cell.RightForceText.text!.stripped
        let strLeftLoction = cell.btnLeftLocation.titleLabel!.text!.lowercased()
        let strRightLocation = cell.btnRightLocation.titleLabel!.text!.lowercased()
        let strLeftPath = cell.txtLeftPath.text!.lowercased()
        let strRightPath = cell.txtRightPath.text!.lowercased()
        let strLeftSpeed = cell.LeftSpeedText.text!.stripped
        let strRightSpeed = cell.RightSpeedText.text!.stripped
        let strLeftTool = cell.txtLeftTool.text!.lowercased()
        let strRightTool = cell.txtRightTool.text!.lowercased()
        let strSegCount = cell.SegmentCount.text!
        
        let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=RoutineEntity&row=[('sagmet\(randomSegmentId())','\(strTime)','\(strLeftForce)','\(strRightForce)','\(String(describing: strLeftLoction))','\(String(describing: strRightLocation))','\(strLeftPath)','\(strRightPath)','\(strLeftSpeed)','\(strRightSpeed)','\(strDateC),\(strTimeC)','\(strLeftTool)','\(strRightTool)','\(strSegCount)','\(StrRoutingID)','\(FrontAndBackImage)')]"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            self.hideLoading()
            if json.getString(key: "Response") == "Success"
            {
                self.StrLeftRightLocation = ""
                self.StrLeftImagePart = ""
                self.StrRightImagePart = ""
                
                showToast(message: json.getString(key: "response_message"))
                self.GetAllSegmentListApiCall(Type: "Create")
            }
        }
    }
    
    func GetAllSegmentListApiCall(Type:String) {

        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Routineentity where routineID = '\(StrRoutingID)''"
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
                    self.arrSegmentList.removeAll()
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        arrSegmentList.append(contentsOf: jsonArray)
                        arrRulerCount.append(contentsOf: jsonArray)
                        self.CurrentIndex = 0
                        
                        
                        if Type == "Update" {
                            self.ColleData.reloadData()
                        } else if Type == "Delete" {
                            self.ColleData.reloadData()
                        } else if Type == "Fetch" {
                            let Dict = ["segment":"false"]
                            arrSegmentList.append(Dict)
                            self.ColleData.reloadData()
                        }
                        else {
                            let Dict = ["segment":"false"]
                            arrSegmentList.append(Dict)
                            self.ColleData.reloadData()
                            
                            CurrentIndex = arrSegmentList.count - 1
                            let indexPath = IndexPath(item: CurrentIndex , section: 0)
                            ColleData.scrollToItem(at: indexPath, at: .right, animated: true)
                        }
                        self.ColleRuler.reloadData()
                        self.arrRulerCount.removeAll()
                        
                        
                        for (index, element) in arrSegmentList.enumerated() {
                            var Size = element.getString(key: "duration")
                            var isCount = element.getString(key: "segment")
                            if isCount == "false" {
                                Size = "28"
                                let Dict = ["duration":Size,"segment":isCount]
                                self.arrRulerCount.append(Dict)
                            } else if isCount.isEmpty == true {
                                isCount = "true"
                                let Dict = ["duration":Int(Size)! / 60 ,"segment":isCount] as [String : Any]
                                self.arrRulerCount.append(Dict)
                            }
                        }
                        
                        self.ColleRuler.reloadData()
                        
                        //arrRuler.removeAll()
                        
                        /*
                        var xPos = 12;
                        
                        for (index, element) in arrSegmentList.enumerated() {

                            let size_du = (element.getString(key: "duration") as NSString).integerValue
                            
                           
                            var view = UIView()
                         
                            if(index != 0){
                                let oldView = arrRuler[index - 1]
                                xPos = Int(oldView.frame.origin.x) + size_du
                                view = UIView(frame: CGRect(x: xPos, y: 32, width: size_du == 0 ? 28 : size_du, height: 36))
                            } else {
                                view = UIView(frame: CGRect(x: xPos, y: 32, width: size_du == 0 ? 28 : size_du, height: 36))
                            }
                         
                            //xPos = xPos + size_du == 0 ? 28 : size_du
                         
                            
                            view.backgroundColor = UIColor.SegmentCountBGColor

                            let lblSegCount = UILabel(frame: CGRect(x: 4, y: 8, width: 20, height: 20))
                            lblSegCount.font = lblSegCount.font.withSize(10)
                            lblSegCount.textAlignment = .center

                            lblSegCount.text = "\(index)"

                            lblSegCount.textColor = UIColor.black
                            lblSegCount.backgroundColor = UIColor.white
                            lblSegCount.layer.masksToBounds = true
                            lblSegCount.layer.cornerRadius = 10.0

                            view.addSubview(lblSegCount)

                            RuleView.addSubview(view)
                            arrRuler.append(view)
                        }
                        
                        changeColorOfRuler(index: CurrentIndex)*/
                       
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func SegmentUpdateApiCall()
    {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        let strTime = Int(cell.txtTime.text!)! * 60
        let strLeftForce = cell.LeftForceText.text!.stripped
        let strRightForce = cell.RightForceText.text!.stripped
        let strLeftLoction = cell.btnLeftLocation.titleLabel!.text!.lowercased()
        let strRightLocation = cell.btnRightLocation.titleLabel!.text!.lowercased()
        let strLeftPath = cell.txtLeftPath.text!.lowercased()
        let strRightPath = cell.txtRightPath.text!.lowercased()
        let strLeftSpeed = cell.LeftSpeedText.text!.stripped
        let strRightSpeed = cell.RightSpeedText.text!.stripped
        let strLeftTool = cell.txtLeftTool.text!.lowercased()
        let strRightTool = cell.txtRightTool.text!.lowercased()
        
        let segmentData = arrSegmentList[CurrentIndex]
        
       let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='UPDATE Routineentity SET duration= '\(strTime)',force_l= '\(strLeftForce)',force_r= '\(strRightForce)',location_l= '\(strLeftLoction)',location_r= '\(strRightLocation)',path_l= '\(strLeftPath)',path_r= '\(strRightPath) ',speed_l= '\(strLeftSpeed)',speed_r= '\(strRightSpeed)',tool_l= '\(strLeftTool)',tool_r= '\(strRightTool)',body_location= '\(FrontAndBackImage)' WHERE segmentid= '\(segmentData.getString(key: "segmentid"))''"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            self.hideLoading()
            if json.getString(key: "Response") == "Success"
            {
                showToast(message: json.getString(key: "response_message"))
                self.GetAllSegmentListApiCall(Type: "Update")
            }
        }
    }
    
    private func SegmentCreateDataEmty()
    {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        
        if cell.txtLeftTool.text?.isEmpty == true {
            showToast(message: "Please insert left tool.")
            return
        } else if cell.txtRightTool.text?.isEmpty == true {
            showToast(message: "Please insert right tool.")
            return
        } else if cell.btnLeftLocation.titleLabel?.text! == "L. Location" {
            showToast(message: "Please insert left loction.")
            return
        } else if cell.btnRightLocation.titleLabel?.text! == "R. Location" {
            showToast(message: "Please insert right loction.")
            return
        } else if cell.txtLeftPath.text?.isEmpty == true {
            showToast(message: "Please insert left path.")
            return
        } else if cell.txtRightPath.text?.isEmpty == true {
            showToast(message: "Please insert right path.")
            return
        } else if cell.LeftSpeedText.text?.isEmpty == true {
            showToast(message: "Please insert left Speed.")
            return
        } else if cell.RightSpeedText.text?.isEmpty == true {
            showToast(message: "Please insert right Speed.")
            return
        } else if cell.LeftForceText.text?.isEmpty == true {
            showToast(message: "Please insert left Force.")
            return
        } else if cell.RightForceText.text?.isEmpty == true {
            showToast(message: "Please insert right Force.")
            return
        } else if cell.txtTime.text!.isEmpty == true {
            showToast(message: "Please insert Duraction.")
            return
        } else {
            self.CreateSegmentApiCAll()
        }
    }
    private func SegmentUpdateDataEmty()
    {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        
        if cell.txtLeftTool.text?.isEmpty == true {
            showToast(message: "Please insert left tool.")
            return
        } else if cell.txtRightTool.text?.isEmpty == true {
            showToast(message: "Please insert right tool.")
            return
        } else if cell.btnLeftLocation.titleLabel?.text! == "L. Location" {
            showToast(message: "Please insert left loction.")
            return
        } else if cell.btnRightLocation.titleLabel?.text! == "R. Location" {
            showToast(message: "Please insert right loction.")
            return
        } else if cell.txtLeftPath.text?.isEmpty == true {
            showToast(message: "Please insert left path.")
            return
        } else if cell.txtRightPath.text?.isEmpty == true {
            showToast(message: "Please insert right path.")
            return
        } else if cell.LeftSpeedText.text?.isEmpty == true {
            showToast(message: "Please insert left Speed.")
            return
        } else if cell.RightSpeedText.text?.isEmpty == true {
            showToast(message: "Please insert right Speed.")
            return
        } else if cell.LeftForceText.text?.isEmpty == true {
            showToast(message: "Please insert left Force.")
            return
        } else if cell.RightForceText.text?.isEmpty == true {
            showToast(message: "Please insert right Force.")
            return
        } else if cell.txtTime.text!.isEmpty == true {
            showToast(message: "Please insert Duraction.")
            return
        } else {
            self.SegmentUpdateApiCall()
        }
    }
    
    func DataFill(Index:Int)
    {
            
            let indexPath = IndexPath.init(row: Index, section: 0)
            let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
            
            let Data = arrSegmentList[Index]
            
            cell.SegmentCount.text = "\(Index + 1)"
        
        let segment = Data.getString(key: "segment")
        
        if segment == "false" {
            let duraction = Data.getString(key: "duration")
            cell.txtTime.text = duraction
        } else {
            let duraction = Data.getString(key: "duration")
            cell.txtTime.text = "\(Int(duraction)! / 60 )"
        }
           
            cell.txtLeftTool.text = Data.getString(key: "tool_l")
            cell.txtRightTool.text = Data.getString(key: "tool_r")
            cell.txtLeftPath.text = Data.getString(key: "path_l")
            cell.txtRightPath.text = Data.getString(key: "path_r")
            
        
//            cell.LeftSpeedText.text = Data["speed_l"] as? String ?? "0" //.getString(key: "")
//            cell.RightSpeedText.text = Data["speed_r"] as? String ?? "0" //getString(key: "speed_r")
//            cell.LeftForceText.text = Data["force_l"] as? String ?? "0" //.getString(key: "force_l")
//            cell.RightForceText.text = Data["force_r"] as? String ?? "0" //.getString(key: "force_r")
            
            
             let speed_l = (Data.getString(key: "speed_l") as NSString).floatValue
            let speed_r = (Data.getString(key: "speed_r") as NSString).floatValue
            let force_l = (Data.getString(key: "force_l") as NSString).floatValue
            let force_r = (Data.getString(key: "force_r") as NSString).floatValue
            
        cell.LeftSpeedText.text = "\(Int(speed_l))%"
        cell.RightSpeedText.text = "\(Int(speed_r))%"
        cell.LeftForceText.text = "\(Int(force_l))%"
        cell.RightForceText.text = "\(Int(force_r))%"
        
            cell.RightSpeedTree.layer.sublayers = nil;
            cell.LeftSpeedTree.layer.sublayers = nil;
            
            let triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
            triLeftSpeed.backgroundColor = .white
            triLeftSpeed.setFillValue(value: CGFloat(speed_l / 100))
            cell.LeftSpeedTree.addSubview(triLeftSpeed)

            let triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
            triRightSpeed.backgroundColor = .white
            triRightSpeed.setFillValue(value: CGFloat( speed_r / 100))
            cell.RightSpeedTree.addSubview(triRightSpeed)
            
            let triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: 140 , height: 33))
            triLeftForce.backgroundColor = .white
            triLeftForce.setFillValue(value: CGFloat(force_l / 100))
            cell.LeftForceTree.addSubview(triLeftForce)

            let triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
            triRightForce.backgroundColor = .white
            triRightForce.setFillValue(value: CGFloat( force_r / 100))
            cell.RightForceTree.addSubview(triRightForce)
            
        if arrSegmentList.count - 1 == CurrentIndex {
            
            let LeftLocation = Data["location_l"] as? String ?? "L. Location"//Data.getString(key: "")
            let RightLocation = Data["location_r"] as? String ?? "R. Location" //Data.getString(key: "location_r")
            let BodyLocation = Data["body_location"] as? String ?? "" //Data.getString(key: "body_location")
            //self.FrontAndBackImage = BodyLocation
            cell.btnLeftLocation.setTitle(LeftLocation, for: .normal)
            cell.btnRightLocation.setTitle(RightLocation, for: .normal)
            self.SetImagePart(LeftLocation: LeftLocation, RightLocation: RightLocation)
            
        } else {
            let LeftLocation = Data.getString(key: "location_l")
            let RightLocation = Data.getString(key: "location_r")
            let BodyLocation = Data["body_location"] as? String ?? ""
            if FrontAndBackImage.isEmpty == true {
                self.FrontAndBackImage = BodyLocation
            }
           // self.FrontAndBackImage = BodyLocation
            cell.btnLeftLocation.setTitle(LeftLocation, for: .normal)
            cell.btnRightLocation.setTitle(RightLocation, for: .normal)
            self.SetImagePart(LeftLocation: LeftLocation, RightLocation: RightLocation)
        }
        
            
    }
    
    func ReSetData()
    {
        
        let indexPath = IndexPath.init(row: self.CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        
        cell.txtTime.text = ""
        cell.txtLeftTool.text = ""
        cell.txtRightTool.text = ""
        cell.btnLeftLocation.setTitle("L. Location", for: .normal)
        cell.btnRightLocation.setTitle("R. Location", for: .normal)
        cell.txtLeftPath.text = ""
        cell.txtRightPath.text = ""
        
        cell.LeftSpeedText.text = "0%"
        cell.RightSpeedText.text = "0%"
        
        cell.RightSpeedTree.layer.sublayers = nil;
        cell.LeftSpeedTree.layer.sublayers = nil;
        
        let triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
        triLeftSpeed.backgroundColor = .white
        triLeftSpeed.setFillValue(value: CGFloat( 0 / 100))
        cell.LeftSpeedTree.addSubview(triLeftSpeed)

        let triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
        triRightSpeed.backgroundColor = .white
        triRightSpeed.setFillValue(value: CGFloat( 0 / 100))
        cell.RightSpeedTree.addSubview(triRightSpeed)
        
        cell.LeftForceText.text = "0%"
        cell.RightForceText.text = "0%"
        
        cell.LeftForceTree.layer.sublayers = nil;
        cell.RightForceTree.layer.sublayers = nil;
        
        let triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: 140 , height: 33))
        triLeftForce.backgroundColor = .white
        triLeftForce.setFillValue(value: CGFloat( 0 / 100))
        cell.LeftForceTree.addSubview(triLeftForce)

        let triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
        triRightForce.backgroundColor = .white
        triRightForce.setFillValue(value: CGFloat( 0 / 100))
        cell.RightForceTree.addSubview(triRightForce)
        
        self.FrontAndBackImage = ""
       
        self.StrLeftRightLocation = ""
        self.StrLeftImagePart = ""
        self.StrRightImagePart = ""
        self.SliderValueSet = ""
        self.SliderLeftRight = ""
        self.SetImagePart(LeftLocation: "", RightLocation: "")
    }
}
    





//MARK:- BodyPart Selection Image Set Private Function
extension NewCreateSegmentVC {
    
    private func SetImagePart(LeftLocation:String,RightLocation:String)
    {
        if StrGender == "F" {
            if FrontAndBackImage == "F" {
                self.ImgImage.image = UIImage(named: "F-grey female body front")
            } else if FrontAndBackImage == "B" {
                self.ImgImage.image = UIImage(named: "F-grey female body back")
            } else {
                self.ImgImage.image = UIImage(named: "F-grey female body front")
            }
        } else {
            if FrontAndBackImage == "F" {
                self.ImgImage.image = UIImage(named: "grey male body front")
            } else if FrontAndBackImage == "B" {
                self.ImgImage.image = UIImage(named: "grey male body back")
            } else {
                self.ImgImage.image = UIImage(named: "grey male body front")
            }
        }
        
        
        if StrGender == "F"
        {
            var ImageL = String()
            var ImageR = String()
            if LeftLocation == "upperback"
            {
                ImageL = "F-L-trap"
            }
            else if LeftLocation == "lowerback"
            {
                ImageL = "F-L-lower back"
            }
            else if LeftLocation == "hamstring"
            {
                ImageL = "F-L-ham"
            }
            else if LeftLocation == "gastrocnemius"
            {
                ImageL = "F-L-glut"
            }
            else if LeftLocation == "quadracepts"
            {
                ImageL = "F-L-quad"
            }
            else if LeftLocation == "iliotibal tract"
            {
                ImageL = "F-L-IT band"
            }
            else if LeftLocation == "tibalis anterior"
            {
                ImageL = "F-L-tibialis"
            }
            else if LeftLocation == "deltoid"
            {
                ImageL = "F-L-shoulder"
            }
            else if LeftLocation == "pectoralis"
            {
                ImageL = "F-L-pect"
            }
            else if LeftLocation == "calves"
            {
                ImageL = "F-L-calf"
            } else if LeftLocation == "knee" {
                ImageL = "F-L-knee"
            }
            
            
            if RightLocation == "upperback"
            {
                ImageR = "F-R-trap"
            }
            else if RightLocation == "lowerback"
            {
                ImageR = "F-R-lower back"
            }
            else if RightLocation == "hamstring"
            {
                ImageR = "F-R-ham"
            }
            else if RightLocation == "gastrocnemius"
            {
                ImageR = "F-R-glut"
            }
            else if RightLocation == "quadracepts"
            {
                ImageR = "F-R-quad"
            }
            else if RightLocation == "iliotibal tract"
            {
                ImageR = "F-R-IT band"
            }
            else if RightLocation == "tibalis anterior"
            {
                ImageR = "F-R-tibialis"
            }
            else if RightLocation == "deltoid"
            {
                ImageR = "F-R-shoulder"
            }
            else if RightLocation == "pectoralis"
            {
                ImageR = "F-R-pect"
            }
            else if RightLocation == "calves"
            {
                ImageR = "F-R-calf"
            } else if RightLocation == "knee" {
                ImageR = "F-R-knee"
            }
            
            self.ImgLeft.image = UIImage(named: ImageL)
            self.ImgRight.image = UIImage(named: ImageR)
        } else {
            
            var ImageL = String()
            var ImageR = String()
            if LeftLocation == "upperback"
            {
                ImageL = "L-trap"
            }
            else if LeftLocation == "lowerback"
            {
                ImageL = "L-lower back"
            }
            else if LeftLocation == "hamstring"
            {
                ImageL = "L-ham"
            }
            else if LeftLocation == "gastrocnemius"
            {
                ImageL = "L-glut"
            }
            else if LeftLocation == "quadracepts"
            {
                ImageL = "L-quad"
            }
            else if LeftLocation == "iliotibal tract"
            {
                ImageL = "L-IT band"
            }
            else if LeftLocation == "tibalis anterior"
            {
                ImageL = "L-tibialis"
            }
            else if LeftLocation == "deltoid"
            {
                ImageL = "L-shoulder"
            }
            else if LeftLocation == "pectoralis"
            {
                ImageL = "L-pect"
            }
            else if LeftLocation == "calves"
            {
                ImageL = "L-calf"
            } else if LeftLocation == "knee" {
                ImageL = "L-knee"
            }
            
            
            
            if RightLocation == "upperback"
            {
                ImageR = "R-trap"
            }
            else if RightLocation == "lowerback"
            {
                ImageR = "R-lower back"
            }
            else if RightLocation == "hamstring"
            {
                ImageR = "R-ham"
            }
            else if RightLocation == "gastrocnemius"
            {
                ImageR = "R-glut"
            }
            else if RightLocation == "quadracepts"
            {
                ImageR = "R-quad"
            }
            else if RightLocation == "iliotibal tract"
            {
                ImageR = "R-IT band"
            }
            else if RightLocation == "tibalis anterior"
            {
                ImageR = "R-tibialis"
            }
            else if RightLocation == "deltoid"
            {
                ImageR = "R-shoulder"
            }
            else if RightLocation == "pectoralis"
            {
                ImageR = "R-pect"
            }
            else if RightLocation == "calves"
            {
                ImageR = "R-calf"
            } else if RightLocation == "knee" {
                ImageR = "R-knee"
            }
            self.ImgLeft.image = UIImage(named: ImageL)
            self.ImgRight.image = UIImage(named: ImageR)
        }
    }
}

//MARK:- UICollectionViewDelegate And UICollectionViewDataSource
extension NewCreateSegmentVC : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == ColleRuler {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ColleRuler {
            return arrRulerCount.count
        } else {
            return arrSegmentList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ColleRuler {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RulerCell", for: indexPath) as! RulerCell
            cell.lblCount.text = "\(indexPath.row + 1)"
          //  cell.backgroundColor = UIColor.red
            
            if CurrentIndex == indexPath.row {
                cell.backgroundColor = UIColor.SegmentCountBGColor
            } else {
                cell.backgroundColor = UIColor.btnBGColor
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentCreate", for: indexPath) as! SegmentCreate
     
            cell.btnLeftLocation.tag = indexPath.row
            cell.btnLeftLocation.addTarget(self, action: #selector(LeftLocationSelection(sender:)), for: .touchUpInside)
            cell.btnRightLocation.tag = indexPath.row
            cell.btnRightLocation.addTarget(self, action: #selector(RightLocationSelection(sender:)), for: .touchUpInside)
            
            cell.btnLeftSpeed.tag = indexPath.row
            cell.btnLeftSpeed.addTarget(self, action: #selector(LeftSpeed(sender:)), for: .touchUpInside)
            cell.btnRightSpeed.tag = indexPath.row
            cell.btnRightSpeed.addTarget(self, action: #selector(RightSpeed(sender:)), for: .touchUpInside)
            
            cell.btnLeftForce.tag = indexPath.row
            cell.btnLeftForce.addTarget(self, action: #selector(LeftForce(sender:)), for: .touchUpInside)
            cell.btnRightForce.tag = indexPath.row
            cell.btnRightForce.addTarget(self, action: #selector(RightForce(sender:)), for: .touchUpInside)
            
            cell.btnLeftTools.tag = indexPath.row
            cell.btnLeftTools.addTarget(self, action: #selector(LeftTools(sender:)), for: .touchUpInside)
            cell.btnRightTools.tag = indexPath.row
            cell.btnRightTools.addTarget(self, action: #selector(RightTools(sender:)), for: .touchUpInside)
            
            let Data = arrSegmentList[indexPath.row]
            
            cell.SegmentCount.text = "\(indexPath.row + 1)"
            
            let duraction = Data.getString(key: "duration")
            
            if duraction.isEmpty == false {
                cell.txtTime.text = "\(Int(duraction)! / 60 )"
            }else {
                cell.txtTime.text = duraction
            }
           
            cell.txtLeftTool.text = Data.getString(key: "tool_l")
            cell.txtRightTool.text = Data.getString(key: "tool_r")
            cell.txtLeftPath.text = Data.getString(key: "path_l")
            cell.txtRightPath.text = Data.getString(key: "path_r")
                    
            let speed_l = (Data.getString(key: "speed_l") as NSString).floatValue
            let speed_r = (Data.getString(key: "speed_r") as NSString).floatValue
            let force_l = (Data.getString(key: "force_l") as NSString).floatValue
            let force_r = (Data.getString(key: "force_r") as NSString).floatValue
            
            cell.LeftSpeedText.text = "\(Int(speed_l))%"
            cell.RightSpeedText.text = "\(Int(speed_r))%"
            cell.LeftForceText.text = "\(Int(force_l))%"
            cell.RightForceText.text = "\(Int(force_r))%"
            
            cell.RightSpeedTree.layer.sublayers = nil;
            cell.LeftSpeedTree.layer.sublayers = nil;
            
            let triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: 140, height: 33))
            triLeftSpeed.backgroundColor = .white
            triLeftSpeed.setFillValue(value: CGFloat(speed_l / 100))
            cell.LeftSpeedTree.addSubview(triLeftSpeed)

            let triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
            triRightSpeed.backgroundColor = .white
            triRightSpeed.setFillValue(value: CGFloat( speed_r / 100))
            cell.RightSpeedTree.addSubview(triRightSpeed)
            
            let triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: 140 , height: 33))
            triLeftForce.backgroundColor = .white
            triLeftForce.setFillValue(value: CGFloat(force_l / 100))
            cell.LeftForceTree.addSubview(triLeftForce)

            let triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width:140 , height: 33))
            triRightForce.backgroundColor = .white
            triRightForce.setFillValue(value: CGFloat( force_r / 100))
            cell.RightForceTree.addSubview(triRightForce)
            
            if indexPath.row == arrSegmentList.count - 1 {
                let LeftLocation = Data["location_l"] as? String ?? "L. Location"//Data.getString(key: "")
                let RightLocation = Data["location_r"] as? String ?? "R. Location" //Data.getString(key: "location_r")
                let BodyLocation = Data["body_location"] as? String ?? "" //.getString(key: "body_location")
               // self.FrontAndBackImage = BodyLocation
                cell.btnLeftLocation.setTitle(LeftLocation, for: .normal)
                cell.btnRightLocation.setTitle(RightLocation, for: .normal)
                self.SetImagePart(LeftLocation: LeftLocation, RightLocation: RightLocation)
            } else {
                let LeftLocation = Data.getString(key: "location_l")
                let RightLocation = Data.getString(key: "location_r")
                let BodyLocation = Data["body_location"] as? String ?? ""
                if FrontAndBackImage.isEmpty == true {
                    self.FrontAndBackImage = BodyLocation
                }
              //  self.FrontAndBackImage = BodyLocation
                cell.btnLeftLocation.setTitle(LeftLocation, for: .normal)
                cell.btnRightLocation.setTitle(RightLocation, for: .normal)
                self.SetImagePart(LeftLocation: LeftLocation, RightLocation: RightLocation)
            }
            
            
            return cell
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension NewCreateSegmentVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == ColleRuler {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RulerCell", for: indexPath) as? RulerCell else {
                return CGSize.zero
            }
            //let Dict1 = ["duration":"30","IsCount":"False"]
            let IsCount = arrRulerCount[indexPath.row]["segment"] as? String ?? ""
         
            var Width = Int()
            
            if IsCount == "true" {
                let Duration = arrRulerCount[indexPath.row]["duration"] as? Int ?? 0
                Width = Duration * 28
            } else {
                let Duration = arrRulerCount[indexPath.row]["duration"] as? String ?? ""
                Width = Int(Duration)!
            }
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return CGSize(width: Width, height: 40)
            
        } else {
            let collectionWidth = view.bounds.width
            return CGSize(width: collectionWidth, height: 440)
        }
        
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            if collectionView == ColleRuler {
//
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RulerCell", for: indexPath) as? RulerCell else {
//                    return CGSize.zero
//                }
//                //let Dict1 = ["duration":"30","IsCount":"False"]
//                let IsCount = arrRulerCount[indexPath.row]["segment"] as? String ?? ""
//
//                var Width = Int()
//
//                if IsCount == "true" {
//                    let Duration = arrRulerCount[indexPath.row]["duration"] as? Int ?? 0
//                    Width = Duration * 28
//                } else {
//                    let Duration = arrRulerCount[indexPath.row]["duration"] as? String ?? ""
//                    Width = Int(Duration)!
//                }
//                cell.setNeedsLayout()
//                cell.layoutIfNeeded()
//                return CGSize(width: Width, height: 40)
//
//            } else {
//                let collectionWidth = view.bounds.width
//                return CGSize(width: collectionWidth, height: 440)
//            }
//
//        } else {
//            if collectionView == ColleRuler {
//                return CGSize(width: 28, height: 40)
//            } else {
//                let collectionWidth = view.bounds.width
//                return CGSize(width: collectionWidth, height: 440)
//            }
//
//
//        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


//MARK:- UICollectionView Selection Call Button Action
extension  NewCreateSegmentVC {
    
    @objc func LeftLocationSelection(sender: UIButton)
    {
        let indexPath = IndexPath.init(row: self.CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        self.StrLeftRightLocation = "Left"
        let strBodyPart = sender.title(for: .normal)
                
        if StrGender == "F" {
            self.FemaleBodyPartSelectionView.isHidden = false
            if btnIsLink.isSelected == true {
                
                if cell.btnRightLocation.titleLabel?.text == "R. Location" {
                    
                    if strBodyPart == "L. Location"{
                        if FrontAndBackImage == "F" {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                        } else if FrontAndBackImage == "B"{
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB-female")
                        } else {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "LeftBodyP-female")
                        }
                       
                    }else{
                        
                        if FrontAndBackImage == "F" {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                        } else if FrontAndBackImage == "B"{
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB-female")
                        }else {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                        }
                    }
                } else {
                        if FrontAndBackImage == "F" {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                        } else if FrontAndBackImage == "B"{
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB-female")
                        }else {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                        }
                }
            }
            else {
              
                if strBodyPart == "L. Location"{
                    
                    if FrontAndBackImage == "F" {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                    } else if FrontAndBackImage == "B"{
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB-female")
                    }else {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "LeftBodyP-female")
                    }
                }else{
                    
                    if FrontAndBackImage == "F" {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                    } else if FrontAndBackImage == "B"{
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB-female")
                    }else {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF-female")
                    }
                }
            }
        } else {
            self.MaleBodyPartSelectionView.isHidden = false
            if btnIsLink.isSelected == true {
                
                if cell.btnRightLocation.titleLabel?.text == "R. Location" {
                    
                    if strBodyPart == "L. Location"{
                        if FrontAndBackImage == "F" {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                        } else if FrontAndBackImage == "B"{
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                        }else {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "LeftBodyP")
                        }
                    }else{
                        
                        if FrontAndBackImage == "F" {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                        } else if FrontAndBackImage == "B"{
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                        }else {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                        }
                    }
                } else {
                        if FrontAndBackImage == "F" {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                        } else if FrontAndBackImage == "B"{
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                        }else {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                        }
                }
            }
            else {
              
                if strBodyPart == "L. Location"{
                    if FrontAndBackImage == "F" {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                    }else {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "LeftBodyP")
                    }
                   
                }else{
                    
                    if FrontAndBackImage == "F" {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                    }else {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                    }
                }
            }
        }
    }
    @objc func RightLocationSelection(sender: UIButton)
    {
        let indexPath = IndexPath.init(row: self.CurrentIndex, section: 0)
        let cell = ColleData.cellForItem(at: indexPath) as! SegmentCreate
        self.StrLeftRightLocation = "Right"
        let strBodyPart = sender.title(for: .normal)
        
        
        if StrGender == "F" {
            self.FemaleBodyPartSelectionView.isHidden = false
            if btnIsLink.isSelected == true {

                if cell.btnLeftLocation.titleLabel?.text == "L. Location" {
                 
                    if strBodyPart == "R. Location"{
                        if FrontAndBackImage == "F" {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightF-female")
                        } else if FrontAndBackImage == "B"{
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightB-female")
                        } else {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "RightBodyP-female")
                        }
                        
                    }else{
                        
                        if FrontAndBackImage == "F" {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightF-female")
                        } else if FrontAndBackImage == "B"{
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightB-female")
                        }
                    }
                } else {
                        
                        if FrontAndBackImage == "F" {
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightF-female")
                        } else if FrontAndBackImage == "B"{
                            self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightB-female")
                        }
                }
                
            } else {
               
                if strBodyPart == "R. Location"{
                    if FrontAndBackImage == "F" {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightF-female")
                    } else if FrontAndBackImage == "B"{
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightB-female")
                    }else {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "RightBodyP-female")
                    }
                }else{
                    
                    if FrontAndBackImage == "F" {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightF-female")
                    } else if FrontAndBackImage == "B"{
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightB-female")
                    }else {
                        self.ImgFemaleBodyPartImage.image = UIImage(named: "SecondTimeRightF-female")
                    }
                }
           }
        } else  {
            self.MaleBodyPartSelectionView.isHidden = false
            if btnIsLink.isSelected == true {

                if cell.btnLeftLocation.titleLabel?.text == "L. Location" {
                 
                    if strBodyPart == "R. Location"{
                        if FrontAndBackImage == "F" {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                        } else if FrontAndBackImage == "B"{
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                        } else {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "RightBodyP")
                        }
                        
                    }else{
                        
                        if FrontAndBackImage == "F" {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                        } else if FrontAndBackImage == "B"{
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                        }
                    }
                } else {
                        
                        if FrontAndBackImage == "F" {
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                        } else if FrontAndBackImage == "B"{
                            self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                        }
                }
                
            } else {
               
                if strBodyPart == "R. Location"{
                    if FrontAndBackImage == "F" {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                    }else {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "RightBodyP")
                    }
                   
                }else{
                    
                    if FrontAndBackImage == "F" {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                    }else {
                        self.ImgMaleBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                    }
                }
           }
        }
    }
    
    
    @objc func LeftTools(sender: UIButton)
    {
        print("LeftTools:-\(sender.tag)")
        self.ToolsView.isHidden = false
        self.ToolsLeftRight = "LeftTools"
    }
    @objc func RightTools(sender: UIButton)
    {
        print("RightTools:-\(sender.tag)")
        self.ToolsView.isHidden = false
        self.ToolsLeftRight = "RightTools"
    }
    
    
    @objc func LeftSpeed(sender: UIButton)
    {
        self.SliderValue.value = 0
        self.lblSliderValue.text = "0"
        self.SliderView.isHidden = false
        self.SliderValueSet = "speed"
        self.SliderLeftRight = "Left"
    }
    @objc func RightSpeed(sender: UIButton)
    {
        self.SliderValue.value = 0
        self.lblSliderValue.text = "0"
        self.SliderView.isHidden = false
        self.SliderValueSet = "speed"
        self.SliderLeftRight = "Right"
    }
    @objc func LeftForce(sender: UIButton)
    {
        self.SliderView.isHidden = false
        self.SliderValue.value = 0
        self.lblSliderValue.text = "0"
        self.SliderValueSet = "force"
        self.SliderLeftRight = "Left"
    }
    @objc func RightForce(sender: UIButton)
    {
        self.SliderValue.value = 0
        self.lblSliderValue.text = "0"
        self.SliderView.isHidden = false
        self.SliderValueSet = "force"
        self.SliderLeftRight = "Right"
    }
    
    @objc func TimeReceivedNotification(notification: Notification) {
        
        let Data = notification.userInfo! as NSDictionary
        let Time = Data["Time"] as! String 
        let Dict1 = ["duration": Int(Time),"segment":"true"] as [String : Any]
        self.arrRulerCount[CurrentIndex] = Dict1
        self.ColleRuler.reloadData()        
    }
}

extension String {

    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
}


//MARK:- UICollectionView Cell Class
class RulerCell: UICollectionViewCell {
    @IBOutlet weak var lblCount: UILabel!
}


//glutiusmaximus
//gastrocnemius
