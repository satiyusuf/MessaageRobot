//
//  helper.swift
//  MassageRobot
//
//  Created by Sumit Sharma on 02/02/21.
//

import Foundation

class helper{
    
    static let shared = helper()
    
    var valuesGranted: Bool?
    //Initializer access level change now
    private init(){}
    
    let APP_ALERT_TITLE_OOPS = "Oops"
    let SERVER_ERROR = "Server not responding."
    
    static var df: () = DateFormatter().dateFormat = "yyyy-MM-dd"
    
    
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func randomUserId() -> String {

        let digits = "abcdefghijklmnopqrstuvwxyz0123456789"
        return "User\(String((0..<16).map{ _ in digits.randomElement()! }))"
    }
}

