//
//  NewCreateSegmentVC.swift
//  MassageRobot
//
//  Created by Emp-Mac on 01/11/21.
//

import UIKit

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
    @IBOutlet weak var btnBodyPartSelectionView: UIView!
    @IBOutlet weak var ImgBodyPartImage: UIImageView!
    
    //Slider Value Change Outlet
    @IBOutlet weak var SliderView: UIView!
    @IBOutlet weak var lblSliderValue: UILabel!
    @IBOutlet weak var SliderValue: UISlider!
    
    @IBOutlet weak var Collection: UICollectionView!
    
    var arrUserDetail = [[String: Any]]()
    
    var StrGender = String()
    var StrRoutingID = String()
    let picker = UIPickerView()
    
   
    
   
    
    @IBOutlet weak var ViewAdd: UIView!
    
    let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:340,height: 460))
    
    
    //MARK:- Variable
    var arrRuler = [UIView]()
    var arrSegmentList = [[String: Any]]()
    var numberOfRoutine = 0
    var CurrentIndex:Int = 0
       
    var FrontAndBackImage = String()
    var StrLeftRightLocation = String()
    var StrLeftImagePart = String()
    var StrRightImagePart = String()
    var SliderValueSet = String()
    var SliderLeftRight = String()
    
    var strPath: String!
    
    var strRoutingUID: String!
    
    var arrNewRule = [UILabel]()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.getUserDetailAPICall()
        let nib = UINib(nibName: "SegmentCreate", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "SegmentCreate")
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
            
            
        if strPath == "NotCreateRoutine" {
            self.GetAllSegmentListApiCall(Type: "Fetch")
        }else {
            let Dict = ["segment":"Emty"]
            arrSegmentList.append(Dict)
            self.Collection.reloadData()
            
//            let view = UIView(frame: CGRect(x: 12, y: 32, width: 28, height: 36))
//            view.backgroundColor = UIColor.SegmentCountBGColor
//
//            let lblSegCount = UILabel(frame: CGRect(x: 12, y: 32, width: 28, height: 36))
//            lblSegCount.font = lblSegCount.font.withSize(10)
//            lblSegCount.textAlignment = .center
//            lblSegCount.text = "01"
//            lblSegCount.textColor = UIColor.black
//            lblSegCount.backgroundColor = UIColor.red
//            lblSegCount.layer.masksToBounds = true
//            lblSegCount.layer.cornerRadius = 10.0
//
//            //view.addSubview(lblSegCount)
//            RuleView.addSubview(lblSegCount)
//            arrRuler.append(view)
           // changeColorOfRuler(index: CurrentIndex)
        }
    }
    
    //MARK:- Action
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
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
        Collection.scrollToItem(at: indexPath, at: .left, animated: true)
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
        Collection.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    @IBAction func btnPrevi(_ sender: Any) {
        
        if Collection.contentOffset.x > 0 {
            CurrentIndex -= 1
            let indexPath = IndexPath(item: CurrentIndex , section: 0)
            Collection.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    @IBAction func btnNext(_ sender: Any) {
        
        if Collection.contentOffset.x < self.view.bounds.width * CGFloat(arrSegmentList.count - 1)
        {
            CurrentIndex += 1
            let indexPath = IndexPath(item: CurrentIndex , section: 0)
            Collection.scrollToItem(at: indexPath, at: .right, animated: true)
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
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        
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
    //MARK:- Action
    // **************************************  Action Body Part Select  **************************************
    //FrontRightSide
    @IBAction func btnFrontRightPectoralis(_ sender: Any) {
        self.FrontAndBackImage = "F"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
                self.StrLeftImagePart = "pectoralis"
            } else if StrLeftRightLocation == "Right" {
                
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
                self.StrRightImagePart = "pectoralis"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
            cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
            self.StrRightImagePart = "pectoralis"
            self.StrLeftImagePart = "pectoralis"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightIliotibalTract(_ sender: Any) {
        self.FrontAndBackImage = "F"

        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrLeftImagePart = "iliotibal tract"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrRightImagePart = "iliotibal tract"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
            cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
            self.StrLeftImagePart = "iliotibal tract"
            self.StrRightImagePart = "iliotibal tract"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightQuadracepts(_ sender: Any) {
        self.FrontAndBackImage = "F"

        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
                self.StrLeftImagePart = "quadracepts"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
                self.StrRightImagePart = "quadracepts"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
            cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
            self.StrRightImagePart = "quadracepts"
            self.StrLeftImagePart = "quadracepts"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightBodyparam(_ sender: Any) {
        self.FrontAndBackImage = "F"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("bodyparam", for: .normal)
                self.StrLeftImagePart = "bodyparam"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("bodyparam", for: .normal)
                self.StrRightImagePart = "bodyparam"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("bodyparam", for: .normal)
            cell.btnRightLocation.setTitle("bodyparam", for: .normal)
            self.StrRightImagePart = "bodyparam"
            self.StrLeftImagePart = "bodyparam"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontRightTibalisAnterior(_ sender: Any) {
        self.FrontAndBackImage = "F"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrRightImagePart = "tibalis anterior"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
            cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
            self.StrLeftImagePart = "tibalis anterior"
            self.StrRightImagePart = "tibalis anterior"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    //FrontLeftSide
    @IBAction func btnFrontLeftPectoralis(_ sender: Any) {
        self.FrontAndBackImage = "F"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
                self.StrLeftImagePart = "pectoralis"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
                self.StrRightImagePart = "pectoralis"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Pectoralis", for: .normal)
            cell.btnRightLocation.setTitle("Pectoralis", for: .normal)
            self.StrLeftImagePart = "pectoralis"
            self.StrRightImagePart = "pectoralis"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftIliotibalTract(_ sender: Any) {
        self.FrontAndBackImage = "F"
       
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrLeftImagePart = "iliotibal tract"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
                self.StrRightImagePart = "iliotibal tract"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("iliotibal Tract", for: .normal)
            cell.btnRightLocation.setTitle("iliotibal Tract", for: .normal)
            self.StrLeftImagePart = "iliotibal tract"
            self.StrRightImagePart = "iliotibal tract"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftQuadracepts(_ sender: Any) {
        self.FrontAndBackImage = "F"

        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
                self.StrLeftImagePart = "quadracepts"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
                self.StrRightImagePart = "quadracepts"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("Quadracepts", for: .normal)
            cell.btnLeftLocation.setTitle("Quadracepts", for: .normal)
            self.StrRightImagePart = "quadracepts"
            self.StrLeftImagePart = "quadracepts"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftBodyparam(_ sender: Any) {
        self.FrontAndBackImage = "F"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Bodyparam", for: .normal)
                self.StrLeftImagePart = "bodyparam"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Bodyparam", for: .normal)
                self.StrRightImagePart = "bodyparam"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnRightLocation.setTitle("Bodyparam", for: .normal)
            cell.btnLeftLocation.setTitle("Bodyparam", for: .normal)
            self.StrLeftImagePart = "bodyparam"
            self.StrRightImagePart = "bodyparam"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnFrontLeftTibalisAnterior(_ sender: Any) {
        self.FrontAndBackImage = "F"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrLeftImagePart = "tibalis anterior"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
                self.StrRightImagePart = "tibalis anterior"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Tibalis Anterior", for: .normal)
            cell.btnRightLocation.setTitle("Tibalis Anterior", for: .normal)
            self.StrLeftImagePart = "tibalis anterior"
            self.StrRightImagePart = "tibalis anterior"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    //BackRightSide
    @IBAction func btnBackRightDeltoid(_ sender: Any) {
        self.FrontAndBackImage = "B"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
                self.StrLeftImagePart = "deltoid"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Deltoid", for: .normal)
                self.StrRightImagePart = "deltoid"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
            cell.btnRightLocation.setTitle("Deltoid", for: .normal)
            self.StrLeftImagePart = "deltoid"
            self.StrRightImagePart = "deltoid"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightUpperback(_ sender: Any) {
        self.FrontAndBackImage = "B"
       
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Upperback", for: .normal)
                self.StrLeftImagePart = "upperback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Upperback", for: .normal)
                self.StrRightImagePart = "upperback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Upperback", for: .normal)
            cell.btnRightLocation.setTitle("Upperback", for: .normal)
            self.StrLeftImagePart = "upperback"
            self.StrRightImagePart = "upperback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightLowerback(_ sender: Any) {
        self.FrontAndBackImage = "B"

        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
                self.StrLeftImagePart = "lowerback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Lowerback", for: .normal)
                self.StrRightImagePart = "lowerback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
            cell.btnRightLocation.setTitle("Lowerback", for: .normal)
            self.StrRightImagePart = "lowerback"
            self.StrLeftImagePart = "lowerback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
        
    }
    @IBAction func btnBackRIghtGastrocnemius(_ sender: Any) {
        self.FrontAndBackImage = "B"
    
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrLeftImagePart = "gastrocnemius"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrRightImagePart = "gastrocnemius"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
            cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
            self.StrLeftImagePart = "gastrocnemius"
            self.StrRightImagePart = "gastrocnemius"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightHamstring(_ sender: Any) {
        self.FrontAndBackImage = "B"
       if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
                self.StrLeftImagePart = "hamstring"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Hamstring", for: .normal)
                self.StrRightImagePart = "hamstring"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
            cell.btnRightLocation.setTitle("Hamstring", for: .normal)
            self.StrLeftImagePart = "hamstring"
            self.StrRightImagePart = "hamstring"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackRightGlutiusmaximus(_ sender: Any) {
        self.FrontAndBackImage = "B"

        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Glutiusmaximus", for: .normal)
                self.StrLeftImagePart = "glutiusmaximus"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Glutiusmaximus", for: .normal)
                self.StrRightImagePart = "glutiusmaximus"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Glutiusmaximus", for: .normal)
            cell.btnRightLocation.setTitle("Glutiusmaximus", for: .normal)
            self.StrLeftImagePart = "glutiusmaximus"
            self.StrRightImagePart = "glutiusmaximus"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    
    //BackLeftSide
    @IBAction func btnBackLeftDeltoid(_ sender: Any) {
        self.FrontAndBackImage = "B"

        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
                self.StrLeftImagePart = "deltoid"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Deltoid", for: .normal)
                self.StrRightImagePart = "deltoid"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Deltoid", for: .normal)
            cell.btnRightLocation.setTitle("Deltoid", for: .normal)
            self.StrLeftImagePart = "deltoid"
            self.StrRightImagePart = "deltoid"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftUpperback(_ sender: Any) {
        self.FrontAndBackImage = "B"

        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Upperback", for: .normal)
                self.StrLeftImagePart = "upperback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Upperback", for: .normal)
                self.StrRightImagePart = "upperback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Upperback", for: .normal)
            cell.btnRightLocation.setTitle("Upperback", for: .normal)
            self.StrLeftImagePart = "upperback"
            self.StrRightImagePart = "upperback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftLowerback(_ sender: Any) {
        self.FrontAndBackImage = "B"
    
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
                self.StrLeftImagePart = "lowerback"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Lowerback", for: .normal)
                self.StrRightImagePart = "lowerback"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Lowerback", for: .normal)
            cell.btnRightLocation.setTitle("Lowerback", for: .normal)
            self.StrLeftImagePart = "lowerback"
            self.StrRightImagePart = "lowerback"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftGastrocnemius(_ sender: Any) {
        self.FrontAndBackImage = "B"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrLeftImagePart = "gastrocnemius"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
                self.StrRightImagePart = "gastrocnemius"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Gastrocnemius", for: .normal)
            cell.btnRightLocation.setTitle("Gastrocnemius", for: .normal)
            self.StrLeftImagePart = "gastrocnemius"
            self.StrRightImagePart = "gastrocnemius"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftHamstring(_ sender: Any) {
        self.FrontAndBackImage = "B"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
                self.StrLeftImagePart = "hamstring"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Hamstring", for: .normal)
                self.StrRightImagePart = "hamstring"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Hamstring", for: .normal)
            cell.btnRightLocation.setTitle("Hamstring", for: .normal)
            self.StrLeftImagePart = "hamstring"
            self.StrRightImagePart = "hamstring"
        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    @IBAction func btnBackLeftGlutiusmaximus(_ sender: Any) {
        self.FrontAndBackImage = "B"
        
        if btnIsLink.isSelected == true {
            if StrLeftRightLocation == "Left" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnLeftLocation.setTitle("Glutiusmaximus", for: .normal)
                self.StrLeftImagePart = "glutiusmaximus"
            } else if StrLeftRightLocation == "Right" {
                let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
                let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
                cell.btnRightLocation.setTitle("Glutiusmaximus", for: .normal)
                self.StrRightImagePart = "glutiusmaximus"
            }
        } else {
            let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            cell.btnLeftLocation.setTitle("Glutiusmaximus", for: .normal)
            cell.btnRightLocation.setTitle("Glutiusmaximus", for: .normal)
            self.StrLeftImagePart = "glutiusmaximus"
            self.StrRightImagePart = "glutiusmaximus"

        }
        self.SetImagePart(LeftLocation: self.StrLeftImagePart, RightLocation: self.StrRightImagePart)
        self.btnBodyPartSelectionView.isHidden = true
    }
    
    @IBAction func btnBodyLocationSectionHide(_ sender: Any) {
        self.btnBodyPartSelectionView.isHidden = true
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

      let index: Int = Int(Collection.contentOffset.x / Collection.bounds.size.width)
      print("CurrentIndex::\(index)")
      self.CurrentIndex = index
      self.DataFill(Index: index)
        changeColorOfRuler(index: CurrentIndex)
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
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        let strTime = cell.txtTime.text!
        let strLeftForce = cell.LeftForceText.text!.stripped
        let strRightForce = cell.RightForceText.text!.stripped
        let strLeftLoction = cell.btnLeftLocation.titleLabel!.text!.lowercased()
        let strRightLocation = cell.btnRightLocation.titleLabel!.text!.lowercased()
        let strLeftPath = cell.txtLeftPath.text!
        let strRightPath = cell.txtRightPath.text!
        let strLeftSpeed = cell.LeftSpeedText.text!.stripped
        let strRightSpeed = cell.RightSpeedText.text!.stripped
        let strLeftTool = cell.txtLeftTool.text!
        let strRightTool = cell.txtRightTool.text!
        let strSegCount = cell.SegmentCount.text!
        
        let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=RoutineEntity&row=[('sagmet\(randomSegmentId())','\(strTime)','\(strLeftForce)','\(strRightForce)','\(String(describing: strLeftLoction))','\(String(describing: strRightLocation))','\(strLeftPath)','\(strRightPath)','\(strLeftSpeed)','\(strRightSpeed)','\(strDateC),\(strTimeC)','\(strLeftTool)','\(strRightTool)','\(strSegCount)','\(StrRoutingID)','\(FrontAndBackImage)')]"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        callAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            self.hideLoading()
            if json.getString(key: "Response") == "Success"
            {
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
                        
                        self.CurrentIndex = 0
                        
                        
                        if Type == "Update" {
                            self.Collection.reloadData()
                        } else if Type == "Delete" {
                            self.Collection.reloadData()
                        } else {
                            let Dict = ["segment":"Emty"]
                            arrSegmentList.append(Dict)
                            
                            self.Collection.reloadData()
                            
                            CurrentIndex = arrSegmentList.count - 1
                            let indexPath = IndexPath(item: CurrentIndex , section: 0)
                            Collection.scrollToItem(at: indexPath, at: .right, animated: true)
                        }
                        
                        arrRuler.removeAll()
                        
//                        for (index, element) in arrSegmentList.enumerated() {
//
//                            let size_du = (element.getString(key: "duration") as NSString).integerValue
//
//                            let view = UIView(frame: CGRect(x: 12 + size_du, y: 32, width: size_du, height: 36))
//
//                            view.backgroundColor = UIColor.SegmentCountBGColor
//
//                            let lblSegCount = UILabel(frame: CGRect(x: 4, y: 8, width: 20, height: 20))
//                            lblSegCount.font = lblSegCount.font.withSize(10)
//                            lblSegCount.textAlignment = .center
//
//                            lblSegCount.text = "\(index)"
//
//                            lblSegCount.textColor = UIColor.black
//                            lblSegCount.backgroundColor = UIColor.white
//                            lblSegCount.layer.masksToBounds = true
//                            lblSegCount.layer.cornerRadius = 10.0
//
//                            view.addSubview(lblSegCount)
//
//                            RuleView.addSubview(view)
//                            arrRuler.append(view)
//                        }
                        
                        //changeColorOfRuler(index: CurrentIndex)
                       
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
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        let strTime = cell.txtTime.text!
        let strLeftForce = cell.LeftForceText.text!.stripped
        let strRightForce = cell.RightForceText.text!.stripped
        let strLeftLoction = cell.btnLeftLocation.titleLabel!.text!.lowercased()
        let strRightLocation = cell.btnRightLocation.titleLabel!.text!.lowercased()
        let strLeftPath = cell.txtLeftPath.text!
        let strRightPath = cell.txtRightPath.text!
        let strLeftSpeed = cell.LeftSpeedText.text!.stripped
        let strRightSpeed = cell.RightSpeedText.text!.stripped
        let strLeftTool = cell.txtLeftTool.text!
        let strRightTool = cell.txtRightTool.text!
        
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
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        
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
        } else {
            self.CreateSegmentApiCAll()
        }
    }
    private func SegmentUpdateDataEmty()
    {
        let indexPath = IndexPath.init(row: CurrentIndex, section: 0)
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        
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
        } else {
            self.SegmentUpdateApiCall()
        }
    }
    
    func DataFill(Index:Int)
    {
            
            let indexPath = IndexPath.init(row: Index, section: 0)
            let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
            
            let Data = arrSegmentList[Index]
            
            cell.SegmentCount.text = "\(Index + 1)"
            cell.txtTime.text = Data.getString(key: "duration")
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
            
            let LeftLocation = Data["location_l"] as? String ?? "L. Location"//Data.getString(key: "")
            let RightLocation = Data["location_r"] as? String ?? "R. Location" //Data.getString(key: "location_r")
            let BodyLocation = Data.getString(key: "body_location")
            self.FrontAndBackImage = BodyLocation
            cell.btnLeftLocation.setTitle(LeftLocation, for: .normal)
            cell.btnRightLocation.setTitle(RightLocation, for: .normal)
            self.SetImagePart(LeftLocation: LeftLocation, RightLocation: RightLocation)
    }
    
    func ReSetData()
    {
        
        let indexPath = IndexPath.init(row: self.CurrentIndex, section: 0)
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        
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
        if FrontAndBackImage == "F" {
            if StrGender == "F" {
                self.ImgImage.image = UIImage(named: "F-grey female body front")
            } else {
                self.ImgImage.image = UIImage(named: "grey male body front")
            }
        } else if FrontAndBackImage == "B" {
            if StrGender == "F" {
                self.ImgImage.image = UIImage(named: "F-grey female body back")
            } else {
                self.ImgImage.image = UIImage(named: "grey male body back")
            }
        } else {
            if StrGender == "F" {
                self.ImgImage.image = UIImage(named: "F-grey female body front")
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
                ImageL = "F-L-calf"
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
            else if LeftLocation == "glutiusmaximus"
            {
                ImageL = "F-L-glut"
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
                ImageR = "F-R-calf"
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
            else if RightLocation == "glutiusmaximus"
            {
                ImageR = "F-R-glut"
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
                ImageL = "L-calf"
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
            else if LeftLocation == "glutiusmaximus"
            {
                ImageL = "L-glut"
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
                ImageR = "R-calf"
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
            else if RightLocation == "glutiusmaximus"
            {
                ImageR = "R-glut"
            }
            self.ImgLeft.image = UIImage(named: ImageL)
            self.ImgRight.image = UIImage(named: ImageR)
        }
    }
}

//MARK:- UICollectionViewDelegate And UICollectionViewDataSource
extension NewCreateSegmentVC : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //let count = arrSegmentList.count + 1
        return arrSegmentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
        
        
        let Data = arrSegmentList[indexPath.row]
        
        cell.SegmentCount.text = "\(indexPath.row + 1)"
        cell.txtTime.text = Data.getString(key: "duration")
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
        
        let LeftLocation = Data["location_l"] as? String ?? "L. Location"//Data.getString(key: "")
        let RightLocation = Data["location_r"] as? String ?? "R. Location" //Data.getString(key: "location_r")
        let BodyLocation = Data.getString(key: "body_location")
        self.FrontAndBackImage = BodyLocation
        cell.btnLeftLocation.setTitle(LeftLocation, for: .normal)
        cell.btnRightLocation.setTitle(RightLocation, for: .normal)
        self.SetImagePart(LeftLocation: LeftLocation, RightLocation: RightLocation)
        

        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension NewCreateSegmentVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = view.bounds.width
        return CGSize(width: collectionWidth, height: 440)
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
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        
        self.StrLeftRightLocation = "Left"
        self.btnBodyPartSelectionView.isHidden = false
        let strBodyPart = sender.title(for: .normal)
        
        if btnIsLink.isSelected == true {
            
            if cell.btnRightLocation.titleLabel?.text == "R. Location" {
                
                if strBodyPart == "L. Location"{
                    self.ImgBodyPartImage.image = UIImage(named: "LeftBodyP")
                }else{
                    
                    if FrontAndBackImage == "F" {
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                    }else {
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                    }
                }
            } else {
                
                    
                    if FrontAndBackImage == "F" {
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                    }else {
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                    }
            }
        }
        else {
          
            if strBodyPart == "L. Location"{
                self.ImgBodyPartImage.image = UIImage(named: "LeftBodyP")
            }else{
                
                if FrontAndBackImage == "F" {
                    self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                } else if FrontAndBackImage == "B"{
                    self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftB")
                }else {
                    self.ImgBodyPartImage.image = UIImage(named: "SecondTimeLeftF")
                }
            }
        }
        
        
    }
    @objc func RightLocationSelection(sender: UIButton)
    {
        let indexPath = IndexPath.init(row: self.CurrentIndex, section: 0)
        let cell = Collection.cellForItem(at: indexPath) as! SegmentCreate
        
        self.StrLeftRightLocation = "Right"
        self.btnBodyPartSelectionView.isHidden = false
        let strBodyPart = sender.title(for: .normal)
        
        if btnIsLink.isSelected == true {

            
            
            if cell.btnLeftLocation.titleLabel?.text == "L. Location" {
             
                if strBodyPart == "R. Location"{
                    self.ImgBodyPartImage.image = UIImage(named: "RightBodyP")
                }else{
                    
                    if FrontAndBackImage == "F" {
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                    }
                }
            } else {
                    
                    if FrontAndBackImage == "F" {
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                    } else if FrontAndBackImage == "B"{
                        self.ImgBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                    }
            }
            
        } else {
           
            if strBodyPart == "R. Location"{
                self.ImgBodyPartImage.image = UIImage(named: "RightBodyP")
            }else{
                
                if FrontAndBackImage == "F" {
                    self.ImgBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                } else if FrontAndBackImage == "B"{
                    self.ImgBodyPartImage.image = UIImage(named: "SecondTimeRightB")
                }else {
                    self.ImgBodyPartImage.image = UIImage(named: "SecondTimeRightF")
                }
            }
       }
        
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
        let Time = Data["Time"] as? String ?? ""
        self.rulerSize(size: Int(Time) ?? 0, index: CurrentIndex)
    }
    
    
    func rulerSize(size: Int, index: Int) {
        let view = arrRuler[index]
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: CGFloat(28 * size), height: view.frame.height)
        arrRuler[index] = view
       // self.changeColorOfRuler(index: index)
    }

    func changeColorOfRuler(index: Int) {
        RuleView.subviews.map({  if !$0.isKind(of: UIImageView.self ) { $0.backgroundColor = UIColor.btnBGColor } })

        if let viewLast = RuleView.subviews[index] as? UIView {
            viewLast.backgroundColor = UIColor.SegmentCountBGColor
        }
    }
}

extension String {

    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
}
