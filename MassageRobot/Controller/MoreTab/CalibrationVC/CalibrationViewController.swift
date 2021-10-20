//
//  CalibrationViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 13/04/21.
//

import UIKit
import Firebase

class CalibrationViewController: UIViewController {

    var arrCal_pt02 = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let db = Firestore.firestore()
        
//        db.collection("Calibrations").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("DisplayData::::: >>>>> \(document.documentID)")
//                    print("Data_List>>>>>> \(document.data())")
//
//                    if let team = document.data() as? [String: Any] {
//                        for item in document.data() {
//                            let val = item.value
//
//                        }
//                    }
////                    for item in document.data() {
////                        print("Item Data >>>>> \(item)")
////                        let authData = item.value
////                        print("Routine Count \(authData)")
////                    }
//
//                    for(key,value) in document.data() {
//                        print("key>>> \(key)")
//                        print("value>>> \(value)")
//
//                    if let newvalue = value as? [String] {
//                       newvalue.forEach{ (data) in
//                        print("DAta>>>>> \(data)")
//                       }
//                    }
//
//                    }
//
//                }
//            }
//        }
    }
    
    @IBAction func btnStartCalibrationAction(_ sender: Any) {
        self.setCalibrationServiceCall()
    }
    
//    func setCalibrationServiceCall() {
//        //"command_id": "run-calibration",
//        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
//
//        let param: [String: Any] = [
//            "user_id": userID
//        ]
//
//        callAPIRawDataCall("https://robot.massagerobotics.com/run-calibration", parameter: param, isWithLoading: true, isNeedHeader: false, methods: .post) { (json, data1) in
//
//            print(json)
////            if json.getInt(key: "status_code") == 200 {
////                let authData = json.getArrayofDictionary(key: "recommendations")
////                print("Routine Count \(authData)")
////            }
//        }
//    }
    
    func setCalibrationServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        let url = "https://robot.massagerobotics.com/run-calibration?user_id=\(userID)"
        
        print(url)
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        callAPI(url: encodedUrl, param: [:], method: .post) {_,_ in
            self.hideLoading()
        }
    }
}

/*
 r4bhhoos8r816fxpxaf4 => ["Cal_pt02": [-0.4424104429412556, 0.654184530837515, 0.1439012247238466, 2.29258738286037, -1.985499703884281, -0.1916568388800479], "Cal_pt04": [0.39760139424481744, 0.6638167565984149, 0.2035066122285103, 2.2927433229802014, -1.985585825096765, -0.19178266828617946], "Cal_pt06": [0.8751677474523164, 0.5215270562432887, 0.3414757755520887, 2.2925048017965257, -1.9856647482321006, -0.19160671080605662], "Cal_pt01": [-0.5438084165111199, 0.6956546728005346, 0.12392603835519983, 2.292688305272684, -1.9853996990805793, -0.19195639456347066], "Cal_pt03": [0.04692470228043256, 0.7702930334896498, 0.3387323844574373, 2.292683584982168, -1.9855054244857369, -0.19178624026349383], "Cal_pt05": [0.648221442873746, 0.5330113207570577, 0.3153368560920495, 2.292529864298452, -1.9855178953104287, -0.19162871254415054]]
 
 cal_pt01 - upper back
 cal_pt02 - shoulder
 cal_pt03 - lower back
 cal_pt04 - upper leg
 cal_pt05 - knee
 cal_pt06 - ankle
 */
