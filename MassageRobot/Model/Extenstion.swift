//
//  Extenstion.swift
//  Wolfpack
//
//  Created by Rohit Parsana on 19/01/21.
//

import UIKit
import Foundation
import Alamofire
import Toast_Swift
import NVActivityIndicatorView

private let presentingIndicatorTypes = {
    return NVActivityIndicatorType.allCases.filter { $0 != .blank }
}()

/// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

/// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

// AppDelegate Shared Instance
var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

func corrner_Raduis(value : Int, outlet : UIView){
    
    outlet.clipsToBounds = true
    outlet.layer.cornerRadius = CGFloat(value)
    
}

func borderColor(value : CGFloat, outlet :UIView){
    
    outlet.layer.masksToBounds = true
    outlet.layer.borderWidth = value
    outlet.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
}

func borderBtn(value : CGFloat, outlet :UIView){
    //corner radius and cornnerborder
    outlet.layer.cornerRadius = value
}

func ViewBottom_DownRadius(value : Int, outlet : UIView)  {
    
    outlet.layer.cornerRadius = CGFloat(value)
    outlet.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    outlet.clipsToBounds = true
}

func ViewTop_UPRadius(value : Int, outlet : UIView)  {
    
    outlet.clipsToBounds = true
    outlet.layer.cornerRadius = CGFloat(value)
    outlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
}

//MARK:- alerts
func showAlert(title: String, message: String, viewController: UIViewController) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    viewController.present(alertView, animated: true, completion: nil)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController: NVActivityIndicatorViewable
{
    func showToast(message: String)
    {
        let windows = UIApplication.shared.windows
        windows.last?.makeToast(message)
    }
    func callAPI(url: String, param: Parameters = [String: Any](), method: HTTPMethod = .post, isHeader: Bool = true, images: [UIImage] = [UIImage](), imageKeys: [String] = [String](), completionHandler: @escaping ([String: Any], Data?) -> ())
    {
        view.endEditing(true)
        if isReachable
        {
            showLoading()
            
            let url = URL(string: url)!
            var header: HTTPHeaders?
            header = ["Content-Type": "application/json"]
            if isHeader
            {
                header!["Authorization"] = ""
            }
            print("url: \(url)")
            print("param: \(param)")
            print("header: \(String(describing: header))")
            
            if images.count > 0
            {
                AF.upload(multipartFormData: { (multipartFormData) in
                    
                    for (key, value) in param {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                    for i in 0..<images.count {
                        guard let imgData = images[i].jpegData(compressionQuality: 0.5) else { return }
                        multipartFormData.append(imgData, withName: imageKeys[i], fileName: "image.jpeg", mimeType: "image/jpeg")
                    }
                },
                to: url,
                usingThreshold: UInt64.init(),
                method: .post,
                headers: header)
                .responseJSON { (response) in
                    
                    self.hideLoading()
                    do {
                        let dict = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? Parameters ?? ["status": false, "response_message": String(data: response.data ?? Data(), encoding: .utf8)!]
                        completionHandler(dict, response.data)
                    }
                    catch let error {
                        print(error)
                        print("url : \(url)\tstr : \(String(data: response.data ?? Data(), encoding: .utf8)!)")
                        completionHandler(["status": false, "response_message": "Something want wrong."], response.data)
                    }
                }
            }
            else
            {
                AF.request(url, method: method, parameters: param, headers: header)
                    .responseJSON { (response) in
                        
                        self.hideLoading()
                        do {
                            let dict = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? Parameters ?? ["status": false, "response_message": String(data: response.data ?? Data(), encoding: .utf8)!]
                            completionHandler(dict, response.data)
                        }
                        catch let error {
                            print(error)
                            print("url : \(url)\tstr : \(String(data: response.data ?? Data(), encoding: .utf8)!)")
                            completionHandler(["status": false, "response_message": "Something want wrong."], response.data)
                        }
                    }
            }
        }
        else
        {
            showToast(message: "No internet connection.")
        }
    }
    
   
    
    func callHomeAPI(url: String, param: Parameters = [String: Any](), method: HTTPMethod = .post, isHeader: Bool = true, images: [UIImage] = [UIImage](), imageKeys: [String] = [String](), completionHandler: @escaping ([String: Any], Data?) -> ())
    {
        view.endEditing(true)
        if isReachable
        {
            showLoading()
            let url = URL(string: url)!
            var header: HTTPHeaders?
            header = ["Content-Type": "application/json"]
            if isHeader
            {
                header!["Authorization"] = ""
            }
            print("url: \(url)")
            print("param: \(param)")
            print("header: \(String(describing: header))")
            
            if images.count > 0
            {
                AF.upload(multipartFormData: { (multipartFormData) in
                    
                    for (key, value) in param {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                    for i in 0..<images.count {
                        guard let imgData = images[i].jpegData(compressionQuality: 0.5) else { return }
                        multipartFormData.append(imgData, withName: imageKeys[i], fileName: "image.jpeg", mimeType: "image/jpeg")
                    }
                },
                to: url,
                usingThreshold: UInt64.init(),
                method: .post,
                headers: header)
                .responseJSON { (response) in
                    
//                    self.hideLoading()
                    do {
                        let dict = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? Parameters ?? ["status": false, "response_message": String(data: response.data ?? Data(), encoding: .utf8)!]
                        completionHandler(dict, response.data)
                    }
                    catch let error {
                        print(error)
                        print("url : \(url)\tstr : \(String(data: response.data ?? Data(), encoding: .utf8)!)")
                        completionHandler(["status": false, "response_message": "Something want wrong."], response.data)
                    }
                }
            }
            else
            {
                AF.request(url, method: method, parameters: param, headers: header)
                    .responseJSON { (response) in
//                        self.hideLoading()
                        do {
                            let dict = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? Parameters ?? ["status": false, "response_message": String(data: response.data ?? Data(), encoding: .utf8)!]
                            completionHandler(dict, response.data)
                        }
                        catch let error {
                            print(error)
                            print("url : \(url)\tstr : \(String(data: response.data ?? Data(), encoding: .utf8)!)")
                            completionHandler(["status": false, "response_message": "Something want wrong."], response.data)
                        }
                    }
            }
        }
        else
        {
            showToast(message: "No internet connection.")
        }
    }
    
    
    func callAPI<T:Codable>(url: String, param: Parameters = [String: Any](), method: HTTPMethod, completionHandler: @escaping (T?) -> ())
    {
        guard isReachable else{return}
        showLoading()
        let url = URL(string: url)!
        var header: HTTPHeaders?
        header = ["Content-Type": "application/json"]
            header!["Authorization"] = ""
        print("url: \(url)")
        print("param: \(param)")
        print("header: \(String(describing: header))")
        AF.request(url, method: method, parameters: param, headers: header)
            .responseJSON { [self] (response) in
                
                self.hideLoading()
                if let rData = response.data{
                    do{
                        let dataModel = try JSONDecoder().decode(T.self, from: rData)
                        completionHandler(dataModel)
                    }catch{
                        
                        UIApplication.topViewController()?.showAlert(message: "oopS", options: "Response Error", completion: nil)
                        completionHandler(nil)
                    }
                }
                    
//                let rModel: T = try! JSONDecoder().decode(T.self, from: rData)
//                    completionHandler(rModel)
//                }else{
//                    showAlert(message: "oopS", options: "Model error", completion: nil)
//                    completionHandler(nil)
//                }
                
                
            }
        
        
    }
    
    func callAPIRawDataCall(
        _ url: String, parameter:[String:Any] = [String: Any](),
        isWithLoading: Bool = true,
        isNeedHeader: Bool = true,
        methods: HTTPMethod = .post,
        completionHandler: @escaping ([String: Any], Data?) -> ()) {
        
        let param = parameter
        //let paramArray : [String] = []
        
        let header: [String: Any] = [
            "Content-Type": "application/json"
        ]
        
        print("URL :- \(url)")
        print("Parameter :- \(param)")
       
        // hideKeyboard()
        
        if isReachable {
            
            if isWithLoading {
                showLoading()
            }
            
            print("HTTPHeaders :- \(header) ")
            
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = methods.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if isNeedHeader {
                
                for (key, value) in header
                {
                    request.setValue(value as? String, forHTTPHeaderField: key)
                }
            }
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject:param, options: .prettyPrinted)
            let json = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print("json : \(json)")
            }
            if methods != .get
            {
                request.httpBody =  jsonData//json!.data(using: String.Encoding.utf8.rawValue)
            }
            
//            SessionManager.default.session.configuration.timeoutIntervalForRequest = 60
            AF.session.configuration.timeoutIntervalForRequest = 60
//                .sharedInstance.session.configuration.timeoutIntervalForRequest = 120
            AF.request(request)//(url, method: methods, parameters: param, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in

                    self.hideLoading()
                    do {
                        let dict = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: .allowFragments) as? Parameters ?? ["status": false, "message": String(data: response.data!, encoding: .utf8)!]
                        completionHandler(dict, response.data)
                    }
                    catch let error {
                        print(error)
                        print("url : \(url)\tstr : \(String(data: response.data ?? Data(), encoding: .utf8)!)")

                    }
            }
        }
        else
        {
            showToast(message: "No internet connection.")
        }
    }
    
    var isReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func showLoading(_ color: UIColor = #colorLiteral(red: 0.163174212, green: 0.2325206101, blue: 0.3331266046, alpha: 1)) {
        let size = CGSize(width: 40, height:40)
        startAnimating(size, type: .ballClipRotate, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    // Hide LoadingView
    func hideLoading() {
        stopAnimating()
    }
    
    //"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    func randomRoutineId() -> String {
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "abcdefghijklmnopqrstuvwxyz0123456789"
    //    return String((0..<4).map{ _ in letters.randomElement()! }) + String((0..<7).map{ _ in digits.randomElement()! })
        return "\(String((0..<20).map{ _ in digits.randomElement()! }))"
    }
    
//    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    func randomSegmentId() -> String {
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "abcdefghijklmnopqrstuvwxyz0123456789"
    //    return String((0..<4).map{ _ in letters.randomElement()! }) + String((0..<7).map{ _ in digits.randomElement()! })
        return "\(String((0..<14).map{ _ in digits.randomElement()! }))"
    }
    
    //"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    func randomWishlistId() -> String {
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "abcdefghijklmnopqrstuvwxyz0123456789"
    //    return String((0..<4).map{ _ in letters.randomElement()! }) + String((0..<7).map{ _ in digits.randomElement()! })
        return "\(String((0..<14).map{ _ in digits.randomElement()! }))"
    }
    
//    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    func randomImg() -> String {
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "abcdefghijklmnopqrstuvwxyz0123456789"
    //    return String((0..<4).map{ _ in letters.randomElement()! }) + String((0..<7).map{ _ in digits.randomElement()! })
        return "\(String((0..<20).map{ _ in digits.randomElement()! }))"
    }
    
    @IBAction func btnBackAction()
    {
        if navigationController != nil
        {
            navigationController?.popViewController(animated: true)
        }
        else
        {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func showLoader()
    {
        let size = CGSize(width: 50, height: 50)
        let indicatorType = presentingIndicatorTypes[31]

        startAnimating(size, message: "Loading...", type: indicatorType, fadeInAnimation: nil)

    }
    
    func hideLoader()
    {
        stopAnimating()
    }
    
    //Show multiple alert with dynamic actions
    func showAlert(title: String? = "Alert",
                                 message: String?,
                                 options: String... ,
                                 completion: ((Int) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion?(index)
            }))
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}


//MARK: -
extension UIView {
    // Give Alpha Animation to the Selected View
    func setAlphaAnimation(alpha: CGFloat) {
        if alpha == 1 {
            self.isHidden = false
        }

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.alpha = alpha
        }) {
            (complete) -> Void in
            if alpha == 0 {
                self.isHidden = true
            }
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.locations = [0, 1]
            gradientLayer.frame = bounds

           layer.insertSublayer(gradientLayer, at: 0)
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func fadeOut(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }

    func fadeIn(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }

    func dropShadow(scale: Bool = true)
    {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
    func dropShadowlight(scale: Bool = true)
    {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func addLine() {
        let labelLine = UILabel(frame: CGRect(x: 0, y: self.frame.size.height - 1.0, width: screenWidth, height: 1.0))
        labelLine.backgroundColor = UIColor.lightGray
        self.addSubview(labelLine)
    }

    func roundCornersSpecific(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

@IBDesignable
extension UIView
{
    @IBInspectable var roundCorder: Bool {
        get {
            return true
        }
        set {
            if newValue
            {
                layer.cornerRadius = frame.height / 2
                layer.masksToBounds = newValue
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var bottomRound: CGFloat {
        get {
            return 0.0
        }
        set {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: newValue, height: newValue))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    @IBInspectable var topRound: CGFloat {
        get {
            return 0.0
        }
        set {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: newValue, height: newValue))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    @IBInspectable var leftRound: CGFloat {
        get {
            return 0.0
        }
        set {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: newValue, height: newValue))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    @IBInspectable var rightRound: CGFloat {
        get {
            return 0.0
        }
        set {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: newValue, height: newValue))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

func fontName() {
    for family in UIFont.familyNames {
        print("\(family)")

        for name in UIFont.fontNames(forFamilyName: family) {
            print("   \(name)")
        }
    }
}

//@objc(MyApplication) class MyApplication: UIApplication {
//    
//    var delegateTouch: AllTouchDelegate?
//    
//    override func sendEvent(_ event: UIEvent) {
//        //
//        // Ignore .Motion and .RemoteControl event
//        // simply everything else then .Touches
//        //
//        if event.type != .touches {
//            super.sendEvent(event)
//            return
//        }
//        
//        //
//        // .Touches only
//        //
//        
//        if let touches = event.allTouches {
//            //
//            // At least one touch in progress?
//            // Do not restart auto lock timer, just invalidate it
//            //
//            for touch in touches.enumerated() {
//                if touch.element.phase != .cancelled && touch.element.phase != .ended {
//                    
//                    delegateTouch?.touchFound()
//                    break
//                }
//            }
//        }
//    }
//}

class ApiHelper: NSObject {

    static let sharedInstance = ApiHelper()
    
    
    func GetMethodServiceCall(url : String,Token:String, completion: @escaping (NSDictionary?,String?) -> ()) {

        var header: HTTPHeaders?
        header = ["Content-Type": "application/json"]
        header!["Authorization"] = "Token \(Token)"
        
        AF.request(url, method: .get,headers: header)
            .responseJSON { response in

                switch response.result {
                case .success:
                    if response.value != nil //result.value != nil
                    {
                        let Res = response.value as! NSDictionary //result.value! as! NSDictionary
                        print("GET : URL : \(url)")
                        print("Response : \(Res)")
                        completion(Res,nil)
                    }
                    else
                    {
                        completion(nil,"Something went wrong!!!")
                    }

                case .failure(let error):
                    print(error)
                    let err = String(decoding: response.data!, as: UTF8.self)
                    print("{----------------------**** ECHO ****----------------------")
                    print("GET : URL : \(url)")
                    print("Echo : \(err)")
                    completion(nil,error.localizedDescription)
                }
        }
    }
    
    func PostMethodServiceCall(url : String, param : [String:String], completion: @escaping (NSDictionary?,String?) -> ()) {
        
        AF.request(url, method: .post, parameters: param)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if response.value != nil
                    {
                        let Res = response.value! as! NSDictionary
                        print("POST :- URL : \(url)")
                        print("PARAM :- \(param)")
                        print("Response :- \(Res)")
                        
                        completion(Res,nil)
                    }
                    else
                    {
                        completion(nil,"Something went wrong!!!")
                    }
                case .failure(let error):
                    //print(error)
                    let err = String(decoding: response.data!, as: UTF8.self)
                    print("{----------------------**** ECHO ****----------------------")
                    print("POST : URL : \(url)")
                    print("Echo : \(err)")
                    
                    completion(nil,error.localizedDescription)
                }
        }
    }
}


