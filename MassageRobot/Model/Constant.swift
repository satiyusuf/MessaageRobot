//
//  Constant.swift
//  Geoscout
//
//  Created by Augmenta on 19/07/20.
//  Copyright © 2020 Augmenta. All rights reserved.
//

import Foundation
import UIKit

let SHARED_APPDELEGATE = AppDelegate().sharedAppDelegate()

// MARK: - NSUSERDEFAULT KEY Name
let ISSHOWLANDINGPAGE = "isShowLanding"
let USERTYPE = "UserType"


// MARK: - Response Parameter
let POSTREQ = "POST"
let GETREQ = "GET"
let PUTREQ = "PUT"
let GetOkValue = "ok"

// MARK:- Screen size
//let screenSize = UIScreen.main.bounds
//let screenWidth = screenSize.width
//let screenHeight = screenSize.height

let TOKEN = "token"
let ISLOGIN = "isLogin"
let ISHOMEPAGE = "isHomePage"
let USERID = "userID"
let FIRSTNAME = "FirstName"
let EMAILID = "userEmail"
let USERNAME = "UserName"
let RoutineUName = "RoutineUName"
let ROUTINGUSERID = "routingUserID"
let QueAns = "queans"
let ISANSUPLOAD = "IsAnsUpload"
let LTOOL = "LTool"
let RTOOL = "RTool"
let LPATH = "LPath"
let RPATH = "RPath"
let LLOCATION = "LLocation"
let RLOCATION = "RLocation"
let EXTIME = "ExTime"
let SEGMENTCOPY = "SegmentCopy"
let SEGMENTSTART = "SegmentStart"
let SEGMENTEND = "SegmentEnd"
let RULERWIDTH = "RulerWidth"
let SEGMENTCOUNT = "SegmentCount"
let SORTING = "Sorting"

let strQue1 = "strQue1"
let strQue2 = "strQue2"
let strQue3 = "strQue3"
let strQue4 = "strQue4"
let strQue5 = "strQue5"
let strQue6 = "strQue6"
let strQue7 = "strQue7"
let strQue8 = "strQue8"
let strQue9 = "strQue9"
let strQue10 = "strQue10"
let strQue11 = "strQue11"
let strQue12 = "strQue12"
let strQue13 = "strQue13"
let strQue14 = "strQue14"
let strQue15 = "strQue15"
let strQue16 = "strQue16"
let strQue17 = "strQue17"
let strQue18 = "strQue18"
let strQue19 = "strQue19"

public var strBaseAPI = ""

// MARK:- API Listing
struct ApiUrls {

    static let baseURL = "https://massage-robotics-website.uc.r.appspot.com"
    
    static let SignUpsubUrl = "/wt?tablename=Userdata&row="
    static let loginsubUrl = "/rd?query='Select u.*, p.thumbnail from Userdata as u left join Userprofile as p on u.userid = p.userid Where"
}

struct TextfieldPlaceholderString {
    
    static let string = TextfieldPlaceholderString()
    
    let provideBDay = "DD"
    let provideBMonth = "MM"
    let provideBYear = "YYYY"
    
    let provideFriendName = "Name of your friend"
}

// MARK: - Api manager class object
//let APIManagerObj = APIManager.sharedInstance()

extension UIColor {
    @nonobjc class var whiteCity: UIColor {
        return UIColor(white: 245.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var btnBGColor: UIColor {
        return UIColor(red: 18.0 / 255.0, green: 162.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var btnSelectColor: UIColor {
        return UIColor(red: 128.0 / 255.0, green: 194.0 / 255.0, blue: 213.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var SegmentCountBGColor: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
//        return UIColor(red: 4.0 / 255.0, green: 39.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    }
}

