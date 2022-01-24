//
//  SegmentPlayVC.swift
//  MassageRobot
//
//  Created by Darshan Jolapara on 25/07/21.
//

import UIKit
import Alamofire

class SegmentPlayVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnEqualizer: UIButton!
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var btnForword: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblDucation: UILabel!
    
    @IBOutlet weak var constHeight: NSLayoutConstraint!
    
    @IBOutlet weak var horizontalProgressBar: PlainHorizontalProgressBar!
    
    var strRoutingID: String!
    var strIsEnable: String!
    
    var timerTest : Timer?

    var totalDuration = 0
    var totalStoreDu = 0
    var timeRemaining = 0
    var totalTime = 0
    
    var isCellForRow: Bool = false
    
    var indxPath: Int = 0
    
    var arrSegmentList = [[String: Any]]()
    
    var ProgeshBarIs = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName: "SegmentPlayCell", bundle: nil), forCellReuseIdentifier: "SegmentPlayCell")
        
        horizontalProgressBar.progress = 0.0
        
        self.tabBarController?.tabBar.isHidden = true
        
        if strIsEnable == "No" {
            btnEqualizer.isEnabled = false
            btnReload.isEnabled = false
            btnPlayPause.isEnabled = false
            btnForword.isEnabled = false
            btnDelete.isEnabled = false
        }else {
            self.getRoutinSegmentDataListServiceCall()
        }
    }
    
    @IBAction func btnBackToRoutineAction(_ sender: UIButton) {
        timerTest?.invalidate()
        timerTest = nil
        navigationController?.popViewController(animated: true)
    }
    
    func getRoutinSegmentDataListServiceCall() {
        self.hideLoading()
        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Routineentity where routineID = '\(strRoutingID!)''"
        
        print(url)
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        AF.request(encodedUrl!, method:.post, parameters: [:],encoding: JSONEncoding.default) .responseJSON { (response) in
            print("NewApiCallResponse:-\(response)")
            
            switch response.result {
            case .success(let json):
                self.arrSegmentList  = json as! [[String : Any]]
                for segmentDucation in self.arrSegmentList {
                    self.totalStoreDu = Int(segmentDucation.getString(key: "duration")) ?? 0
                    self.totalDuration = self.totalStoreDu + self.totalDuration
                }
                
                self.totalTime = self.totalDuration //60
                
                if self.totalDuration < 10 {
                    self.lblDucation.text = "0" + String(self.totalTime) + ":00/00:00"
                }else {
                    self.lblDucation.text = String(self.totalTime) + ":00/00:00"
                }
                self.tableView.reloadData()
                break
            case .failure(let error):
                print("failure:-\(error)")
                break
            }
        }

        
//        callAPI(url: encodedUrl!) { [self] (json, data1) in
//            print(json)
//            self.hideLoading()
//            if json.getString(key: "status") == "false"
//            {
//                let string = json.getString(key: "response_message")
//                let data = string.data(using: .utf8)!
//                do {
//                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
//                        arrSegmentList.append(contentsOf: jsonArray)
//
//                        for segmentDucation in arrSegmentList {
//                            totalStoreDu = Int(segmentDucation.getString(key: "duration")) ?? 0
//                            totalDuration = totalStoreDu + totalDuration
//                        }
//
//                        totalTime = totalDuration //60
//
//                        if totalDuration < 10 {
//                            lblDucation.text = "0" + String(totalTime) + ":00/00:00"
//                        }else {
//                            lblDucation.text = String(totalTime) + ":00/00:00"
//                        }
//                        tableView.reloadData()
//                    } else {
//                        showToast(message: "Bad Json")
//                    }
//                } catch let error as NSError {
//                    print(error)
//                }
//            }
//        }
    }
        
    @objc func setProgressBar() {
        
        timeRemaining += 1
        let completionPercentage = Int(((Float(totalTime) - Float(timeRemaining))/Float(totalTime)) * 100)
//         progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
        
        let fltValue: Float = Float(timeRemaining)/Float(totalTime)
        horizontalProgressBar.progress = CGFloat(fltValue)
          print("progressLabel \(completionPercentage)% done")
  //       progressLabel.text = "\(completionPercentage)% done"
         let minutesLeft = Int(timeRemaining) / 60 % 60
         let secondsLeft = Int(timeRemaining) % 60
          
          print("timeLabel \(minutesLeft):\(secondsLeft)")
  //       timeLabel.text = "\(minutesLeft):\(secondsLeft)"
          print("manageTimerEnd \(timeRemaining)")
        
        if totalDuration < 10 {
            
            //01:00/02:00
            if minutesLeft < 10 {
                if secondsLeft < 10 {
                    lblDucation.text = "0" + String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + "0" + String(secondsLeft)
                }else {
                    lblDucation.text = "0" + String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
                }
            }else {
                lblDucation.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
            }
        }else {
            
            if minutesLeft < 10 {
                
                if secondsLeft == 0 {
                    lblDucation.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + "00"
                }else {
                    lblDucation.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
                }
            }else {
                
                if secondsLeft == 0 {
                    lblDucation.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + "00"
                }else {
                    lblDucation.text = String(totalDuration) + ":00/0" + String(minutesLeft) + ":" + String(secondsLeft)
                }
            }
        }

        if totalTime == timeRemaining {
            timerTest?.invalidate()
            timerTest = nil
        }
    }
    
    @IBAction func btnEqualizerAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EqualizerVC") as! EqualizerVC
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnReloadAction(_ sender: UIButton) {
        self.setRestartMassageRobotServiceCall()
    }
    
    @IBAction func btnPlayPauseAction(_ sender: UIButton) {
        print("PlayPause")
       
        if btnPlayPause.isSelected == true {
            btnPlayPause.isSelected = false
            btnPlayPause.setImage(UIImage(named: "PlaySeg"), for: .normal)
            
            self.hideLoading()
            self.setPauseMassageRobotServiceCall()
            
            timerTest?.invalidate()
            
            ProgeshBarIs = false
            self.tableView.reloadData()
            
        }else {
            btnPlayPause.isSelected = true
            btnPlayPause.setImage(UIImage(named: "Pause"), for: .normal)
            
            self.hideLoading()
            self.setStartMassageRobotServiceCall()
            ProgeshBarIs = true
            self.tableView.reloadData()
            timerTest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setProgressBar), userInfo: nil, repeats: true)
        }
    }

    @IBAction func btnForwordAction(_ sender: UIButton) {
        print("Forword")
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        self.setStopMassageRobotServiceCall()
    }
    
    func setPlayPauseBtnAction() {
        if btnPlayPause.isSelected == true {
            btnPlayPause.isSelected = false
            btnPlayPause.setImage(UIImage(named: "PlayIcon"), for: .normal)
        }
    }
        
    @IBAction func btnStartPAction(_ sender: UIButton) {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=start"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        AF.request(encodedUrl, method:.post, parameters: [:],encoding: JSONEncoding.default) .responseJSON { [self] (response) in
            print("NewApiCallResponse:-\(response)")
            
            switch response.result {
            case .success(let json):
                let string = (json as! NSDictionary)["message"] as! String
                showToast(message: string)
                self.timerTest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setProgressBar), userInfo: nil, repeats: true)
                if self.arrSegmentList.count > 0 {
                    let indexPath = IndexPath(row: self.indxPath, section: 0)
                    if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
                        let segmentData = arrSegmentList[indexPath.row]
                        cell.segmentTime = Int(segmentData.getString(key: "duration")) ?? 0
                        cell.totalDuration = cell.segmentTime/60
                        cell.startTimerForCell()
                    }
                }
                break
            case .failure(let error):
                print("failure:-\(error)")
                break
            }
        }

       

//
//        callAPI(url: encodedUrl, param: [:], method: .post) { [self] (json, data1) in
//            print(json)
//            self.hideLoading()
//            if json.getString(key: "status") == "success"
//            {
//                let string = json.getString(key: "message")
//                showToast(message: string)
//
//                timerTest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setProgressBar), userInfo: nil, repeats: true)
//
//                if arrSegmentList.count > 0 {
//
//                    let indexPath = IndexPath(row: indxPath, section: 0)
//
//                    if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
//                        let segmentData = arrSegmentList[indexPath.row]
//
//                        cell.segmentTime = Int(segmentData.getString(key: "duration")) ?? 0
//
//                        cell.totalDuration = cell.segmentTime/60
//                        //cell.segmentTime = cell.segmentTime * 60
//
//                        cell.startTimerForCell()
//                    }else {
//
//                    }
//                }
//            }else {
//                let string = json.getString(key: "response_message")
//                showToast(message: string)
//            }
//        }
    }
        
    
    
    func setRestartMassageRobotServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=reset"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        AF.request(encodedUrl, method:.post, parameters: [:],encoding: JSONEncoding.default) .responseJSON { [self] (response) in
            print("NewApiCallResponse:-\(response)")
            
            switch response.result {
            case .success(let json):
                let string = (json as! NSDictionary)["message"] as! String
                showToast(message: string)
                timerTest?.invalidate()
                timerTest = nil
                
                timeRemaining = 0
                
                if totalDuration < 10 {
                    lblDucation.text = "0" + String(totalDuration) + ":00/00:00"
                }else {
                    lblDucation.text = String(totalDuration) + ":00/00:00"
                }
                
                horizontalProgressBar.progress = 0.0
                
                indxPath = 0
                
                self.setPlayPauseBtnAction()
                
                if arrSegmentList.count > 0 {
                    
                    for i in 0..<arrSegmentList.count {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                        
                        let segmentData = arrSegmentList[indexPath.row]
                        
                        if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
                            cell.horizontalBar.progress = 0.0
                            cell.timeRemaining = 0
                            
                            cell.setStopTimerForCell()
                            
                            let segTimeDuration = Int(segmentData.getString(key: "duration")) ?? 0
                            
                            let cal_Duration = segTimeDuration/60
                            
                            if cal_Duration < 10 {
                                cell.lblTime.text = "0" + String(cal_Duration) + ":00/00:00"
                            }else {
                                cell.lblTime.text = String(cal_Duration) + ":00/00:00"
                            }
                        }else {
                            
                        }
                    }
                }
                break
            case .failure(let error):
                print("failure:-\(error)")
                break
            }
        }


        
//        callAPI(url: encodedUrl, param: [:], method: .post) { [self] (json, data1) in
//            print(json)
//            self.hideLoading()
//            if json.getString(key: "status") == "success"
//            {
//                let string = json.getString(key: "message")
//                showToast(message: string)
//
//                timerTest?.invalidate()
//                timerTest = nil
//
//                timeRemaining = 0
//
//                if totalDuration < 10 {
//                    lblDucation.text = "0" + String(totalDuration) + ":00/00:00"
//                }else {
//                    lblDucation.text = String(totalDuration) + ":00/00:00"
//                }
//
//                horizontalProgressBar.progress = 0.0
//
//                indxPath = 0
//
//                self.setPlayPauseBtnAction()
//
//                if arrSegmentList.count > 0 {
//
//                    for i in 0..<arrSegmentList.count {
//
//                        let indexPath = IndexPath(row: i, section: 0)
//
//                        let segmentData = arrSegmentList[indexPath.row]
//
//                        if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
//                            cell.horizontalBar.progress = 0.0
//                            cell.timeRemaining = 0
//
//                            cell.setStopTimerForCell()
//
//                            let segTimeDuration = Int(segmentData.getString(key: "duration")) ?? 0
//
//                            let cal_Duration = segTimeDuration/60
//
//                            if cal_Duration < 10 {
//                                cell.lblTime.text = "0" + String(cal_Duration) + ":00/00:00"
//                            }else {
//                                cell.lblTime.text = String(cal_Duration) + ":00/00:00"
//                            }
//                        }else {
//
//                        }
//                    }
//                }
//            }else {
//                let string = json.getString(key: "response_message")
//                showToast(message: string)
//            }
//        }
    }
        
    func setStartMassageRobotServiceCall() {
        
        self.hideLoading()
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        let url = "https://robot.massagerobotics.com/run-program?robot_id=MR_001&program_id=\(strRoutingID ?? "jnsercuu9c0000000000")&user_id=\(userID)"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        
        AF.request(encodedUrl, method:.post, parameters: [:],encoding: JSONEncoding.default) .responseJSON { [self] (response) in
            print("NewApiCallResponse:-\(response)")

            switch response.result {
            case .success(let json):
                let string = (json as! NSDictionary)["message"] as! String
                showToast(message: string)

                timerTest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setProgressBar), userInfo: nil, repeats: true)

                if arrSegmentList.count > 0 {

                    let indexPath = IndexPath(row: indxPath, section: 0)
                    if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
                        let segmentData = arrSegmentList[indexPath.row]
                        cell.segmentTime = Int(segmentData.getString(key: "duration")) ?? 0
                        cell.totalDuration = cell.segmentTime/60
                        cell.startTimerForCell()
                    }
                }
                break
            case .failure(let error):
                print("failure:-\(error)")
                break
            }
        }

        
//     `   callAPI(url: encodedUrl, param: [:], method: .post) { [self] (json, data1) in
//            print(json)
//            self.hideLoading()
//            if json.getString(key: "status") == "success"
//            {
//                let string = json.getString(key: "message")
//                showToast(message: string)
//
//                timerTest = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setProgressBar), userInfo: nil, repeats: true)
//
//                if arrSegmentList.count > 0 {
//
//                    let indexPath = IndexPath(row: indxPath, section: 0)
//
//                    if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
//                        let segmentData = arrSegmentList[indexPath.row]
//
//                        cell.segmentTime = Int(segmentData.getString(key: "duration")) ?? 0
//
//                        cell.totalDuration = cell.segmentTime/60
////                        cell.segmentTime = cell.segmentTime * 60
//
//                        cell.startTimerForCell()
//                    }else {
//
//                    }
//                }
//            }else {
//                let string = json.getString(key: "response_message")
//                showToast(message: string)
//            }
//        }`
    }
        
    func setPauseMassageRobotServiceCall() {
        
        self.hideLoading()
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""

        let url = "https://robot.massagerobotics.com/command?user_id=\(userID)&command_id=pause"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        AF.request(encodedUrl, method:.post, parameters: [:],encoding: JSONEncoding.default) .responseJSON { [self] (response) in
            print("NewApiCallResponse:-\(response)")
            
            switch response.result {
            case .success(let json):
                
                let string = (json as! NSDictionary)["message"] as! String
                showToast(message: string)
                
                timerTest?.invalidate()
                timerTest = nil
                
                if arrSegmentList.count > 0 {
                                        
                    let indexPath = IndexPath(row: indxPath, section: 0)
                    
                    if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
                        
                        cell.setStopTimerForCell()
                    }else {
                        
                    }
                }
                break
            case .failure(let error):
                print("failure:-\(error)")
                break
            }
        }

        
//        callAPI(url: encodedUrl, param: [:], method: .post) { [self] (json, data1) in
//            print(json)
//            self.hideLoading()
//            if json.getString(key: "status") == "success"
//            {
//                let string = json.getString(key: "message")
//                showToast(message: string)
//
//                timerTest?.invalidate()
//                timerTest = nil
//
//                if arrSegmentList.count > 0 {
//
//                    let indexPath = IndexPath(row: indxPath, section: 0)
//
//                    if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
//
//                        cell.setStopTimerForCell()
//                    }else {
//
//                    }
//                }
//            }else {
//                let string = json.getString(key: "response_message")
//                showToast(message: string)
//            }
//        }
    }
        
    func setStopMassageRobotServiceCall() {
                
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        let url = "https://robot.massagerobotics.com/stop?user_id=\(userID)"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        AF.request(encodedUrl, method:.post, parameters: [:],encoding: JSONEncoding.default) .responseJSON { [self] (response) in
            print("NewApiCallResponse:-\(response)")
            
            switch response.result {
            case .success(let json):
    
                let string = (json as! NSDictionary)["message"] as! String
                showToast(message: string)
                
                timerTest?.invalidate()
                timerTest = nil
                
                timeRemaining = 0
                
                if totalDuration < 10 {
                    lblDucation.text = "0" + String(totalDuration) + ":00/00:00"
                }else {
                    lblDucation.text = String(totalDuration) + ":00/00:00"
                }
                
                horizontalProgressBar.progress = 0.0
                
                indxPath = 0
                
                self.setPlayPauseBtnAction()
                
                if arrSegmentList.count > 0 {
                    
                    for i in 0..<arrSegmentList.count {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                        
                        let segmentData = arrSegmentList[indexPath.row]
                        
                        if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
                            cell.horizontalBar.progress = 0.0
                            
                            cell.timeRemaining = 0
                            
                            cell.setStopTimerForCell()
                            
                            let segTimeDuration = Int(segmentData.getString(key: "duration")) ?? 0
                            
                            let cal_Duration = segTimeDuration/60
                            
                            if cal_Duration < 10 {
                                cell.lblTime.text = "0" + String(cal_Duration) + ":00/00:00"
                            }else {
                                cell.lblTime.text = String(cal_Duration) + ":00/00:00"
                            }
                        }else {
                            
                        }
                    }
                }
                break
            case .failure(let error):
                print("failure:-\(error)")
                break
            }
        }

        
//        callAPI(url: encodedUrl, param: [:], method: .post) { [self] (json, data1) in
//            print(json)
//            self.hideLoading()
//            if json.getString(key: "status") == "success"
//            {
//                let string = json.getString(key: "message")
//                showToast(message: string)
//
//                timerTest?.invalidate()
//                timerTest = nil
//
//                timeRemaining = 0
//
//                if totalDuration < 10 {
//                    lblDucation.text = "0" + String(totalDuration) + ":00/00:00"
//                }else {
//                    lblDucation.text = String(totalDuration) + ":00/00:00"
//                }
//
//                horizontalProgressBar.progress = 0.0
//
//                indxPath = 0
//
//                self.setPlayPauseBtnAction()
//
//                if arrSegmentList.count > 0 {
//
//                    for i in 0..<arrSegmentList.count {
//
//                        let indexPath = IndexPath(row: i, section: 0)
//
//                        let segmentData = arrSegmentList[indexPath.row]
//
//                        if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
//                            cell.horizontalBar.progress = 0.0
//
//                            cell.timeRemaining = 0
//
//                            cell.setStopTimerForCell()
//
//                            let segTimeDuration = Int(segmentData.getString(key: "duration")) ?? 0
//
//                            let cal_Duration = segTimeDuration/60
//
//                            if cal_Duration < 10 {
//                                cell.lblTime.text = "0" + String(cal_Duration) + ":00/00:00"
//                            }else {
//                                cell.lblTime.text = String(cal_Duration) + ":00/00:00"
//                            }
//                        }else {
//
//                        }
//                    }
//                }
//            }else {
//                let string = json.getString(key: "response_message")
//                showToast(message: string)
//            }
//        }
    }
}

extension SegmentPlayVC: UITableViewDelegate, UITableViewDataSource, SegmentPlayCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrSegmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentPlayCell", for: indexPath) as! SegmentPlayCell
                
        cell.selectionStyle = .none
        cell.delegate = self
        
        let segmentData = arrSegmentList[indexPath.row]
        
        cell.lblL_Location.text = segmentData.getString(key: "location_l")
        cell.lblR_Location.text = segmentData.getString(key: "location_r")
        //cell.lblDuration.text = segmentData.getString(key: "duration")
        
        let segTimeDuration = Int(segmentData.getString(key: "duration")) ?? 0
        
        let cal_Duration = segTimeDuration/60
        
        cell.lblDuration.text = String(format: "%d", cal_Duration)
        
        if cal_Duration < 10 {
            cell.lblTime.text = "0" + String(cal_Duration) + ":00/00:00"
        }else {
            cell.lblTime.text = String(cal_Duration) + ":00/00:00"
        }

        let strLocationL: String = String(format: "%@", segmentData.getString(key: "location_l").lowercased())
        print(strLocationL)

        if ProgeshBarIs == true {
            if indexPath.row == 0 {
                cell.startTimerForCell()
                cell.segmentTime = segTimeDuration
            }
        }else {
            cell.setStopTimerForCell()
        }
        
//        if strLocationL == "pectoralis" {
//            cell.viewLeftLocation_1.isHidden = false
//            cell.viewLeftLocation_2.isHidden = true
//        }
//
//        if strLocationL == "Quadracepts" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "iliotibal tract" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "Tibalis Anterior" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "bodyparam" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "Deltoid" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "Upperback" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "Lowerback" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "Glutiusmaximus" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "Hamstring" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
//
//        if strLocationL == "Gastrocnemius" {
//            cell.viewLeftLocation_1.isHidden = true
//            cell.viewLeftLocation_2.isHidden = false
//
//            cell.imgLL.image = UIImage(named: "")
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
    }
    
    func onSetStartProgressNextCell() {
        print("Call Delegate Method")
        
        self.indxPath += 1
        
        if arrSegmentList.count > indxPath {

            let indexPath = IndexPath(row: indxPath, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath) as? SegmentPlayCell {
                let segmentData = arrSegmentList[indexPath.row]
                
                cell.segmentTime = Int(segmentData.getString(key: "duration")) ?? 0

                //cell.segmentTime = cell.segmentTime * 60
                cell.startTimerForCell()
            }else {
                
            }
        }
    }
}
