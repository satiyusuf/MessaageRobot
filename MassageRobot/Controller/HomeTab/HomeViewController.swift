//
//  HomeViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 22/06/21.
//

import UIKit
import SDWebImage
import Firebase

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionForYou: UICollectionView!
    @IBOutlet var collectionDiscover: UICollectionView!
    @IBOutlet var collectionFeature: UICollectionView!
    @IBOutlet var collectionTargetAreas: UICollectionView!
    @IBOutlet var collectionPerformance: UICollectionView!
    @IBOutlet var collectionWorkout: UICollectionView!
    @IBOutlet var collectionWellness: UICollectionView!
    @IBOutlet var collectionLifestyle: UICollectionView!
    @IBOutlet var collectionTherapy: UICollectionView!
    @IBOutlet var collectionRelaxation: UICollectionView!
    @IBOutlet var collectionNewReleases: UICollectionView!
    @IBOutlet var collectionTrending: UICollectionView!
    @IBOutlet var collectionBrowse: UICollectionView!
    @IBOutlet var collectionAilments: UICollectionView!
    @IBOutlet var collectionActivites: UICollectionView!
    @IBOutlet var collectionSports: UICollectionView!
    
    @IBOutlet var lblFeatured: UILabel!
    @IBOutlet var lblForYou: UILabel!
    @IBOutlet var lblNewRelease: UILabel!
    @IBOutlet var lblPerformance: UILabel!
    @IBOutlet var lblRelaxation: UILabel!
    @IBOutlet var lblTherapy: UILabel!
    @IBOutlet var lblTrending: UILabel!
    
    var arrActivitesList = [[String: Any]]()
    var arrAilmentsList = [[String: Any]]()
    var arrBrowseList = [[String: Any]]()
    var arrDiscoverList = [[String: Any]]()
    var arrFeaturedList = [[String: Any]]()
    var arrForYouList = [[String: Any]]()
    var arrLifeStyleList = [[String: Any]]()
    var arrNewReleaseList = [[String: Any]]()
    var arrPerformanceList = [[String: Any]]()
    var arrRelexationList = [[String: Any]]()
    var arrSportsList = [[String: Any]]()
    var arrTargetAreaList = [[String: Any]]()
    var arrTherapyList = [[String: Any]]()
    var arrTrendingList = [[String: Any]]()
    var arrWellnessList = [[String: Any]]()
    var arrWorkoutList = [[String: Any]]()
    
    var arrTAImgList = [String]()
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

         ["Plantar Fascities":"https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2Fplantar%20fascities.png?alt=media&token=049aba9e-4faf-488d-af85-f62b02f44d30"],

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
        
    var isLogin: String = "No"
    
    let arrSuCatList = ["Ailments", "Browse"]
    
    let arrFYRoutineName = ["06 Test Routine 1", "06 Test Routine 2", "06 Test Routine 3", "06 Test Routine 4", "06 Test Routine 5", "06 Test Routine 6", "06 Test Routine 7", "06 Test Routine 8", "06 Test Routine 9", "06 Test Routine 10"]
    let arrFYDuration = ["50m", "25m", "20m", "30m", "38m", "22m", "35m", "42m", "21m", "45m"]
    let arrFYCat = ["No Category", "No Category", "No Category", "No Category", "No Category", "No Category", "No Category", "No Category", "No Category", "No Category"]
    let arrFYSubCat = ["No sub Cat", "No sub Cat", "No sub Cat", "No sub Cat", "No sub Cat", "No sub Cat", "No sub Cat", "No sub Cat", "No sub Cat", "No sub Cat"]
        
    let arrFetuRoutineName = ["06 Test Routine 23", "06 Test Routine 38", "06 Test Routine 40", "06 Test Routine 42", "06 Test Routine 51", "06 Test Routine 65", "06 Test Routine 78", "06 Test Routine 86", "06 Test Routine 91", "06 Test Routine 99"]
    let arrFetuDuration = ["55m", "15m", "24m", "36m", "39m", "27m", "33m", "44m", "28m", "43m"]
        
    let arrPerfoRoutineName = ["06 Test Routine 12", "06 Test Routine 18", "06 Test Routine 31", "06 Test Routine 33", "06 Test Routine 52", "06 Test Routine 64", "06 Test Routine 72", "06 Test Routine 83", "06 Test Routine 96", "06 Test Routine 87"]
    let arrPerfoDuration = ["53m", "27m", "23m", "39m", "33m", "24m", "43m", "60m", "29m", "44m"]
        
    let arrTherapyRoutineName = ["06 Test Routine 10", "06 Test Routine 11", "06 Test Routine 33", "06 Test Routine 44", "06 Test Routine 55", "06 Test Routine 66", "06 Test Routine 77", "06 Test Routine 88", "06 Test Routine 99", "06 Test Routine 98"]
    let arrTherapyDuration = ["44m", "22m", "55m", "88m", "33m", "66m", "77m", "99m", "55m", "11m"]
    
    let arrRelaxRoutineName = ["06 Test Routine 18", "06 Test Routine 29", "06 Test Routine 73", "06 Test Routine 84", "06 Test Routine 59", "06 Test Routine 67", "06 Test Routine 79", "06 Test Routine 68", "06 Test Routine 73", "06 Test Routine 32"]
    let arrRelaxDuration = ["40m", "21m", "20m", "30m", "35m", "27m", "39m", "41m", "25m", "48m"]
    
    let arrNewReRoutineName = ["06 Test Routine 17", "06 Test Routine 23", "06 Test Routine 53", "06 Test Routine 34", "06 Test Routine 57", "06 Test Routine 6", "06 Test Routine 7", "06 Test Routine 98", "06 Test Routine 9", "06 Test Routine 2"]
    let arrNewReDuration = ["05m", "25m", "20m", "08m", "39m", "56m", "35m", "46m", "29m", "41m"]
    
    let arrTrenRoutineName = ["06 Test Routine 1", "06 Test Routine 20", "06 Test Routine 10", "06 Test Routine 45", "06 Test Routine 58", "06 Test Routine 69", "06 Test Routine 76", "06 Test Routine 54", "06 Test Routine 97", "06 Test Routine 20"]
    let arrTrenDuration = ["55m", "35m", "59m", "22m", "38m", "18m", "45m", "15m", "49m", "53m"]

    let arrTASubCat = ["Abs", "Biceps", "Calves", "Chest", "Feet", "Forearms", "Glutes", "Hamstrings", "Hip Flexors", "Lower Back", "Neck", "Quads", "Shins", "Shoulders", "Triceps", "Upper Back"]
    let arrDisSubCat = ["Introduction"]
    let arrWorkOut = ["Gym", "Recovery", "Studio", "Warm up"]
    let arrWellness = ["Daily Wellness", "Sleep", "Wake"]
    let arrLifeStyle = ["Break", "Jet Lag", "Travel", "Work From Home"]
    let arrBrowse = ["Following", "Private", "Shared"]
    let arrAilments = ["Carpal Tunnel", "Knots", "Muscle Cramps", "Plantar Fascities", "Sciatica",  "Shin Splints"]
    let arrActivites = ["Driving", "Gaming", "Run", "Stairs", "Walk"]
    let arrSports = ["Baseball", "Basketball", "Cycling", "Football", "Golf", "Hockey", "Lacrosse", "Softball", "Surfing", "Swim", "Tennis", "Volleyball"]
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.collectionForYou.register(UINib(nibName: "ForYouCell", bundle: nil), forCellWithReuseIdentifier: "ForYouCell")
        self.collectionDiscover.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionFeature.register(UINib(nibName: "ForYouCell", bundle: nil), forCellWithReuseIdentifier: "ForYouCell")
        self.collectionTargetAreas.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionPerformance.register(UINib(nibName: "ForYouCell", bundle: nil), forCellWithReuseIdentifier: "ForYouCell")
        self.collectionWorkout.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionWellness.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionLifestyle.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionTherapy.register(UINib(nibName: "ForYouCell", bundle: nil), forCellWithReuseIdentifier: "ForYouCell")
        self.collectionRelaxation.register(UINib(nibName: "ForYouCell", bundle: nil), forCellWithReuseIdentifier: "ForYouCell")
        self.collectionNewReleases.register(UINib(nibName: "ForYouCell", bundle: nil), forCellWithReuseIdentifier: "ForYouCell")
        self.collectionTrending.register(UINib(nibName: "ForYouCell", bundle: nil), forCellWithReuseIdentifier: "ForYouCell")
        self.collectionBrowse.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionAilments.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionActivites.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionSports.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCell")
        
        lblFeatured.isHidden = true
        lblForYou.isHidden = true
        lblNewRelease.isHidden = true
        lblPerformance.isHidden = true
        lblRelaxation.isHidden = true
        lblTherapy.isHidden = true
        lblTrending.isHidden = true
                            
        setForYouServiceCall()
    }
//    https://firebasestorage.googleapis.com:443/v0/b/massage-robotics-website.appspot.com/o/sub-category-images%2F8ahhdf66e9gw8gq6ggnh.png?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2
    override func viewWillAppear(_ animated: Bool) {
        isLogin = UserDefaults.standard.object(forKey: ISLOGIN) as? String ?? "No"
    }
        
 /*   func getStaticImgIntoFirebaseStorage(arrImgList:[String], strAction: String) {
        
        for i in 0..<arrImgList.count {
            var strSubImgPath: String = ""
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            let reference = storageRef.child("sub-category-images/" + arrImgList[i].lowercased() + ".png")
            
            
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
                        
                        if strAction == "Activites" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\"\(arrActivites[i])\":\"\(strSubImgPath)\"")
                                    self.arrActivitesImgList.append([arrActivites[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrActivitesImgList.count == arrImgList.count {
                                self.collectionActivites.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrAilments, strAction: "Ailments")
                            }
                        }else if strAction == "Ailments" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrAilments  =\(arrAilments[i])  -> \(strSubImgPath)" )
                                    self.arrAilmentsImgList.append([arrAilments[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrAilmentsImgList.count == arrImgList.count {
                                self.collectionAilments.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrBrowse, strAction: "Browse")
                            }
                        }else if strAction == "Browse" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrBrowse  =\(arrBrowse[i])  -> \(strSubImgPath)" )
                                    self.arrBrowseImgList.append([arrBrowse[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrBrowseImgList.count == arrImgList.count {
                                self.collectionBrowse.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrDisSubCat, strAction: "Discover")
                            }
                        }else if strAction == "Discover" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrDisSubCat  =\(arrDisSubCat[i])  -> \(strSubImgPath)" )
                                    self.arrDisSubCatImgList.append([arrDisSubCat[i]: strSubImgPath])
                                }
                            }
                                                        
                            if self.arrDisSubCatImgList.count == arrImgList.count {
                                self.collectionDiscover.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrLifeStyle, strAction: "LifeStyle")
                            }
                        }else if strAction == "LifeStyle" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrLifeStyle  =\(arrLifeStyle[i])  -> \(strSubImgPath)" )
                                    self.arrLifeStyleImgList.append([arrLifeStyle[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrLifeStyleImgList.count == arrImgList.count {
                                self.collectionLifestyle.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrSports, strAction: "Sports")
                            }
                        }else if strAction == "Sports" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrSports  =\(arrSports[i])  -> \(strSubImgPath)" )
                                    self.arrSportsImgList.append([arrSports[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrSportsImgList.count == arrImgList.count {
                                self.collectionSports.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrTASubCat, strAction: "TASubCat")
                            }
                        }else if strAction == "TASubCat" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrTASubCat  =\(arrTASubCat[i])  -> \(strSubImgPath)" )
                                    self.arrTASubCatImgList.append([arrTASubCat[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrTASubCatImgList.count == arrImgList.count {
                                self.collectionTargetAreas.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrWellness, strAction: "Wellness")
                            }
                        }else if strAction == "Wellness" {
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrWellness  =\(arrWellness[i])  -> \(strSubImgPath)" )
                                    self.arrWellnessImgList.append([arrWellness[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrWellnessImgList.count == arrImgList.count {
                                self.collectionWellness.reloadData()
                                self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrWorkOut, strAction: "Workout")
                            }
                        }else if strAction == "Workout" {
                            
                            for j in arrImgList {
                                if strSubImgPath.contains(j.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "") {
                                    print( "\n= arrWorkOut  =\(arrWorkOut[i])  -> \(strSubImgPath)" )
                                    self.arrWorkOutImgList.append([arrWorkOut[i]: strSubImgPath])
                                }
                            }
                            
                            if self.arrWorkOutImgList.count == arrImgList.count {
                                self.collectionWorkout.reloadData()
                            }
                        }
                        
                    }
                }.resume()
            }
        }
    }
    */
    
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
                
                self.arrForYouList.append(contentsOf: authData)
                self.collectionForYou.reloadData()
                
                if self.arrForYouList.count == 0 {
                    self.lblForYou.isHidden = false
                    self.collectionForYou.isHidden = true
                    self.lblForYou.text = "Recommendation in not available for your account"
                }
                
                self.setListingServiceCall(strCategory: "Featured")
            }else {
                if self.arrForYouList.count == 0 {
                    self.lblForYou.isHidden = false
                    self.collectionForYou.isHidden = true
                    self.lblForYou.text = "Recommendation in not available for your account"
                }
                self.setListingServiceCall(strCategory: "Featured")
            }
        }
    }
    
    func setListingServiceCall(strCategory: String) {
          
        let strURL = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, u.*, p.thumbnail as userprofile, (SELECT count(f.favoriteid) from favoriteroutines as f where f.userid = u.userid and f.routineid = r.routineid) as is_favourite from Routine as r left join Userdata as u on r.userid = u.userid left join Userprofile as p on r.userid = p.userid where r.routine_category='\(strCategory.lowercased())' ORDER BY creation DESC LIMIT 10 OFFSET 0'"
                    
        print(strURL)
        
        let encodedUrl = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        callHomeAPI(url: encodedUrl!) { [self] (json, data1) in
            print(json)
            
            if json.getString(key: "status") == "false" {
                let string = json.getString(key: "response_message")
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                                                                        
                        if strCategory == "Featured" {
                            arrFeaturedList.append(contentsOf: jsonArray)
                            collectionFeature.reloadData()
                            
                            if arrFeaturedList.count == 0 {
                                lblFeatured.isHidden = false
                                collectionFeature.isHidden = true
                                self.lblFeatured.text = "Routine is not available for featured"
                            }
                                                        
                            setListingServiceCall(strCategory: "New Releases")
                        }else if strCategory == "New Releases" {
                            arrNewReleaseList.append(contentsOf: jsonArray)
                            collectionNewReleases.reloadData()
                            
                            if arrNewReleaseList.count == 0 {
                                lblNewRelease.isHidden = false
                                collectionNewReleases.isHidden = true
                                self.lblNewRelease.text = "Routine is not available for new release"
                            }
                            
                            setListingServiceCall(strCategory: "Performance")
                        }else if strCategory == "Performance" {
                            arrPerformanceList.append(contentsOf: jsonArray)
                            collectionPerformance.reloadData()
                            
                            if arrPerformanceList.count == 0 {
                                lblPerformance.isHidden = false
                                collectionPerformance.isHidden = true
                                self.lblPerformance.text = "Routine is not available for performance"
                            }
                            
                            setListingServiceCall(strCategory: "Relaxation")
                        }else if strCategory == "Relaxation" {
                            arrRelexationList.append(contentsOf: jsonArray)
                            collectionRelaxation.reloadData()
                            
                            if arrRelexationList.count == 0 {
                                lblRelaxation.isHidden = false
                                collectionRelaxation.isHidden = true
                                self.lblRelaxation.text = "Routine is not available for relaxation"
                            }
                            
                            setListingServiceCall(strCategory: "Therapeutic")
                        }else if strCategory == "Therapeutic" {
                            arrTherapyList.append(contentsOf: jsonArray)
                            collectionTherapy.reloadData()
                            
                            if arrTherapyList.count == 0 {
                                lblTherapy.isHidden = false
                                collectionTherapy.isHidden = true
                                self.lblTherapy.text = "Routine is not available for therapy"
                            }
                            
                            setListingServiceCall(strCategory: "Trending")
                        }else if strCategory == "Trending" {
                            arrTrendingList.append(contentsOf: jsonArray)
                            collectionTrending.reloadData()
                            
                            if arrTrendingList.count == 0 {
                                lblTrending.isHidden = false
                                collectionTrending.isHidden = true
                                self.lblTrending.text = "Routine is not available for trending"
                            }
                            self.hideLoading()
                            //self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrActivites, strAction: "Activites")
                        }
                    } else {
                        showToast(message: "Bad Json")
                    }
                } catch let error as NSError {
                    print(error)
                    showToast(message: json.getString(key: "response_message"))
                    
                    if strCategory == "Featured" {
                        
                        if arrFeaturedList.count == 0 {
                            lblFeatured.isHidden = false
                            collectionFeature.isHidden = true
                        }
                                                    
                        setListingServiceCall(strCategory: "New Releases")
                    }else if strCategory == "New Releases" {
                        if arrNewReleaseList.count == 0 {
                            lblNewRelease.isHidden = false
                            collectionNewReleases.isHidden = true
                        }
                        
                        setListingServiceCall(strCategory: "Performance")
                    }else if strCategory == "Performance" {
                        if arrPerformanceList.count == 0 {
                            lblPerformance.isHidden = false
                            collectionPerformance.isHidden = true
                        }
                        
                        setListingServiceCall(strCategory: "Relaxation")
                    }else if strCategory == "Relaxation" {
                        if arrRelexationList.count == 0 {
                            lblRelaxation.isHidden = false
                            collectionRelaxation.isHidden = true
                        }
                        
                        setListingServiceCall(strCategory: "Therapeutic")
                    }else if strCategory == "Therapeutic" {
                        if arrTherapyList.count == 0 {
                            lblTherapy.isHidden = false
                            collectionTherapy.isHidden = true
                        }
                        
                        setListingServiceCall(strCategory: "Trending")
                    }else if strCategory == "Trending" {
                        if arrTrendingList.count == 0 {
                            lblTrending.isHidden = false
                            collectionTrending.isHidden = true
                        }
                        self.hideLoading()
                        //self.getStaticImgIntoFirebaseStorage(arrImgList: self.arrActivites, strAction: "Activites")
                    }
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionActivites {
            return arrActivites.count
        }else if collectionView == collectionAilments {
            return arrAilments.count
        }else if collectionView == collectionBrowse {
            return arrBrowse.count
        }else if collectionView == collectionDiscover {
            return arrDisSubCat.count
        }else if collectionView == collectionFeature {
            return arrFeaturedList.count
        }else if collectionView == collectionForYou {
            return arrForYouList.count
        }else if collectionView == collectionLifestyle {
            return arrLifeStyle.count
        }else if collectionView == collectionNewReleases {
            return arrNewReleaseList.count
        }else if collectionView == collectionRelaxation {
            return arrRelexationList.count
        }else if collectionView == collectionPerformance {
            return arrPerformanceList.count
        }else if collectionView == collectionSports {
            return arrSports.count
        }else if collectionView == collectionTargetAreas {
            return arrTASubCat.count
        }else if collectionView == collectionTherapy {
            return arrTherapyList.count
        }else if collectionView == collectionTrending {
            return arrTrendingList.count
        }else if collectionView == collectionWellness {
            return arrWellness.count
        }else if collectionView == collectionWorkout {
            return arrWorkOut.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if collectionView == collectionForYou {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouCell", for: indexPath) as! ForYouCell
            
            cell.activityIndicat.startAnimating()
            
            if arrForYouList.count > 0 {
                let subCategoryData = arrForYouList[indexPath.row]
                cell.lblRoutineName.text = subCategoryData.getString(key: "routine_name")
                cell.lblSubCategory.text = "No sub Cat"
                cell.lblDuration.text = "45m"
                cell.lblCategory.text = "No sub Cat"
                
                
                if subCategoryData.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + subCategoryData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
                    
//                    cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon"))
                    
                    cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: UIImage(named: "DefaultIcon-1"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                      DispatchQueue.main.async {
                          cell.activityIndicat.isHidden = false;
                          cell.activityIndicat.startAnimating()
                      }
                  }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                      DispatchQueue.main.async {
                          UIView.animate(withDuration: 3.0, animations: {() -> Void in
                              cell.activityIndicat.stopAnimating()
                              cell.activityIndicat.isHidden = true;
                          })}
                  }
                }else {
                    cell.activityIndicat.isHidden = true;
                    cell.activityIndicat.stopAnimating()
                    cell.imgBannarPic.image = UIImage(named: "DefaultIcon-1")
                }
            }
            return cell
        }else if collectionView == collectionDiscover {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrDisSubCat[indexPath.row]
            
            cell.activityIndicat.startAnimating()
            
            if arrDisSubCatImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrDisSubCatImgList {
                    for (key,value) in img {
                        if key == arrDisSubCat[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
                    
            return cell
        }else if collectionView == collectionFeature {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouCell", for: indexPath) as! ForYouCell
            
            cell.activityIndicat.startAnimating()
            
            if arrFeaturedList.count > 0 {
                let subCategoryData = arrFeaturedList[indexPath.row]
                
                cell.lblRoutineName.text = subCategoryData.getString(key: "routinename")
                cell.lblSubCategory.text = "No sub Cat"
                cell.lblDuration.text = "55m"
                cell.lblCategory.text = "No sub Cat"
                
                if subCategoryData.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + subCategoryData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
//                    cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon-1"))
                    
                    cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: UIImage(named: "DefaultIcon-1"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                      DispatchQueue.main.async {
                          cell.activityIndicat.isHidden = false;
                          cell.activityIndicat.startAnimating()
                      }
                  }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                      DispatchQueue.main.async {
                          UIView.animate(withDuration: 3.0, animations: {() -> Void in
                              cell.activityIndicat.stopAnimating()
                              cell.activityIndicat.isHidden = true;
                          })}
                  }
                }else {
                    cell.activityIndicat.isHidden = true;
                    cell.activityIndicat.stopAnimating()
                    cell.imgBannarPic.image = UIImage(named: "DefaultIcon-1")
                }
            }
            return cell
        }else if collectionView == collectionTargetAreas {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrTASubCat[indexPath.row]
               
            cell.activityIndicat.startAnimating()
            
            if arrTASubCatImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrTASubCatImgList {
                    for (key,value) in img {
                        if key == arrTASubCat[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            
            return cell
        }else if collectionView == collectionPerformance {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouCell", for: indexPath) as! ForYouCell
            
            cell.activityIndicat.startAnimating()
            
            if arrPerformanceList.count > 0 {
                let subCategoryData = arrPerformanceList[indexPath.row]
                
                cell.lblRoutineName.text = subCategoryData.getString(key: "routinename")
                cell.lblSubCategory.text = "No sub Cat"
                cell.lblDuration.text = "35m"
                cell.lblCategory.text = "No sub Cat"
                
                if subCategoryData.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + subCategoryData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
//                    cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon-1"))
                    
                    cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: UIImage(named: "DefaultIcon-1"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                      DispatchQueue.main.async {
                          cell.activityIndicat.isHidden = false;
                          cell.activityIndicat.startAnimating()
                      }
                  }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                      DispatchQueue.main.async {
                          UIView.animate(withDuration: 3.0, animations: {() -> Void in
                              cell.activityIndicat.stopAnimating()
                              cell.activityIndicat.isHidden = true;
                          })}
                  }
                }else {
                    cell.activityIndicat.isHidden = true;
                    cell.activityIndicat.stopAnimating()
                    cell.imgBannarPic.image = UIImage(named: "DefaultIcon-1")
                }
            }
            return cell
        }else if collectionView == collectionWorkout {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrWorkOut[indexPath.row]
            
            cell.activityIndicat.startAnimating()
            
            if arrWorkOutImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrWorkOutImgList {
                    for (key,value) in img {
                        if key == arrWorkOut[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            return cell
        }else if collectionView == collectionWellness {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrWellness[indexPath.row]
            
            cell.activityIndicat.startAnimating()
            
            if arrWellnessImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrWellnessImgList {
                    for (key,value) in img {
                        if key == arrWellness[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            
            return cell
        }else if collectionView == collectionLifestyle {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrLifeStyle[indexPath.row]
            
            cell.activityIndicat.startAnimating()
            
            if arrLifeStyleImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrLifeStyleImgList {
                    for (key,value) in img {
                        if key == arrLifeStyle[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            
            return cell
        }else if collectionView == collectionTherapy {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouCell", for: indexPath) as! ForYouCell
            
            cell.activityIndicat.startAnimating()
            
            if arrTherapyList.count > 0 {
                let subCategoryData = arrTherapyList[indexPath.row]
                cell.lblRoutineName.text = subCategoryData.getString(key: "routinename")
                cell.lblSubCategory.text = "No sub Cat"
                cell.lblDuration.text = "25m"
                cell.lblCategory.text = "No sub Cat"
                
                if subCategoryData.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + subCategoryData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
//                    cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon"))
                    
                    cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: UIImage(named: "DefaultIcon-1"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                      DispatchQueue.main.async {
                          cell.activityIndicat.isHidden = false;
                          cell.activityIndicat.startAnimating()
                      }
                  }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                      DispatchQueue.main.async {
                          UIView.animate(withDuration: 3.0, animations: {() -> Void in
                              cell.activityIndicat.stopAnimating()
                              cell.activityIndicat.isHidden = true;
                          })}
                  }
                }else {
                    cell.activityIndicat.isHidden = true;
                    cell.activityIndicat.stopAnimating()
                    cell.imgBannarPic.image = UIImage(named: "DefaultIcon-1")
                }
            }
            
            return cell
        }else if collectionView == collectionRelaxation {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouCell", for: indexPath) as! ForYouCell
            
            cell.activityIndicat.startAnimating()
            
            if arrRelexationList.count > 0 {
                let subCategoryData = arrRelexationList[indexPath.row]
                cell.lblRoutineName.text = subCategoryData.getString(key: "routinename")
                cell.lblSubCategory.text = "No sub Cat"
                cell.lblDuration.text = "25m"
                cell.lblCategory.text = "No sub Cat"
            
                if subCategoryData.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + subCategoryData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
//                    cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon-1"))
                    
                    cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: UIImage(named: "DefaultIcon-1"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                      DispatchQueue.main.async {
                          cell.activityIndicat.isHidden = false;
                          cell.activityIndicat.startAnimating()
                      }
                  }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                      DispatchQueue.main.async {
                          UIView.animate(withDuration: 3.0, animations: {() -> Void in
                              cell.activityIndicat.stopAnimating()
                              cell.activityIndicat.isHidden = true;
                          })}
                  }
                }else {
                    cell.activityIndicat.isHidden = true;
                    cell.activityIndicat.stopAnimating()
                    cell.imgBannarPic.image = UIImage(named: "DefaultIcon-1")
                }
            }
            return cell
        }else if collectionView == collectionNewReleases {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouCell", for: indexPath) as! ForYouCell
            cell.activityIndicat.startAnimating()
            cell.imgBannarPic.layer.cornerRadius = 36.0
            if arrNewReleaseList.count > 0 {
                let subCategoryData = arrNewReleaseList[indexPath.row]
                cell.lblRoutineName.text = subCategoryData.getString(key: "routinename")
                cell.lblSubCategory.text = "No sub Cat"
                cell.lblDuration.text = "40m"
                cell.lblCategory.text = "No sub Cat"
                
                if subCategoryData.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + subCategoryData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
//                    cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon"))
                    
                    cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: UIImage(named: "DefaultIcon-1"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                      DispatchQueue.main.async {
                          cell.activityIndicat.isHidden = false;
                          cell.activityIndicat.startAnimating()
                      }
                  }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                      DispatchQueue.main.async {
                          UIView.animate(withDuration: 3.0, animations: {() -> Void in
                              cell.activityIndicat.stopAnimating()
                              cell.activityIndicat.isHidden = true;
                          })}
                  }
                }else {
                    cell.activityIndicat.isHidden = true;
                    cell.activityIndicat.stopAnimating()
                    cell.imgBannarPic.image = UIImage(named: "DefaultIcon-1")
                }
            }
            return cell
        }else if collectionView == collectionTrending {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForYouCell", for: indexPath) as! ForYouCell
            
            cell.activityIndicat.startAnimating()
            
            if arrTrendingList.count > 0 {
                let subCategoryData = arrTrendingList[indexPath.row]
                
                cell.lblRoutineName.text = subCategoryData.getString(key: "routinename")
                cell.lblSubCategory.text = "No sub Cat"
                cell.lblDuration.text = "25m"
                cell.lblCategory.text = "No sub Cat"
                
                if subCategoryData.getString(key: "thumbnail") != "" {
                    let strURLThumb: String = "https://firebasestorage.googleapis.com/v0/b/massage-robotics-website.appspot.com/o/images%2F" + subCategoryData.getString(key: "thumbnail") + "?alt=media&token=665dad6f-91b0-406b-917e-fec2f7f8a0c2"
                    let urls = URL.init(string: strURLThumb)
//                    cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DefaultIcon-1"))
                    
                    cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: UIImage(named: "DefaultIcon-1"), options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                      DispatchQueue.main.async {
                          cell.activityIndicat.isHidden = false;
                          cell.activityIndicat.startAnimating()
                      }
                  }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                      DispatchQueue.main.async {
                          UIView.animate(withDuration: 3.0, animations: {() -> Void in
                              cell.activityIndicat.stopAnimating()
                              cell.activityIndicat.isHidden = true;
                          })}
                  }
                }else {
                    cell.activityIndicat.isHidden = true;
                    cell.activityIndicat.stopAnimating()
                    cell.imgBannarPic.image = UIImage(named: "DefaultIcon-1")
                }
            }
            return cell
        }else if collectionView == collectionBrowse {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrBrowse[indexPath.row]
            
            cell.activityIndicat.startAnimating()
            
            if arrBrowseImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrBrowseImgList {
                    for (key,value) in img {
                        if key == arrBrowse[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            
            return cell
        }else if collectionView == collectionAilments {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrAilments[indexPath.row]

            cell.activityIndicat.startAnimating()
            
            if arrAilmentsImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrAilmentsImgList {
                    for (key,value) in img {
                        if key == arrAilments[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            
            return cell
        }else if collectionView == collectionActivites {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrActivites[indexPath.row]
            
            cell.activityIndicat.startAnimating()
            
            if arrActivitesImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrActivitesImgList {
                    for (key,value) in img {
                        if key == arrActivites[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)
//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
            cell.lblSubCategory.text = arrSports[indexPath.row]
            
            cell.activityIndicat.startAnimating()
            
            if arrSportsImgList.count > 0 {
                
                let placeholderImage = UIImage(named: "DefaultIcon-1")
                var url = ""
                for img in arrSportsImgList {
                    for (key,value) in img {
                        if key == arrSports[indexPath.row] {
                            url = value
                        }
                    }
                }
                
                let urls = URL.init(string: url)

//                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage)
                cell.imgBannarPic.sd_setImage(with: urls, placeholderImage: placeholderImage, options: .highPriority, progress: { (receivedSize :Int, ExpectedSize :Int, url:URL?) in

                  DispatchQueue.main.async {
                      cell.activityIndicat.isHidden = false;
                      cell.activityIndicat.startAnimating()
                  }
              }) { (image : UIImage?, error : Error?, cacheType : SDImageCacheType?, url:URL?) in

                  DispatchQueue.main.async {
                      UIView.animate(withDuration: 3.0, animations: {() -> Void in
                          cell.activityIndicat.stopAnimating()
                          cell.activityIndicat.isHidden = true;
                      })}
              }
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if isLogin == "No" {
            UserDefaults.standard.set("Yes", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
            return
        }
        
        if collectionView == collectionForYou {
           //Routine
            let routingData = arrForYouList[indexPath.row]
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
            vc.strRoutingID = routingData.getString(key: "routineid")
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionDiscover {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrDisSubCat)
            vc.strSubCatName = arrDisSubCat[indexPath.row]
            vc.strCategoryName = "Discover"
            vc.strPath = "Discover"
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionFeature {
            //Routine
            GetRoutineDetailView()
        }else if collectionView == collectionTargetAreas {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrTASubCat)
            vc.strSubCatName = arrTASubCat[indexPath.row]
            vc.strCategoryName = "TargetAreas"
            vc.strPath = "Target Areas"
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionPerformance {
            //Routine
            let routingData = arrPerformanceList[indexPath.row]
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
            vc.strRoutingID = routingData.getString(key: "routineid")
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionWorkout {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrWorkOut)
            vc.strSubCatName = arrWorkOut[indexPath.row]
            vc.strCategoryName = "Workout"
            vc.strPath = "Workout"
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionWellness {
           let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
           let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
           vc.arrSubCategoryList.append(contentsOf: arrWellness)
           vc.strSubCatName = arrWellness[indexPath.row]
           vc.strCategoryName = "Wellness"
           vc.strPath = "Wellness"
           navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionLifestyle {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrLifeStyle)
            vc.strSubCatName = arrLifeStyle[indexPath.row]
            vc.strCategoryName = "Lifestyle"
            vc.strPath = "Lifestyle"
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionTherapy {
            //Routine
            let routingData = arrTherapyList[indexPath.row]
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
            vc.strRoutingID = routingData.getString(key: "routineid")
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionRelaxation {
            //Routine
            let routingData = arrRelexationList[indexPath.row]
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
            vc.strRoutingID = routingData.getString(key: "routineid")
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionNewReleases {
            //Routine
            let routingData = arrNewReleaseList[indexPath.row]
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
            vc.strRoutingID = routingData.getString(key: "routineid")
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionTrending {
            //Routine
            let routingData = arrTrendingList[indexPath.row]
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "RoutineDetailDisplayVC") as! RoutineDetailDisplayVC
            vc.strRoutingID = routingData.getString(key: "routineid")
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionBrowse {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrBrowse)
            vc.strSubCatName = arrBrowse[indexPath.row]
            vc.strCategoryName = "Browse"
            vc.strPath = "Browse"
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionAilments {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrAilments)
            vc.strSubCatName = arrAilments[indexPath.row]
            vc.strCategoryName = "Ailments"
            vc.strPath = "Ailments"
            navigationController?.pushViewController(vc, animated: false)
        }else if collectionView == collectionActivites {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrActivites)
            vc.strSubCatName = arrActivites[indexPath.row]
            vc.strCategoryName = "Activites"
            vc.strPath = "Activites"
            navigationController?.pushViewController(vc, animated: false)
        }else {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
            vc.arrSubCategoryList.append(contentsOf: arrSports)
            vc.strSubCatName = arrSports[indexPath.row]
            vc.strCategoryName = "Sports"
            vc.strPath = "Sports"
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 254.0, height: 196.0)

        //return CGSize(width: collectionForYou.frame.size.width, height: collectionForYou.frame.size.height)
    }
    
    func GetCategoryWiseRoutineView(strCatName: String, strIsSubCat: String) {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CategoryWiseRoutine") as! CategoryRoutineViewController
        
        if strCatName == "Ailments" {
            vc.arrSubCategoryList.append(contentsOf: arrAilments)
        }else if strCatName == "Activites" {
            vc.arrSubCategoryList.append(contentsOf: arrActivites)
        }else if strCatName == "Browse" {
            vc.arrSubCategoryList.append(contentsOf: arrBrowse)
        }else if strCatName == "Discover" {
            vc.arrSubCategoryList.append(contentsOf: arrDisSubCat)
        }else if strCatName == "Lifestyle" {
            vc.arrSubCategoryList.append(contentsOf: arrLifeStyle)
        }else if strCatName == "Sports" {
            vc.arrSubCategoryList.append(contentsOf: arrSports)
        }else if strCatName == "Target Areas" {
            vc.arrSubCategoryList.append(contentsOf: arrTASubCat)
        }else if strCatName == "Wellness" {
            vc.arrSubCategoryList.append(contentsOf: arrWellness)
        }else if strCatName == "Workout" {
            vc.arrSubCategoryList.append(contentsOf: arrWorkOut)
        }
        
        vc.strPath = strCatName
        vc.strSubCat = strIsSubCat
        vc.strCategoryName = strCatName
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func GetRoutineDetailView() {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RoutineDetail") as! RoutineDetailViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onClickForYouBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "For You", strIsSubCat: "No")
    }
    
    @IBAction func onClickDiscoverBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Discover", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickFeaturedBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Featured", strIsSubCat: "No")
    }
    
    @IBAction func onClickTargetAreasBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Target Areas", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickPerformanceBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Performance", strIsSubCat: "No")
    }
    
    @IBAction func onClickWorkoutBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Workout", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickWellnessBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Wellness", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickLifestyleBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Lifestyle", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickTherapyBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Therapeutic", strIsSubCat: "No")
    }
    
    @IBAction func onClickNewReleasesBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "New Releases", strIsSubCat: "No")
    }
    
    @IBAction func onClickRelaxationBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Relaxation", strIsSubCat: "No")
    }
    
    @IBAction func onClickTrndingBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Trending", strIsSubCat: "No")
    }
    
    @IBAction func BtnBrowseBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Browse", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickAilmentsBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Ailments", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickActivitesBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Activites", strIsSubCat: "Yes")
    }
    
    @IBAction func onClickSportsBtn(_ sender: Any) {
        self.GetCategoryWiseRoutineView(strCatName: "Sports", strIsSubCat: "Yes")
    }
}

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}
