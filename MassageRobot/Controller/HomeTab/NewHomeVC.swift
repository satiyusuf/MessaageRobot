//
//  NewHomeVC.swift
//  MassageRobot
//
//  Created by Emp-Mac on 23/09/21.
//

import UIKit
import Foundation


class NewHomeVC: UIViewController {
    
    @IBOutlet weak var tbl_home: UITableView!
    
    var ArrMainCate = ["Activities","Ailments","Browse","Discover","LifeStyle","Sports","Target Areas","Wellness","Workout"]
    var isLogin: String = "No"
    
    var arrActivitesImgList = [
        
        ["Run"  : "https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Frun.png?alt=media&token=865191ab-2c8d-40f3-a9eb-de342f84760d"],
        
        ["Walk"  : "https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fwalk.png?alt=media&token=c39c81c8-f503-4eba-9141-b122e90a3207"],
        
        ["Stairs"  : "https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fstairs.png?alt=media&token=10499ef5-3cb8-4040-856a-bacba0c12a7f"],
        
        ["Gaming"  : "https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fgaming.png?alt=media&token=ffe47ff4-6243-4bbe-b589-126f775a6562"],
        
        ["Driving"  : "https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fdriving.png?alt=media&token=91394f43-fbcf-458c-91cd-330d4208d430"]
        
    ]
    
    var arrAilmentsImgList = [
        ["Muscle Cramps":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fmuscle%20cramps.png?alt=media&token=442237c7-b368-4f58-a809-5d32526475f9"],
        
        ["Sciatica":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fsciatica.png?alt=media&token=2f3924f5-4229-46b6-94f6-8ea0a2401a71"],
        
        ["Carpal Tunnel":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fcarpal%20tunnel.png?alt=media&token=81ce3a75-1566-4717-8271-887ff46ad82e"],
        
        ["Plantar Fasciitis":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fplantar%20fascities.png?alt=media&token=049aba9e-4faf-488d-af85-f62b02f44d30"],
        
        ["Knots":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fknots.png?alt=media&token=cad05fa0-9b4a-4f79-8845-e27d54220836"],
        
        ["Shin Splints":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fshin%20splints.png?alt=media&token=012664e7-a152-4e84-8b81-84f613d951f8"]
        
    ]
    var arrBrowseImgList = [
        ["Shared":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fshared.png?alt=media&token=ed15d198-cb08-4700-a0de-c2f66dc2266e"],
        
        ["Following":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Ffollowing.png?alt=media&token=c6952741-603f-4693-bce2-298eee81ed6f"],
        
        ["Private":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fprivate.png?alt=media&token=cd65117b-7596-4c20-916c-592dec6a8c17"]
        
    ]
    var arrDisSubCatImgList = [["Introduction":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fintroduction.png?alt=media&token=efb66f7d-85da-4076-8f7c-bc1c3c385f7c"]]
    
    var arrLifeStyleImgList = [
        ["Break":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fbreak.png?alt=media&token=2a7c762d-189c-44d2-9932-ed4a741d581d"],
        
        ["Travel":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Ftravel.png?alt=media&token=a02ee3da-9132-4936-bf07-698e66e68a0c"],
        
        ["Jet Lag":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fjet%20lag.png?alt=media&token=9417142f-4339-4e08-9a1f-e9069f52b77b"],
        
        ["Work From Home":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fwork%20from%20home.png?alt=media&token=b1743a55-4b8f-4d8a-a1c1-23edf80b3ffb"]
        
    ]
    var arrSportsImgList = [
        ["Golf":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fgolf.png?alt=media&token=584cc414-80ca-4c94-bebc-71c9018fb6f1"],
        
        ["Basketball":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fbasketball.png?alt=media&token=9744d901-d136-4f5b-aaa6-7dd3cc2b6b9d"],
        
        ["Football":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Ffootball.png?alt=media&token=1b38ecee-bbd0-4a97-8e0a-8763469ecabe"],
        
        ["Tennis":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Ftennis.png?alt=media&token=ca699096-357f-4bc8-b11a-8d2415fe8bba"],
        
        ["Volleyball":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fvolleyball.png?alt=media&token=71ae87e4-662a-44f3-960c-a977bb9cf911"],
        
        ["Hockey":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fhockey.png?alt=media&token=de9515c4-90b8-4c7e-84a0-4873221b345d"],
        
        ["Swim":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fswim.png?alt=media&token=5bfc1ed4-1093-4342-9ab0-945b0850a4cc"],
        
        ["Baseball":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fbaseball.png?alt=media&token=dee1c3c9-b6e6-4d50-b998-be3fb9bf3ddd"],
        
        ["Cycling":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fcycling.png?alt=media&token=b7af3ea3-e392-4be4-956c-7a4c45b14cc7"],
        
        ["Softball":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fsoftball.png?alt=media&token=0769e00b-3535-442d-84b4-0210a7e79142"],
        
        ["Surfing":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fsurfing.png?alt=media&token=8180e2b1-debc-4ff2-9c63-fd247453e914"],
        
        ["Lacrosse":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Flacrosse.png?alt=media&token=299f2d90-f35e-4e9f-86e4-aa129069cf75"]
        
    ]
    var arrTASubCatImgList = [
        
        ["Forearms":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fforearms.png?alt=media&token=24973e0c-6acd-42ab-973a-45c82a7abd7e"],
        
        ["Biceps":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fbiceps.png?alt=media&token=cd3b78b8-2b59-49ad-b4b3-7ba81d280f03"],
        
        ["Feet":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Ffeet.png?alt=media&token=7100f41d-221b-43be-a04b-768c14e379c2"],
        
        ["Hip Flexors":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fhip%20flexors.png?alt=media&token=23c57e23-d773-4f94-8de0-99212676c6e1"],
        
        ["Calves":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fcalves.png?alt=media&token=7e1fa01f-7fcc-48ae-8709-67f22aca3453"],
        
        ["Neck":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fneck.png?alt=media&token=c3787b1b-09de-4ac1-a70a-d5416a45e1fd"],
        
        ["Hamstrings":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fhamstrings.png?alt=media&token=162a1f17-7c32-4ced-8b31-0b4d4d56e4cf"],
        
        ["Glutes":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fglutes.png?alt=media&token=fb0e7f8c-a46d-4f29-9ef3-887cb50400a1"],
        
        ["Abs":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fabs.png?alt=media&token=15ee9f49-a23a-46e6-93ea-f2cedaca8df8"],
        
        ["Chest":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fchest.png?alt=media&token=1aaadc0f-281f-44ae-bf81-c630e3c34f5a"],
        
        ["Quads":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fquads.png?alt=media&token=22a88c11-c960-40eb-85a2-cc1f8f4afecc"],
        
        ["Shoulders":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fshoulders.png?alt=media&token=a450690f-e71e-487c-9bf3-17f9a79350eb"],
        
        ["Triceps":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Ftriceps.png?alt=media&token=1e7014b9-98d9-430a-8d53-35fbe9a19a4c"],
        
        ["Lower Back":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Flower%20back.png?alt=media&token=a4b2cba2-bd6c-4186-bc7a-08c743b106b5"],
        
        ["Shins":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fshins.png?alt=media&token=ef9f671e-343b-434a-96d2-8c6d4f55856b"],
        
        ["Upper Back":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fupper%20back.png?alt=media&token=f7078d2a-4a53-4124-a10a-6d4a1b3a8b49"]
        
    ]
    var arrWellnessImgList = [
        ["Wake":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fwake.png?alt=media&token=f7fd7bbd-54fb-4caf-bb55-bba04942f37b"],
        
        ["Daily Wellness":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fdaily%20wellness.png?alt=media&token=9a1ef656-3138-429f-af2f-c4823783bf86"],
        
        ["Sleep":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fsleep.png?alt=media&token=48baa524-0ce2-49b3-bdfd-0cdc5552e052"]
    ]
    var arrWorkOutImgList = [
        
        ["Recovery":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Frecovery.png?alt=media&token=306ae833-ff76-46bb-bc68-499d0909cb4f"],
        
        ["Studio":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fstudio.png?alt=media&token=eabda5cc-d567-4581-97cd-b370db943698"],
        
        ["Gym":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fgym.png?alt=media&token=55544405-cb56-440e-b745-3f6ace46e3d4"],
        
        ["Warm up":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fwarm%20up.png?alt=media&token=543baee8-c151-480d-a944-da681440407a"]
    ]
    
    
    var arrForYouList = [[String: Any]]()
    var arrFeaturedList = [[String: Any]]()
    var arrNewReleaseList = [[String: Any]]()
    var arrPerformanceList = [[String: Any]]()
    var arrRelexationList = [[String: Any]]()
    var arrTherapyList = [[String: Any]]()
    var arrTrendingList = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLogin = UserDefaults.standard.object(forKey: ISLOGIN) as? String ?? "No"
        if isLogin == "No" {
            
        } else {
            setForYouServiceCall()
        }
       
        // Do any additional setup after loading the view.
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
     
        isLogin = UserDefaults.standard.object(forKey: ISLOGIN) as? String ?? "No"
    }
    
    func setForYouServiceCall() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? "9ccx8ms5pc0000000000"
        
        let param: [String: Any] = [
            "user_id": userID//"0ZVqUi9LD9"
        ]
        
        callAPIRawDataCall("https://massage-robotics-website.uc.r.appspot.com/get-recommendations", parameter: param, isWithLoading: true, isNeedHeader: false, methods: .post) { (json, data1) in
            
            print(json)
            if json.getInt(key: "status_code") == 200 {
                let authData = json.getArrayofDictionary(key: "recommendations")
                print("Routine Count \(authData)")
           
                DispatchQueue.main.async {
                    
                    if authData.count > 0
                    {
                        var RoutineID = String()
                        for RoutineData in authData {
                            let id = RoutineData["routineID"] as? String ?? ""
                            RoutineID.append("'\(id)',")
                        }
                        
                        self.GetDataForYouId(RoutingID: RoutineID)
                        
                        var commonQuery = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity where "
                        
                        
                        for tempDict in self.arrForYouList
                        {
                            commonQuery = commonQuery.appending(" routineid='\(tempDict.getString(key: "routineID"))' or")
                        }
                        
                        if(commonQuery.suffix(2).elementsEqual("or")) {
                            commonQuery = String(commonQuery.dropLast(2))
                        }
                        commonQuery = commonQuery.appending("GROUP BY routineid")
                        self.getAllSegmantDetails(strCategory: "Featured", strURL: commonQuery)
                        self.ArrMainCate.insert("For you", at: 0)
                       // self.ArrMainCate.append("For you")
                        print("*********** arrForYouList =  \(self.arrForYouList.count)\n")
                    }
                }
            }
            
            //  self.setListingServiceCall(strCategory: "Featured")
            self.callAllServiceAtOnce(strCategory: "")
        }
    }
    
    func GetDataForYouId(RoutingID:String) {

        let choppedString = String(RoutingID.dropLast())

       
        let QueryUrl = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT *,  (SELECT SUM(routineentity.duration) as dur from routineentity where routineentity.routineid = routine.routineid) FROM routine where routineid in (\(choppedString))'"
        print(QueryUrl)
        let encodedUrl = QueryUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
    
            if json.getString(key: "status") == "false" {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {

                        self.arrForYouList = jsonArray
                        
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                    showToast(message: json.getString(key: "response_message"))
                }
            }
            
        }
    }
    
    func getSegmantDetails(strCategory: String, routinngId:String)
    {
        let strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity WHERE routineid='\(routinngId)' GROUP BY routineid'"
        
        
        print(strURL)
        
        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
            print("getSegmantDetails ==\(strCategory) == \(json)")
            
            if json.getString(key: "status") == "false" {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        
                        print("\(strCategory) === \(json) === \(jsonArray)")
                        
                        
                        if strCategory == "For you" {
                            print("For you")
                            for (index,tempDict) in arrForYouList.enumerated()
                            {
                                let rID = tempDict.getString(key: "routineid")
                                if jsonArray.count > 0
                                {
                                    if rID == jsonArray[0].getString(key: "routineid")
                                    {
                                        var dict = tempDict
                                        dict["duration"] = jsonArray[0].getString(key: "tot")
                                        print("For you \(rID) --> \(dict["duration"])" )
                                        arrForYouList.remove(at: index)
                                        arrForYouList.insert(dict, at: index)
                                    }
                                }
                                else
                                {
                                    var dict = tempDict
                                    dict["duration"] = "0"
                                    print("For you \(rID) -0-> \(dict["duration"])" )
                                    arrForYouList.remove(at: index)
                                    arrForYouList.insert(dict, at: index)
                                }
                            }
                        }else if strCategory == "Featured" {
                            print("Featured")
                            for (index,tempDict) in arrFeaturedList.enumerated()
                            {
                                let rID = tempDict.getString(key: "routineid")
                                if jsonArray.count > 0
                                {
                                    if rID == jsonArray[0].getString(key: "routineid")
                                    {
                                        var dict = tempDict
                                        dict["duration"] = jsonArray[0].getString(key: "tot")
                                        print("Featured \(rID) --> \(dict["duration"])" )
                                        arrFeaturedList.remove(at: index)
                                        arrFeaturedList.insert(dict, at: index)
                                    }
                                }
                                else
                                {
                                    var dict = tempDict
                                    dict["duration"] = "0"
                                    print("Featured \(rID) -0-> \(dict["duration"])" )
                                    arrFeaturedList.remove(at: index)
                                    arrFeaturedList.insert(dict, at: index)
                                }
                            }
                        }else if strCategory == "New Releases" {
                            print("New Releases")
                            for (index,tempDict) in arrNewReleaseList.enumerated()
                            {
                                let rID = tempDict.getString(key: "routineid")
                                if jsonArray.count > 0
                                {
                                    if rID == jsonArray[0].getString(key: "routineid")
                                    {
                                        var dict = tempDict
                                        dict["duration"] = jsonArray[0].getString(key: "tot")
                                        print("New Releases \(rID) --> \(dict["duration"])" )
                                        arrNewReleaseList.remove(at: index)
                                        arrNewReleaseList.insert(dict, at: index)
                                    }
                                    
                                }
                                else
                                {
                                    var dict = tempDict
                                    dict["duration"] = "0"
                                    print("New Releases \(rID) -0-> \(dict["duration"])" )
                                    arrNewReleaseList.remove(at: index)
                                    arrNewReleaseList.insert(dict, at: index)
                                }
                            }
                        }
                        else if strCategory == "Performance" {
                            print("Performance")
                            for (index,tempDict) in arrPerformanceList.enumerated()
                            {
                                let rID = tempDict.getString(key: "routineid")
                                if jsonArray.count > 0
                                {
                                    if rID == jsonArray[0].getString(key: "routineid")
                                    {
                                        var dict = tempDict
                                        dict["duration"] = jsonArray[0].getString(key: "tot")
                                        print("Performance \(rID) --> \(dict["duration"])" )
                                        arrPerformanceList.remove(at: index)
                                        arrPerformanceList.insert(dict, at: index)
                                    }
                                }
                                else
                                {
                                    var dict = tempDict
                                    dict["duration"] = "0"
                                    print("Performance \(rID) -0-> \(dict["duration"])" )
                                    arrPerformanceList.remove(at: index)
                                    arrPerformanceList.insert(dict, at: index)
                                }
                            }
                            
                        }else if strCategory == "Relaxation" {
                            print("Relaxation")
                            for (index,tempDict) in arrRelexationList.enumerated()
                            {
                                let rID = tempDict.getString(key: "routineid")
                                if jsonArray.count > 0
                                {
                                    if rID == jsonArray[0].getString(key: "routineid")
                                    {
                                        var dict = tempDict
                                        dict["duration"] = jsonArray[0].getString(key: "tot")
                                        print("Relaxation \(rID) --> \(dict["duration"])" )
                                        arrRelexationList.remove(at: index)
                                        arrRelexationList.insert(dict, at: index)
                                    }
                                }
                                else
                                {
                                    var dict = tempDict
                                    dict["duration"] = "0"
                                    print("Relaxation \(rID) -0-> \(dict["duration"])" )
                                    arrRelexationList.remove(at: index)
                                    arrRelexationList.insert(dict, at: index)
                                }
                            }
                            
                        }else if strCategory == "Therapeutic" {
                            print("Therapeutic")
                            for (index,tempDict) in arrTherapyList.enumerated()
                            {
                                let rID = tempDict.getString(key: "routineid")
                                if jsonArray.count > 0
                                {
                                    if rID == jsonArray[0].getString(key: "routineid")
                                    {
                                        var dict = tempDict
                                        dict["duration"] = jsonArray[0].getString(key: "tot")
                                        print("Therapeutic \(rID) --> \(dict["duration"])" )
                                        arrTherapyList.remove(at: index)
                                        arrTherapyList.insert(dict, at: index)
                                    }
                                }
                                else
                                {
                                    var dict = tempDict
                                    dict["duration"] = "0"
                                    print("Therapeutic \(rID) -0-> \(dict["duration"])" )
                                    arrTherapyList.remove(at: index)
                                    arrTherapyList.insert(dict, at: index)
                                }
                            }
                            
                        }else if strCategory == "Trending" {
                            print("Trending")
                            
                            for (index,tempDict) in arrTrendingList.enumerated()
                            {
                                let rID = tempDict.getString(key: "routineid")
                                if jsonArray.count > 0
                                {
                                    if rID == jsonArray[0].getString(key: "routineid")
                                    {
                                        var dict = tempDict
                                        dict["duration"] = jsonArray[0].getString(key: "tot")
                                        print("Trending \(rID) --> \(dict["duration"])" )
                                        arrTrendingList.remove(at: index)
                                        arrTrendingList.insert(dict, at: index)
                                    }
                                }
                                else
                                {
                                    var dict = tempDict
                                    dict["duration"] = "0"
                                    print("Trending \(rID) -0-> \(dict["duration"])" )
                                    arrTrendingList.remove(at: index)
                                    arrTrendingList.insert(dict, at: index)
                                }
                            }
                            
                            self.hideLoading()
                            
                            tbl_home.reloadData()
                            
                            //self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrActivites, strAction: "Activites")
                        }
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                    showToast(message: json.getString(key: "response_message"))
                }
                
                
            }
        }
    }
    func callAllServiceAtOnce(strCategory: String) {
        
//        let strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, u.*, p.thumbnail as userprofile, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = u.userid and f.routineid = r.routineid) as is_favourite from Routine as r left join Userdata as u on r.userid = u.userid left join Userprofile as p on r.userid = p.userid where r.routine_category='Featured' or r.routine_category='New Releases' or r.routine_category='Performance' or   r.routine_category='Relaxation' or   r.routine_category='Therapeutic' or r.routine_category='therapy' or r.routine_category='Trending' ORDER BY creation DESC LIMIT 1000 OFFSET 0'"
        
        
        let strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query=' (SELECT r.*, u.*, p.thumbnail AS userprofile, (SELECT Count(f.favoriteid) FROM favoriteroutines AS f WHERE f.userid = u.userid AND f.routineid = r.routineid) AS is_favourite FROM routine AS r LEFT JOIN userdata AS u ON r.userid = u.userid LEFT JOIN userprofile AS p ON r.userid = p.userid WHERE r.routine_category = 'Featured' ORDER BY creation DESC LIMIT 10) union  (SELECT r.*, u.*, p.thumbnail AS userprofile, (SELECT Count(f.favoriteid) FROM favoriteroutines AS f WHERE f.userid = u.userid AND f.routineid = r.routineid) AS is_favourite FROM routine AS r LEFT JOIN userdata AS u ON r.userid = u.userid LEFT JOIN userprofile AS p ON r.userid = p.userid WHERE r.routine_category = 'New Releases' ORDER BY creation DESC LIMIT 10) union  (SELECT r.*, u.*, p.thumbnail AS userprofile, (SELECT Count(f.favoriteid) FROM favoriteroutines AS f WHERE f.userid = u.userid AND f.routineid = r.routineid) AS is_favourite FROM routine AS r LEFT JOIN userdata AS u ON r.userid = u.userid LEFT JOIN userprofile AS p ON r.userid = p.userid WHERE r.routine_category = 'Performance' ORDER BY creation DESC LIMIT 10) union  (SELECT r.*, u.*, p.thumbnail AS userprofile, (SELECT Count(f.favoriteid) FROM favoriteroutines AS f WHERE f.userid = u.userid AND f.routineid = r.routineid) AS is_favourite FROM routine AS r LEFT JOIN userdata AS u ON r.userid = u.userid LEFT JOIN userprofile AS p ON r.userid = p.userid WHERE r.routine_category = 'Relaxation' ORDER BY creation DESC LIMIT 10) union  (SELECT r.*, u.*, p.thumbnail AS userprofile, (SELECT Count(f.favoriteid) FROM favoriteroutines AS f WHERE f.userid = u.userid AND f.routineid = r.routineid) AS is_favourite FROM routine AS r LEFT JOIN userdata AS u ON r.userid = u.userid LEFT JOIN userprofile AS p ON r.userid = p.userid WHERE r.routine_category = 'Therapeutic' ORDER BY creation DESC LIMIT 10) union  (SELECT r.*, u.*, p.thumbnail AS userprofile, (SELECT Count(f.favoriteid) FROM favoriteroutines AS f WHERE f.userid = u.userid AND f.routineid = r.routineid) AS is_favourite FROM routine AS r LEFT JOIN userdata AS u ON r.userid = u.userid LEFT JOIN userprofile AS p ON r.userid = p.userid WHERE r.routine_category = 'therapy' ORDER BY creation DESC LIMIT 10) union  (SELECT r.*, u.*, p.thumbnail AS userprofile, (SELECT Count(f.favoriteid) FROM favoriteroutines AS f WHERE f.userid = u.userid AND f.routineid = r.routineid) AS is_favourite FROM routine AS r LEFT JOIN userdata AS u ON r.userid = u.userid LEFT JOIN userprofile AS p ON r.userid = p.userid WHERE r.routine_category = 'Trending' ORDER BY creation DESC LIMIT 10)'"
        
        print(strURL)
        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
            print("setListingServiceCall == \(json)")
            
            if json.getString(key: "status") == "false" {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        
                        if(jsonArray.count > 0){
                            
                            for jsonObj in jsonArray {
                                let  category = jsonObj.getString(key: "routine_category")
                                let  thumbnail = jsonObj.getString(key: "thumbnail")
                                print("Thumbanail Image -> \(thumbnail)")
                                if category.elementsEqual("Featured") {
                                    arrFeaturedList.append(contentsOf: [jsonObj])
                                }else if category.elementsEqual("New Releases") {
                                    arrNewReleaseList.append(contentsOf: [jsonObj])
                                }else if category.elementsEqual("Performance") {
                                    arrPerformanceList.append(contentsOf: [jsonObj])
                                }else if category.elementsEqual("Relaxation") {
                                    arrRelexationList.append(contentsOf: [jsonObj])
                                }else if category.elementsEqual("Therapeutic") {
                                    arrTherapyList.append(contentsOf: [jsonObj])
                                }else if category.elementsEqual("therapy") {
                                    arrTherapyList.append(contentsOf: [jsonObj])
                                }else if category.elementsEqual("Trending" ){
                                    arrTrendingList.append(contentsOf: [jsonObj])
                                }
                                
                            }
                            
                            var commonQuery = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity where "
                            
                            
                            if arrFeaturedList.count > 0
                            {
                                for tempDict in arrFeaturedList
                                {
                                    commonQuery = commonQuery.appending(" WHERE routineid='\(tempDict.getString(key: "routineid"))' or")
                                }
                                
                                if(commonQuery.suffix(2).elementsEqual("or")) {
                                    commonQuery = String(commonQuery.dropLast(2))
                                }
                                commonQuery = commonQuery.appending("GROUP BY routineid'")
                                getAllSegmantDetails(strCategory: "Featured", strURL: commonQuery)
                             //   ArrMainCate.append("Featured")
                                
                            }
                            
                            //  setListingServiceCall(strCategory: "New Releases")
                            
                            commonQuery = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity where "
                            
                            
                            if arrNewReleaseList.count > 0
                            {
                                
                                for tempDict in arrNewReleaseList
                                {
                                    commonQuery = commonQuery.appending(" routineid='\(tempDict.getString(key: "routineid"))' or")
                                }
                                if(commonQuery.suffix(2).elementsEqual("or")) {
                                    commonQuery = String(commonQuery.dropLast(2))
                                }
                                commonQuery = commonQuery.appending("GROUP BY routineid'")
                                getAllSegmantDetails(strCategory:"New Releases", strURL: commonQuery)
                           //     ArrMainCate.append("New Releases")
                                
                            }
                            
                            commonQuery = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity where "
                            
                            
                            if arrPerformanceList.count > 0
                            {
                                for tempDict in arrPerformanceList
                                {
                                    
                                    commonQuery = commonQuery.appending(" routineid='\(tempDict.getString(key: "routineid"))' or")
                                }
                                
                                if(commonQuery.suffix(2).elementsEqual("or")) {
                                    commonQuery = String(commonQuery.dropLast(2))
                                }
                                commonQuery = commonQuery.appending("GROUP BY routineid'")
                                getAllSegmantDetails(strCategory:"Performance", strURL: commonQuery)
                            //    ArrMainCate.append("Performance")
                                
                            }
                            
                            commonQuery = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity where "
                            
                            
                            if arrRelexationList.count > 0
                            {
                                for tempDict in arrRelexationList
                                {
                                    commonQuery = commonQuery.appending(" routineid='\(tempDict.getString(key: "routineid"))' or")
                                }
                                
                                if(commonQuery.suffix(2).elementsEqual("or")) {
                                    commonQuery = String(commonQuery.dropLast(2))
                                }
                                commonQuery = commonQuery.appending("GROUP BY routineid'")
                                getAllSegmantDetails(strCategory:"Relaxation", strURL: commonQuery)
                               // ArrMainCate.append("Relaxation")
                                
                            }
                            
                            commonQuery = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity where "
                            
                            
	                        if arrTherapyList.count > 0
                            {
                                for tempDict in arrTherapyList
                                { commonQuery = commonQuery.appending(" routineid='\(tempDict.getString(key: "routineid"))' or")
                                }
                                
                                if(commonQuery.suffix(2).elementsEqual("or")) {
                                    commonQuery = String(commonQuery.dropLast(2))
                                }
                                commonQuery = commonQuery.appending("GROUP BY routineid'")
                                getAllSegmantDetails(strCategory:"Therapy", strURL: commonQuery)
                           //     ArrMainCate.append("Therapy")
                                
                            }
                            
                            commonQuery = "https://massage-robotics-website.uc.r.appspot.com/rd?query='SELECT routineid , SUM(duration) AS tot FROM routineentity where "
                            
                            
                            if arrTrendingList.count > 0
                            {
                                for tempDict in arrTrendingList
                                {
                                    commonQuery = commonQuery.appending(" routineid='\(tempDict.getString(key: "routineid"))' or")
                                }
                                
                                if(commonQuery.suffix(2).elementsEqual("or")) {
                                    commonQuery = String(commonQuery.dropLast(2))
                                }
                                commonQuery = commonQuery.appending("GROUP BY routineid'")
                                getAllSegmantDetails(strCategory:"Trending", strURL: commonQuery)
                           //     ArrMainCate.append("Trending")
                                
                            }
                            
                            self.hideLoading()
                            
                            
                            
                            //self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrActivites, strAction: "Activites")
                        }
                        tbl_home.reloadData()
                        
                        
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    self.hideLoading()
                    print(error)
                    showToast(message: json.getString(key: "response_message"))
                }
                
                
            }
        }
        
        self.hideLoading()
    }
    
    func getAllSegmantDetails(strCategory: String, strURL:String)
    {
        print(strURL)
        
        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
            //print("getSegmantDetails ==\(strCategory) == \(json)")
            
            if json.getString(key: "status") == "false" {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        
                        print("\(strCategory) === \(json) === \(jsonArray)")
                        if(jsonArray.count > 0){
                            
                            if strCategory.elementsEqual("For you") {
                                
                                for (index,tempDict) in arrForYouList.enumerated()
                                {var isFound : Bool = false
                                    let rID = tempDict.getString(key: "routineid")
                                    for jsonObj in jsonArray {
                                        
                                        var  resopnceRID = jsonObj.getString(key: "routineid")
                                        let rID = tempDict.getString(key: "routineID")
                                        
                                        if rID == resopnceRID
                                        {
                                            var dict = tempDict
                                            dict["duration"] = jsonObj.getString(key: "tot")
                                            print("For you \(rID) --> \(dict["duration"])" )
                                            arrForYouList.remove(at: index)
                                            arrForYouList.insert(dict, at: index)
                                            isFound = true
                                        }
                                        
                                        
                                    }
                                    
                                    if(!isFound)
                                    {
                                        var dict = tempDict
                                        dict["duration"] = "0"
                                        print("For you \(rID) -0-> \(dict["duration"])" )
                                        arrForYouList.remove(at: index)
                                        arrForYouList.insert(dict, at: index)
                                    }
                                }
                            }else if strCategory.elementsEqual("Featured") {
                                
                                for (index,tempDict) in arrFeaturedList.enumerated()
                                {var isFound : Bool = false
                                    let rID = tempDict.getString(key: "routineid")
                                    for jsonObj in jsonArray {
                                        
                                        let resopnceRID = jsonObj.getString(key: "routineid")
                                        
                                        
                                        if rID == resopnceRID
                                        {
                                            
                                            var dict = tempDict
                                            dict["duration"] = jsonObj.getString(key: "tot")
                                            print("Featured \(rID) --> \(dict["duration"])" )
                                            arrFeaturedList.remove(at: index)
                                            arrFeaturedList.insert(dict, at: index)
                                            isFound = true
                                        }
                                        
                                    }
                                    
                                    if(!isFound)
                                    {
                                        var dict = tempDict
                                        dict["duration"] = "0"
                                        print("Featured \(rID) -0-> \(dict["duration"])" )
                                        arrFeaturedList.remove(at: index)
                                        arrFeaturedList.insert(dict, at: index)
                                    }
                                }
                            }else if strCategory.elementsEqual("New Releases") {
                                
                                for (index,tempDict) in arrNewReleaseList.enumerated()
                                { var isFound : Bool = false
                                    let rID = tempDict.getString(key: "routineid")
                                    for jsonObj in jsonArray {
                                        
                                        let  resopnceRID = jsonObj.getString(key: "routineid")
                                        
                                        
                                        if rID == resopnceRID
                                        {
                                            var dict = tempDict
                                            dict["duration"] = jsonObj.getString(key: "tot")
                                            print("New Releases \(rID) --> \(dict["duration"])" )
                                            arrNewReleaseList.remove(at: index)
                                            arrNewReleaseList.insert(dict, at: index)
                                            isFound = true
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                    if(!isFound)
                                    {
                                        var dict = tempDict
                                        dict["duration"] = "0"
                                        print("New Releases  \(rID) -0-> \(dict["duration"])" )
                                        arrNewReleaseList.remove(at: index)
                                        arrNewReleaseList.insert(dict, at: index)
                                    }
                                    
                                }
                            }
                            else if strCategory.elementsEqual("Performance" ){
                                
                                for (index,tempDict) in arrPerformanceList.enumerated()
                                {
                                    var isFound : Bool = false
                                    let rID = tempDict.getString(key: "routineid")
                                    for jsonObj in jsonArray {
                                        
                                        let  resopnceRID = jsonObj.getString(key: "routineid")
                                        
                                        
                                        if rID == resopnceRID
                                        {
                                            var dict = tempDict
                                            dict["duration"] = jsonObj.getString(key: "tot")
                                            print("Performance \(rID) --> \(dict["duration"])" )
                                            arrPerformanceList.remove(at: index)
                                            arrPerformanceList.insert(dict, at: index)
                                            isFound = true
                                        }
                                    }
                                    
                                    if(!isFound)
                                    {
                                        var dict = tempDict
                                        dict["duration"] = "0"
                                        print("Performance \(rID) -0-> \(dict["duration"])" )
                                        arrPerformanceList.remove(at: index)
                                        arrPerformanceList.insert(dict, at: index)
                                    }
                                    
                                    
                                }
                                
                                
                                
                            }else if strCategory.elementsEqual("Relaxation") {
                                
                                for (index,tempDict) in arrRelexationList.enumerated()
                                {
                                    
                                    var isFound : Bool = false
                                    let rID = tempDict.getString(key: "routineid")
                                    for jsonObj in jsonArray {
                                        
                                        let  resopnceRID = jsonObj.getString(key: "routineid")
                                        
                                        
                                        if rID == resopnceRID
                                        {
                                            var dict = tempDict
                                            dict["duration"] = jsonObj.getString(key: "tot")
                                            print("Relaxation \(rID) --> \(dict["duration"])" )
                                            arrRelexationList.remove(at: index)
                                            arrRelexationList.insert(dict, at: index)
                                            isFound = true
                                        }
                                    }
                                    
                                    
                                    if(!isFound)
                                    {
                                        var dict = tempDict
                                        dict["duration"] = "0"
                                        print("Relaxation \(rID) -0-> \(dict["duration"])" )
                                        arrRelexationList.remove(at: index)
                                        arrRelexationList.insert(dict, at: index)
                                    }
                                    
                                }
                                
                            }else if strCategory.elementsEqual("Therapy") {
                                
                                 for (index,tempDict) in arrTherapyList.enumerated()
                                {
                                    var isFound : Bool = false
                                    let rID = tempDict.getString(key: "routineid")
                                    for jsonObj in jsonArray {
                                        
                                        let  resopnceRID = jsonObj.getString(key: "routineid")
                                        
                                        
                                        if rID == resopnceRID
                                        {
                                            var dict = tempDict
                                            dict["duration"] = jsonObj.getString(key: "tot")
                                            print("Therapeutic \(rID) --> \(dict["duration"])" )
                                            arrTherapyList.remove(at: index)
                                            arrTherapyList.insert(dict, at: index)
                                            isFound = true
                                        }
                                        
                                    }
                                    
                                    
                                    if(!isFound)
                                    {
                                        var dict = tempDict
                                        dict["duration"] = "0"
                                        print("Therapeutic \(rID) -0-> \(dict["duration"])" )
                                        arrTherapyList.remove(at: index)
                                        arrTherapyList.insert(dict, at: index)
                                    }
                                    
                                }
                                
                            }else if strCategory.elementsEqual("Trending") {
                                
                                
                                for (index,tempDict) in arrTrendingList.enumerated()
                                {
                                    var isFound : Bool = false
                                    let rID = tempDict.getString(key: "routineid")
                                    for jsonObj in jsonArray {
                                        
                                        let  resopnceRID = jsonObj.getString(key: "routineid")
                                        
                                        
                                        if rID == resopnceRID
                                        {
                                            var dict = tempDict
                                            dict["duration"] = jsonObj.getString(key: "tot")
                                            print("Trending \(rID) --> \(dict["duration"])" )
                                            arrTrendingList.remove(at: index)
                                            arrTrendingList.insert(dict, at: index)
                                            isFound = true
                                        }
                                        
                                        
                                    }
                                    
                                    if(!isFound)
                                    {
                                        var dict = tempDict
                                        dict["duration"] = "0"
                                        print("Trending \(rID) -0-> \(dict["duration"])" )
                                        arrTrendingList.remove(at: index)
                                        arrTrendingList.insert(dict, at: index)
                                    }
                                    
                                }
                                
                                
                                
                                
                                //self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrActivites, strAction: "Activites")
                            }
                            
                            self.hideLoading()
                            tbl_home.reloadData()
                        }
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                  //  showToast(message: json.getString(key: "response_message"))
                }
                
                
            }
        }
    }
    func setListingServiceCall(strCategory: String) {
        
        let strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, u.*, p.thumbnail as userprofile, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = u.userid and f.routineid = r.routineid) as is_favourite from Routine as r left join Userdata as u on r.userid = u.userid left join Userprofile as p on r.userid = p.userid where r.routine_category='\(strCategory.lowercased())' ORDER BY creation DESC LIMIT 10 OFFSET 0'"
        
        print(strURL)
        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
            print("setListingServiceCall == \(json)")
            
            if json.getString(key: "status") == "false" {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                        
                        if strCategory == "Featured" {
                            arrFeaturedList.append(contentsOf: jsonArray)
                            
                            if arrFeaturedList.count > 0
                            {
                                for tempDict in arrFeaturedList
                                {
                                    let rID = tempDict.getString(key: "routineid")
                                    getSegmantDetails(strCategory: "Featured", routinngId: rID)
                                }
                                
                            //    ArrMainCate.append("Featured")
                                print("*********** arrFeaturedList =  \(self.arrFeaturedList.count)\n")
                            }
                            
                            setListingServiceCall(strCategory: "New Releases")
                        }else if strCategory == "New Releases" {
                            arrNewReleaseList.append(contentsOf: jsonArray)
                            
                            if arrNewReleaseList.count > 0
                            {
                                
                                for tempDict in arrNewReleaseList
                                {
                                    let rID = tempDict.getString(key: "routineid")
                                    getSegmantDetails(strCategory: "New Releases", routinngId: rID)
                                }
                                
                                
                          //      ArrMainCate.append("New Releases")
                                print("*********** arrNewReleaseList =  \(self.arrNewReleaseList.count)\n")
                            }
                            
                            setListingServiceCall(strCategory: "Performance")
                        }else if strCategory == "Performance" {
                            arrPerformanceList.append(contentsOf: jsonArray)
                            
                            if arrPerformanceList.count > 0
                            {
                                for tempDict in arrPerformanceList
                                {
                                    let rID = tempDict.getString(key: "routineid")
                                    getSegmantDetails(strCategory: "Performance", routinngId: rID)
                                }
                                
                        //        ArrMainCate.append("Performance")
                                print("*********** arrPerformanceList =  \(self.arrPerformanceList.count)\n")
                            }
                            
                            setListingServiceCall(strCategory: "Relaxation")
                        }else if strCategory == "Relaxation" {
                            arrRelexationList.append(contentsOf: jsonArray)
                            
                            if arrRelexationList.count > 0
                            {
                                for tempDict in arrRelexationList
                                {
                                    let rID = tempDict.getString(key: "routineid")
                                    getSegmantDetails(strCategory: "Relaxation", routinngId: rID)
                                }
                                
                        //        ArrMainCate.append("Relaxation")
                                print("*********** arrRelexationList =  \(self.arrRelexationList.count)\n")
                            }
                            
                            setListingServiceCall(strCategory: "Therapeutic")
                        }else if strCategory == "Therapeutic" {
                            arrTherapyList.append(contentsOf: jsonArray)
                            
                            if arrTherapyList.count > 0
                            {
                                for tempDict in arrTherapyList
                                {
                                    let rID = tempDict.getString(key: "routineid")
                                    getSegmantDetails(strCategory: "Therapy", routinngId: rID)
                                }
                                
                             //   ArrMainCate.append("Therapy")
                                print("*********** arrTherapyList =  \(self.arrTherapyList.count)\n")
                            }
                            
                            setListingServiceCall(strCategory: "Trending")
                        }else if strCategory == "Trending" {
                            arrTrendingList.append(contentsOf: jsonArray)
                            
                            if arrTrendingList.count > 0
                            {
                                for tempDict in arrTrendingList
                                {
                                    let rID = tempDict.getString(key: "routineid")
                                    getSegmantDetails(strCategory: "Trending", routinngId: rID)
                                }
                                
                          //      ArrMainCate.append("Trending")
                                print("*********** arrTrendingList =  \(self.arrTrendingList.count)\n")
                            }
                            
                            self.hideLoading()
                            
                            tbl_home.reloadData()
                            
                            //self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrActivites, strAction: "Activites")
                        }
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                   // showToast(message: json.getString(key: "response_message"))
                }
                
                
            }
        }
    }
    
    
    
    
}




protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: NewHomeCollCell?, index: Int,tblIndex:Int, didTappedInTableViewCell: NewHomeTblCell, isDynamic :Bool ,arrCollectionData : [[String:String]], arrDynamicCollectionData : [[String: Any]] )
    // other delegate methods that you can define to perform action in viewcontroller
}


extension NewHomeVC : UITableViewDataSource , UITableViewDelegate,CollectionViewCellDelegate
{
    func collectionView(collectionviewcell: NewHomeCollCell?, index: Int,tblIndex:Int, didTappedInTableViewCell: NewHomeTblCell, isDynamic: Bool, arrCollectionData: [[String : String]], arrDynamicCollectionData: [[String : Any]]) {
        
        if isLogin == "No" {
            UserDefaults.standard.set("Yes", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
            return
        }
        
        if isDynamic
        {
            let routingData = arrDynamicCollectionData[index]
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
            if routingData.getString(key: "routineID") != ""
            {
                vc.strRoutingID = routingData.getString(key: "routineID")
            }
            else
            {
                vc.strRoutingID = routingData.getString(key: "routineid")
            }
            
            navigationController?.pushViewController(vc, animated: false)
            
        }
        else
        {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            let kk = arrCollectionData.map{$0.keys}.reduce([], +)
            
            vc.arrSubCategoryList.append(contentsOf: kk)
            vc.strSubCatName =  arrCollectionData[index].keys.joined()
            vc.strCategoryName = ArrMainCate[tblIndex]
            vc.strPath = ArrMainCate[tblIndex]
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrMainCate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! NewHomeTblCell
        cell.cellDelegate = self
        cell.coll_home.tag = indexPath.row

        cell.isDynamic = false
        
        let ForYou = ArrMainCate[0]
        
        if ForYou == "For you" {
            if indexPath.row == 0
            {
                cell.arrDynamicCollectionData = arrForYouList
                cell.isDynamic = true
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 1
            {
                cell.arrCollectionData = arrActivitesImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 2
            {
                cell.arrCollectionData = arrAilmentsImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 3
            {
                cell.arrCollectionData = arrBrowseImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 4
            {
                cell.arrCollectionData = arrDisSubCatImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 5
            {
                cell.arrCollectionData = arrLifeStyleImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 6
            {
                cell.arrCollectionData = arrSportsImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 7
            {
                cell.arrCollectionData = arrTASubCatImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
                
                
            }
            else if indexPath.row == 8
            {
                cell.arrCollectionData = arrWellnessImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 9
            {
                cell.arrCollectionData = arrWorkOutImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
        } else {
            if indexPath.row == 0
            {
                cell.arrCollectionData = arrActivitesImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 1
            {
                cell.arrCollectionData = arrAilmentsImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 2
            {
                cell.arrCollectionData = arrBrowseImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 3
            {
                cell.arrCollectionData = arrDisSubCatImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 4
            {
                cell.arrCollectionData = arrLifeStyleImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 5
            {
                cell.arrCollectionData = arrSportsImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 6
            {
                cell.arrCollectionData = arrTASubCatImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 7
            {
                cell.arrCollectionData = arrWellnessImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
            else if indexPath.row == 8
            {
                cell.arrCollectionData = arrWorkOutImgList
                cell.lbl_title.text = ArrMainCate[indexPath.row]
                cell.coll_home.reloadData()
            }
        }
        
//        else
//        {
//            if ArrMainCate[indexPath.row] == "For you"
//            {
//                cell.arrDynamicCollectionData = arrForYouList
//            }
//           else if ArrMainCate[indexPath.row] == "Featured"
//            {
//                cell.arrDynamicCollectionData = arrFeaturedList
//            }
//            else if ArrMainCate[indexPath.row] == "New Releases"
//            {
//                cell.arrDynamicCollectionData = arrNewReleaseList
//            }
//            else if ArrMainCate[indexPath.row] == "Performance"
//            {
//                cell.arrDynamicCollectionData = arrPerformanceList
//            }
//            else if ArrMainCate[indexPath.row] == "Relaxation"
//            {
//                cell.arrDynamicCollectionData = arrRelexationList
//            }
//            else if ArrMainCate[indexPath.row] == "Therapy"
//            {
//                cell.arrDynamicCollectionData = arrTherapyList
//            }
//            else if ArrMainCate[indexPath.row] == "Trending"
//            {
//                cell.arrDynamicCollectionData = arrTrendingList
//            }
//
//            cell.isDynamic = true
//            cell.lbl_title.text = ArrMainCate[indexPath.row]
//            cell.coll_home.reloadData()
//        }
        
        cell.btn_view_all.tag = indexPath.row
        cell.btn_view_all.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? NewHomeTblCell else { return }
        
        //cell.vw_main.setGradientBackground(colorTop: .clear, colorBottom: .lightGray)
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? NewHomeTblCell else { return }
        
        //cell.vw_main.backgroundColor = .clear
        //cell.vw_main.setGradientBackground(colorTop: .red, colorBottom: .blue)
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        
        if isLogin == "No" {
            UserDefaults.standard.set("Yes", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
            return
        }
        
        
        if sender.tag > 9
        {
            let title = ArrMainCate[sender.tag]
            self.GetCategoryWiseRoutineView(strCatName: title, strIsSubCat: "No")
        }
        else
        {
            let title = ArrMainCate[sender.tag]
            self.GetCategoryWiseRoutineView(strCatName: title, strIsSubCat: "Yes")
        }
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        print(frame)
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint =  CGPoint(x: 0.5, y: 0.0)
        layer.colors = [ UIColor.red,UIColor.blue]
        return layer
    }
    
    func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = [0, 1]
        
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
    }
    
    func GetCategoryWiseRoutineView(strCatName: String, strIsSubCat: String) {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
        
        if strCatName == "Ailments" {
            let kk = arrAilmentsImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "Activites" {
            let kk = arrActivitesImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "Browse" {
            let kk = arrBrowseImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "Discover" {
            let kk = arrDisSubCatImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "LifeStyle" {
            let kk = arrLifeStyleImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "Sports" {
            let kk = arrSportsImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "Target Areas" {
            let kk = arrTASubCatImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "Wellness" {
            let kk = arrWellnessImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }else if strCatName == "Workout" {
            let kk = arrWorkOutImgList.map{$0.keys}.reduce([], +)
            vc.arrSubCategoryList.append(contentsOf: kk)
        }
        
        vc.strPath = strCatName
        vc.strSubCat = strIsSubCat
        vc.strCategoryName = strCatName
        navigationController?.pushViewController(vc, animated: false)
    }
    
}


// MARK: ************************************  UITableViewCell  *****************************************
class NewHomeTblCell : UITableViewCell , UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout
{
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var vw_main: UIView!
    @IBOutlet weak var coll_home: UICollectionView!
    @IBOutlet weak var btn_view_all: UIButton!
    
    @IBOutlet weak var btn_view: UIButton!
    //var imgArr = [UIImage]()
    
    var arrCollectionData = [[String:String]]()
    var arrDynamicCollectionData = [[String: Any]]()
    var isDynamic:Bool = false
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        //self.contentView.layer.backgroundColor = UIColor.clear.cgColor
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            let bColor = UIColor(rgb: 0xE6E6E6)
            let tColor = UIColor(rgb: 0xFFFFFF)
            self.contentView.setGradientBackground(colorTop: tColor, colorBottom: bColor)
        }
        
        coll_home.delegate = self
        coll_home.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isDynamic
        {
            
            if self.lbl_title.text == "Featured" || self.lbl_title.text == "New Releases" || self.lbl_title.text == "Performance" || self.lbl_title.text == "Relaxation" || self.lbl_title.text == "Therapy" || self.lbl_title.text == "Trending"
            {
               if arrDynamicCollectionData.count > 10 {
                return 10
               }
               else
               {
                return arrDynamicCollectionData.count
               }
            }
            else //if self.lbl_title.text == "For you"
            {
                return arrDynamicCollectionData.count
            }
            
           // return arrDynamicCollectionData.count
        }
        else
        {
            return arrCollectionData.count
        }
         return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewHomeCollCell
        
        
        
        
        if isDynamic
        {
            
            if collectionView.tag == 0
            {
                let temp = arrDynamicCollectionData[indexPath.row]
                
                cell.lbl_title.text = temp.getString(key: "routinename")//routinename
                let time = temp.getString(key: "dur")
                
                cell.lbl_min.text = "0 Min"
                
                print("TIME === \(time)")
                
                if time != ""
                {
                    let min = Int(time)! / 60
                    cell.lbl_min.text = "\(min) Min"
                }
                
                cell.lbl_therapi.text = ""
                cell.lbl_accurate.text = ""
                
                if temp.getString(key: "routine_type") != ""
                {
                    cell.lbl_therapi.text = temp.getString(key: "routine_type")
                }
                
                
                let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F"
                
                if temp.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + temp.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
                    
                    cell.img_view.sd_setImage(with: urls, placeholderImage: UIImage(named: "placeholder-home"))
                }
                else
                {
                    cell.img_view.image = #imageLiteral(resourceName: "placeholder-home")
                }
                
                cell.cons_isDynamic.constant = 60.0
            }
            else
            {
                let temp = arrDynamicCollectionData[indexPath.row]
                
                cell.lbl_title.text = temp.getString(key: "routinename")//routinename
                let time = temp.getString(key: "duration")
                
                cell.lbl_min.text = "0 Min"
                
                print("TIME === \(time)")
                
                if time != ""
                {
                    let min = Int(time)! / 60
                    cell.lbl_min.text = "\(min) Min"
                }
                
                cell.lbl_therapi.text = ""
                cell.lbl_accurate.text = ""
                
                if temp.getString(key: "routine_type") != ""
                {
                    cell.lbl_therapi.text = temp.getString(key: "routine_type")
                }
                
                
                let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F"
                
                if temp.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + temp.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
                    
                    cell.img_view.sd_setImage(with: urls, placeholderImage: UIImage(named: "placeholder-home"))
                }
                else
                {
                    cell.img_view.image = #imageLiteral(resourceName: "placeholder-home")
                }
                
                cell.cons_isDynamic.constant = 60.0
            }           
            
        }
        else
        {
            cell.cons_isDynamic.constant = 30.0
            
            let temp = arrCollectionData[indexPath.row] as [String:String]
            cell.lbl_title.text = temp.keys.joined()
            let urrl = temp.values.joined()
            cell.img_view.sd_setImage(with: URL(string: urrl), placeholderImage: UIImage(named: "placeholder-home"))
            //cell.img_view.sd_setImage(with: , completed: nil)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? NewHomeCollCell
        
        print(collectionView.tag)
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item,tblIndex:collectionView.tag, didTappedInTableViewCell: self, isDynamic: isDynamic,arrCollectionData : arrCollectionData, arrDynamicCollectionData : arrDynamicCollectionData)
    }
    
    
    
}


// MARK: ************************************  UICollectionViewCell  *****************************************
class NewHomeCollCell : UICollectionViewCell
{
    @IBOutlet weak var vw_main: UIView!
    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var cons_isDynamic: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_min: UILabel!
    
    @IBOutlet weak var lbl_therapi: UILabel!
    @IBOutlet weak var lbl_accurate: UILabel!
}



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}
