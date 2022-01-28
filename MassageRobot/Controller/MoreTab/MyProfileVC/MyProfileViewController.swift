//
//  MyProfileViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 09/03/21.
//

import UIKit
import Firebase
import SDWebImage


class MyProfileViewController: UIViewController {

    @IBOutlet var lblAge: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var lblEthniciy: UILabel!
    @IBOutlet var lblPreferredUnits: UILabel!
    @IBOutlet var lblWeight: UILabel!
    @IBOutlet var lblFeet: UILabel!
    @IBOutlet var lblMarried: UILabel!
    @IBOutlet var lblChildren: UILabel!
    @IBOutlet var lblCountry: UILabel!
    @IBOutlet var lblIncome: UILabel!
    @IBOutlet var lblOccupation: UILabel!
    @IBOutlet var lblSelfEmployeed: UILabel!
    @IBOutlet var lblLanguage: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblMobile: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var lblZipCode: UILabel!
    @IBOutlet var lblState: UILabel!
    //@IBOutlet var lblCountry: UILabel!
    
    
    @IBOutlet var imgProfilePic: UIImageView!
    
    @IBOutlet var btnUpdate: UIButton!
    
    var arrMyProfileData = [[String: Any]]()
    var strPath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.setUserProfileDataService()
        self.UserDataGet()
    }
    
    func setUserProfileDataService() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Userprofile where userid='\(userID)''"
                    
            
            print(url)
            
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                self.hideLoading()
                if json.getString(key: "status") == "false" {
                    
                    let string = json.getString(key: "response_message")
                    let data = string.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                        {
                    
                            if jsonArray.count > 0 {
                                let profileData = jsonArray[0]
                                
                                lblUserName.text = UserDefaults.standard.object(forKey: USERNAME) as? String ?? ""
                                lblEmail.text = UserDefaults.standard.object(forKey: EMAILID) as? String ?? ""
                                
                               /* if profileData.getString(key: "thumbnail") != "" {
                                    let imgPath = profileData.getString(key: "thumbnail") as String
                                    let imgURL = URL(string: imgPath)
                                    self.imgProfilePic.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "user-avtar"))

                                }else {
                                    self.imgProfilePic.image = #imageLiteral(resourceName: "user-avtar")
                                }*/
                                
                                if profileData.getString(key: "thumbnail") != "" {
                                    self.loadProfileImg(strThumbnail: profileData.getString(key: "thumbnail"))
                                }else {
                                    //activityIndicat.stopAnimating()
                                    //activityIndicat.isHidden = true;
                                    imgProfilePic.image = UIImage(named: "user-avtar")
                                }
                                
                                lblAge.text = profileData.getString(key: "age")
                                lblGender.text = profileData.getString(key: "gender")
                                lblEthniciy.text = profileData.getString(key: "ethnicity")
                                lblPreferredUnits.text = profileData.getString(key: "units")
                                lblWeight.text = profileData.getString(key: "weight")
                                lblFeet.text = profileData.getString(key: "height")
                                lblMarried.text = profileData.getString(key: "marital")
                                lblChildren.text = profileData.getString(key: "children")
                                lblCountry.text = profileData.getString(key: "country")
                                lblIncome.text = profileData.getString(key: "income")
                                lblOccupation.text = profileData.getString(key: "occupation")
                                lblSelfEmployeed.text = profileData.getString(key: "selfemployeed")
                                lblLanguage.text = profileData.getString(key: "language")
                                lblAddress.text = profileData.getString(key: "address")
                                lblMobile.text = profileData.getString(key: "phone")
                                lblCity.text = profileData.getString(key: "city")
                                lblState.text = profileData.getString(key: "state")
                                lblZipCode.text = profileData.getString(key: "zip")
                                
                                if lblGender.text == "M"
                                {
                                    lblGender.text = "Male"
                                }
                                else
                                {
                                    lblGender.text = "Female"
                                }
                                
                                
                                btnUpdate.setTitle("Update Profile", for: .normal)
                            }else {
                                lblAge.text = "0"
                                lblGender.text = "-"
                                lblEthniciy.text = "-"
                                lblPreferredUnits.text = "0"
                                lblWeight.text = "0"
                                lblFeet.text = "0"
                                lblMarried.text = "-"
                                lblChildren.text = "-"
                                lblCountry.text = "-"
                                lblIncome.text = "0"
                                lblOccupation.text = "-"
                                lblSelfEmployeed.text = "-"
                                lblLanguage.text = "-"
                                lblAddress.text = "-"
                                
                                btnUpdate.setTitle("Add You Profile", for: .normal)
                            }
                        } else {
                            btnUpdate.setTitle("Add You Profile", for: .normal)
                            showToast(message: "Bad Json")
                        }
                    } catch let error as NSError {
                        btnUpdate.setTitle("Add You Profile", for: .normal)
                        print(error)
                    }
                }
            }
        }
    }
    
    @IBAction func btnBackToMenuAction(_ sender: UIButton) {
        
        if strPath == "AnsList" {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnUpdateProfileAction(_ sender: UIButton) {
        let myProfileInfo = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "UpdateProfileViewController") as! UpdateProfileViewController
        self.navigationController?.pushViewController(myProfileInfo, animated: true)
    }
    
    @IBAction func btnRunCalibrationAction(_ sender: UIButton) {
        self.setCalibrationServiceCall()
    }
    
    func setCalibrationServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? "9ccx8ms5pc0000000000"
        
        let param: [String: Any] = [
            "command_id": "run-calibration",
            "user_id": userID
        ]
        
        callAPIRawDataCall("https://robot.massagerobotics.com/run-calibration", parameter: param, isWithLoading: true, isNeedHeader: false, methods: .post) { (json, data1) in
            
            print(json)
//            if json.getInt(key: "status_code") == 200 {
//                let authData = json.getArrayofDictionary(key: "recommendations")
//                print("Routine Count \(authData)")
//            }
        }
    }
    
    func loadProfileImg(strThumbnail: String) {
        var strSubImgPath: String = ""
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let reference = storageRef.child("photos/" + strThumbnail)
        reference.downloadURL { [self] (url, error) in
          guard let downloadURL = url else {
            // Uh-oh, an error occurred!
              self.showToast(message: "Some issue, profile image not upload")
            return
          }
            strSubImgPath =  downloadURL.absoluteString
            let urls = URL.init(string: strSubImgPath)
            URLSession.shared.dataTask(with: urls!) { (data, response, error) in
                if error != nil {
                    print("error")
                }
                DispatchQueue.main.async {
                    
                    if strSubImgPath.contains(strThumbnail.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                        let urls = URL.init(string: strSubImgPath)
                        
                        imgProfilePic.sd_setImage(with: urls, placeholderImage: UIImage(named: "MyProfile"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                          DispatchQueue.main.async {
                              //activityIndicat.isHidden = false;
                              //activityIndicat.startAnimating()
                          }
                      }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                          DispatchQueue.main.async {
                              UIView.animate(withDuration: 3.0, animations: {() -> Void in
                                  //activityIndicat.stopAnimating()
                                  //activityIndicat.isHidden = true;
                              })}
                      }
                        
                    }
                }
            }.resume()
        }
    }
    
}


class ImageLoader {

  private static let cache = NSCache<NSString, NSData>()

  class func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {

    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {

      if let data = self.cache.object(forKey: url.absoluteString as NSString) {
        DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        return
      }

      guard let data = NSData(contentsOf: url) else {
        DispatchQueue.main.async { completionHandler(nil) }
        return
      }

      self.cache.setObject(data, forKey: url.absoluteString as NSString)
      DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
    }
  }
}

extension MyProfileViewController {
    
    private func UserDataGet() {
        
        let token = UserDefaults.standard.object(forKey: TOKEN) as? String ?? ""
        
        guard isReachable else{return}
        showLoading()
        let url = "https://api.massagerobotics.com/user/profile/"
        
        ApiHelper.sharedInstance.GetMethodServiceCall(url: url, Token: token) { [self] (response, error) in
            self.hideLoading()
            if response != nil {
                let Status = response!["status"] as! Bool
                if Status {
                    let RespoData = response!["data"] as! [String:Any]
                    print("RespoData:-\(RespoData)")
                    
                    lblUserName.text = UserDefaults.standard.object(forKey: USERNAME) as? String ?? ""
                    lblEmail.text = UserDefaults.standard.object(forKey: EMAILID) as? String ?? ""
                    
                    if RespoData.getString(key: "thumbnail") != "" {
                        self.loadProfileImg(strThumbnail: RespoData.getString(key: "thumbnail"))
                    }else {
                        //activityIndicat.stopAnimating()
                        //activityIndicat.isHidden = true;
                        imgProfilePic.image = UIImage(named: "user-avtar")
                    }
                    
                    lblAge.text = RespoData.getString(key: "age")
                    lblGender.text = RespoData.getString(key: "gender")
                    lblEthniciy.text = RespoData.getString(key: "ethnicity")
                    lblPreferredUnits.text = RespoData.getString(key: "units")
                    lblWeight.text = RespoData.getString(key: "weight")
                    lblFeet.text = RespoData.getString(key: "height")
                    lblMarried.text = RespoData.getString(key: "marital")
                    lblChildren.text = RespoData.getString(key: "children")
                    lblCountry.text = RespoData.getString(key: "country")
                    lblIncome.text = RespoData.getString(key: "income")
                    lblOccupation.text = RespoData.getString(key: "occupation")
                    lblSelfEmployeed.text = RespoData.getString(key: "selfemployeed")
                    lblLanguage.text = RespoData.getString(key: "language")
                    lblAddress.text = RespoData.getString(key: "address")
                    lblMobile.text = RespoData.getString(key: "phone")
                    lblCity.text = RespoData.getString(key: "city")
                    lblState.text = RespoData.getString(key: "state")
                    lblZipCode.text = RespoData.getString(key: "zip")
                    
                    if lblGender.text == "M"
                    {
                        lblGender.text = "Male"
                    }
                    else
                    {
                        lblGender.text = "Female"
                    }
                    
                    
                    btnUpdate.setTitle("Update Profile", for: .normal)
                    
                } else {
                    lblAge.text = "0"
                    lblGender.text = "-"
                    lblEthniciy.text = "-"
                    lblPreferredUnits.text = "0"
                    lblWeight.text = "0"
                    lblFeet.text = "0"
                    lblMarried.text = "-"
                    lblChildren.text = "-"
                    lblCountry.text = "-"
                    lblIncome.text = "0"
                    lblOccupation.text = "-"
                    lblSelfEmployeed.text = "-"
                    lblLanguage.text = "-"
                    lblAddress.text = "-"
                    
                    btnUpdate.setTitle("Add You Profile", for: .normal)
                }
            } else {
                self.showToast(message: "Something is wrong please try againt")
            }
            
        }
    }
}
