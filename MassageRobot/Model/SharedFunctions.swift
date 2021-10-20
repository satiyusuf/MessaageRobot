//
//  SharedFunctions.swift
//  Chefsy
//
//  Create by Darshan Jolapara on 6/12/18.
//  Copyright © 2018 Darshan Jolapara. All rights reserved.
//


import UIKit

class SharedFunctions: NSObject {
    static var instance: SharedFunctions!
    
    class func sharedInstance() -> SharedFunctions {
        self.instance = (self.instance ?? SharedFunctions())
        return self.instance
    }
    
    // MARK : AppName and Version
    
    func appName()  -> String {
        return (String(describing: Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable")!))
    }
    
    let appVersion  = 1.0
    
    
    // MARK: Check Device Information
    func isiPad()->Bool{
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
            return true;
        }else{
            return false;
        }
    }
    
    func isiPhone() -> Bool{
        return (UIDevice.current.model=="iPhone")
    }
    
    func deviceSystemName() -> String{
        return UIDevice.current.systemName
    }
    
    func deviceSystemVersion() -> Int{
        return Int(UIDevice.current.systemVersion)!
    }
    
    func isiPhone4() -> Bool{
        return (UIScreen.main.bounds.size.height == 480)
    }
    
    func isiPhone5() -> Bool{
        return (UIScreen.main.bounds.size.height == 568)
    }
    
    func isiPhone6() -> Bool{
        return (UIScreen.main.bounds.size.height == 667)
    }
    
    func isiPhone6P() -> Bool{
        return (UIScreen.main.bounds.size.height == 736)
    }
    
    func isiPhoneXs() -> Bool{
        return (UIScreen.main.bounds.size.height == 812)
    }
    
    func isiPhoneXSMax() -> Bool{
        return (UIScreen.main.bounds.size.height == 896)
    }
    
    func isiPhone12() -> Bool{
        return (UIScreen.main.bounds.size.height == 844)
    }
    
    func isiPhone12Mini() -> Bool{
        return (UIScreen.main.bounds.size.height == 780)
    }
    
    func isiPhone12ProMax() -> Bool{
        return (UIScreen.main.bounds.size.height == 926)
    }
    
    func isPortrait() {
        if UIDeviceOrientation.landscapeLeft.isLandscape
        {
            print("landscape")
        }
    }
    
    func isLandscape() {
        if UIDeviceOrientation.portrait.isPortrait
        {
            print("Portrait")
        }
    }
    
    
    // MARK: UIColor
    func UIColorFromRGB(_ rgb: Int, alpha: Float) -> UIColor {
        let red = CGFloat(Float(((rgb>>16) & 0xFF)) / 255.0)
        let green = CGFloat(Float(((rgb>>8) & 0xFF)) / 255.0)
        let blue = CGFloat(Float(((rgb>>0) & 0xFF)) / 255.0)
        let alpha = CGFloat(alpha)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
        
    // MARK: Enable Touch
    func enableTouch(_ value:Bool,view:UIView!){
        view.isUserInteractionEnabled=value
    }
}
