//
//  Constant.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreLocation

//MARK: - Variables

var IS_BUSINESS = false

var PAGES_TOTAL = 100000

let APP_NAME = "Kouzina"
let GOOGLE_MAP_KEY = "AIzaSyCzCZWu0PbQoK2iqLiyjcjgZQuV8ZqL6Gk"
let PLACE_API_KEY = "AIzaSyCWNRjUGjZy39rVYX95fiRaQzzG1vm55nI"
let googleMapKey = ""

let SERVER_VALIDATION = SLOW_INTERNET_VALIDATION
let SLOW_INTERNET_VALIDATION = "The network connection was lost"

let userDefault = UserDefaults.standard
let USER_DETAILS_KEY = "userDetails"
var SELECTED_ACCOUNT_TYPE = "Free"

var SELECTED_LIBRARY_TAB = ""
var SELECTED_EXERCISE_LIBRARY_TAB = ""
var SELECTED_LOADCENTER_TAB = 0

var CURRENT_LATITUDE: Double = 0
var CURRENT_LONGITUDE: Double = 0

var LOGIN_KEY = "LOGIN_KEY"

var TEST_IMAGE_URL = "https://avatars3.githubusercontent.com/u/13130705?v=4"
var TEST_COVER_IMAGE_URL = "https://www.incimages.com/uploaded_files/image/970x450/getty_509107562_2000133320009280346_351827.jpg"

let APP_SECRET = "Pango74hhheg8"
let USER_AGENT = "pangogive157ujHg"
let VERSION_NUMBER = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
let BUILD_NUMBER = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
var SYSTEM_VERSION = UIDevice.current.systemVersion
var DEVICE_UUID = UIDevice.current.identifierForVendor?.uuidString
let appDelegate = UIApplication.shared.delegate as! AppDelegate

func getMiles(meters: CLLocationDistance) -> Double {
    return meters / 1609
}

func formattedNumber(number: String) -> String {
    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let mask = "(XXX) XXX-XXXX"
    
    var result = ""
    var index = cleanPhoneNumber.startIndex
    for ch in mask where index < cleanPhoneNumber.endIndex {
        if ch == "X" {
            result.append(cleanPhoneNumber[index])
            index = cleanPhoneNumber.index(after: index)
        } else {
            result.append(ch)
        }
    }
    return result
}

extension String {
    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    }
}

func getShowBussiness() -> Bool {
    if isKeyPresentInUserDefaults(key: "isShowBussiness") {
        return userDefault.value(forKey: "isShowBussiness") as? Bool ?? false
    }
    return false
}

func saveShowBussiness(isShow: Bool) {
    userDefault.setValue(isShow, forKey: "isShowBussiness")
    userDefault.synchronize()
}

func getRememberMe() -> Bool {
    if isKeyPresentInUserDefaults(key: "RememberMe") {
        return userDefault.value(forKey: "RememberMe") as? Bool ?? false
    }
    return false
}

func saveRememberMe(isShow: Bool) {
    userDefault.setValue(isShow, forKey: "RememberMe")
    userDefault.synchronize()
}

func getDefault(key: String) -> String {
    if isKeyPresentInUserDefaults(key: key) {
        return userDefault.value(forKey: key) as? String ?? ""
    }
    return ""
}

func saveDefault(key: String, value: String) {
    userDefault.setValue(value, forKey: key)
    userDefault.synchronize()
}

//MARK: - Enum
enum AppStoryboard : String {
    case Main = "Main"
    case Home = "Home"
    case Settings = "Settings"
    case MyProfile = "MyProfile"

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

//MARK: - Functions
func ShowProgress() {
    //    SVProgressHUD.show()
}

func DismissProgress() {
    //    SVProgressHUD.dismiss()
}

func convertDate(_ date: String, dateFormat: String) -> Date {
    if date == "" {
        return Date()
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let date = dateFormatter.date(from: date)
    return date ?? Date()
}

func convertDateFormater(_ date: String, format:String = "yyyy-MM-dd HH:mm:ss", dateFormat: String) -> String {
    if date == "" {
        return ""
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = dateFormat
    return  dateFormatter.string(from: date!)
}

//func convertStringToISO8601(_ date: String, dateFormat: String) -> String {
//    if date == "" {
//        return ""
//    }
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = dateFormat
//    let date = dateFormatter.date(from: date)
//    return  (date?.iso8601)!
//}


extension UIImageView {
    func setCircle() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
    
    func makeRound(size:CGFloat) {
        self.layer.cornerRadius = size
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}

extension UIView {
    func setCircleView() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
}

extension UILabel {
    func setColor(color: UIColor) {
        self.textColor = color
    }
    
    func setColorWithAlpha(color: UIColor, set: CGFloat) {
        self.textColor = color.withAlphaComponent(set)
    }
    
    func setSize(size:CGFloat) {
        self.font = UIFont(name: self.font.fontName, size: size)
    }
}


extension UITextField {
    func setColor(color: UIColor) {
        self.textColor = color
    }
}

extension UITextView {
    func setColor(color: UIColor) {
        self.textColor = color
    }
}

extension UIButton {
    func setColor(color: UIColor) {
        self.setTitleColor(color, for: .normal)
    }
    
    func setTitle(str: String) {
        self.setTitle(str, for: .normal)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}


extension String {
    func localToUTC(dateFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    func UTCToLocal(dateFormat:String = "yyyy-MM-dd HH:mm:ss", returnFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        if self == "" {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = returnFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    func getYear() -> Int {
        let start = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let startDate:Date = dateFormatter.date(from: start)!
        let endDate:Date = Date()
        let cal = NSCalendar.current
        let components = cal.dateComponents([.year], from: startDate, to: endDate)
        return components.year!
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func convertDateFormater(format:String = "yyyy-MM-dd HH:mm:ss", isUTC:Bool = false) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if isUTC {
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
        }
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func convertDateFormater() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        return  dateFormatter.string(from: date!)
    }
}

extension Date {
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}


extension UINavigationController {
    
    func isHidden(isShow:Bool) {
        self.navigationBar.isHidden = !isShow
    }
    
    func getBarHeight() -> CGFloat {
        let navigationBarHeight: CGFloat = self.navigationBar.frame.height
        return navigationBarHeight
    }
    
    func setColor() {
        let navigationBarHeight: CGFloat = self.navigationBar.frame.height
        self.navigationBar.setBackgroundImage(UIImage(named: "ic_header")?.resizeImage(targetSize: CGSize(width: UIScreen.main.bounds.width, height: 85), customHeight: navigationBarHeight), for: .default)
        self.navigationBar.isTranslucent = false
    }
    
    func setWhiteColor(ShowLine:Bool = false) {
        self.navigationBar.shadowImage = UIImage()
        
        self.navigationBar.isTranslucent = false
        if ShowLine {
            self.navigationBar.layer.masksToBounds = false
            self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
            self.navigationBar.layer.shadowOpacity = 0.8
            self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.navigationBar.layer.shadowRadius = 2
        }
        else {
            self.navigationBar.backgroundColor = .white
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.layer.masksToBounds = false
            self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
            self.navigationBar.layer.shadowOpacity = 0
            self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.navigationBar.layer.shadowRadius = 0
        }
    }
    
    func setClearColor() {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.isTranslucent = true
    }
}


extension String {
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

struct DateISO: Codable {
    var date: Date
}

//extension Date{
//    var iso8601: String {
//        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .iso8601
//        guard let data = try? encoder.encode(DateISO(date: self)),
//            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as?  [String: String]
//            else { return "" }
//        return json?.first?.value ?? ""
//    }
//}


extension UIImage {
    
    func isNUll()-> Bool
    {
        
        let size = CGSize(width: 0, height: 0)
        if (self.size.width == size.width)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    func resizeImage(targetSize: CGSize, customHeight:CGFloat = 0) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        
        var topPadding: CGFloat = 20
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = (window?.safeAreaInsets.top)!
        }
        
        let height = customHeight == 0 ? newSize.height : (customHeight + topPadding)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func resize(maxWidthHeight : Double)-> UIImage? {
        
        let actualHeight = Double(size.height)
        let actualWidth = Double(size.width)
        var maxWidth = 0.0
        var maxHeight = 0.0
        
        if actualWidth > actualHeight {
            maxWidth = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualWidth)
            maxHeight = (actualHeight * per) / 100.0
        }else{
            maxHeight = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualHeight)
            maxWidth = (actualWidth * per) / 100.0
        }
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
}

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -5), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}


extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func isValidPassword(testStr:String?) -> Bool {
    guard testStr != nil else { return false }
    // at least one digit
    // at least one lowercase
    // 8 characters total
    //        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
//    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[0-9])(?=.*[a-z])(?=.*[@$!%^+=_~<>*#?&`{|-}`{/.,}`{'\"}`{•¥£€}`{:;}`{()}]).{6,}")
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[0-9])(?=.*[@$!%^+=_~<>*#?&`{|-}`{/.,}`{'\"}`{•¥£€}`{:;}`{()}]).{8,}")

    return passwordTest.evaluate(with: testStr)
}

func jsonString(from object:Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0...length-1).map{ _ in letters.randomElement()! })
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

func validatePhoneNumber(value: String) -> Bool {
    let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

func timeAgoSinceDateNew(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = NSDate()
    let earliest = now.earlierDate(date as Date)
    let latest = (earliest == now as Date) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else {
        return "Just now"
    }
}

//func AlertView(title: String, message: String)
//{
//    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
//    alertWindow.rootViewController = UIViewController()
//    alertWindow.windowLevel = UIWindow.Level.alert + 1;
//    alertWindow.makeKeyAndVisible()
//    alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
//}

func setColorWithName(mainString: String, stringToColor: String) -> NSAttributedString {
    let range = (mainString as NSString).range(of: stringToColor)
    
    let attribute = NSMutableAttributedString.init(string: mainString)
    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: ColorOrange() , range: range)
    
    return attribute
}

public func saveJSON(j: JSON, key: String) {
    userDefault.setValue(j.rawString()!, forKey: key)
    // here I save my Nam as a string
}

public func loadJSON(key: String) -> JSON {
    return isKeyPresentInUserDefaults(key: key) ? JSON.init(parseJSON: userDefault.value(forKey: key) as! String) : JSON()
    // JSON from string must be initialized using .parse()
}

public func deleteJSON(key:String) {
    userDefault.removeObject(forKey: key)
}


//MARK: - Functions Color

func ColorAppTheme() -> UIColor {
    return UIColor(red: 93.0 / 255, green: 153.0 / 255, blue: 196.0 / 255, alpha: 1)
}


func ColorOrange() -> UIColor {
    return UIColor(red: 218/255, green: 115/255, blue: 64/255, alpha: 1)
}

func ColorGraydark() -> UIColor {
    return UIColor(red: 131/255, green: 131/255, blue: 131/255, alpha: 1)
}

func ColorAppGray() -> UIColor {
    return UIColor(red: 244/255, green: 242/255, blue: 242/255, alpha: 1)
}

func ColorBGCard() -> UIColor {
    return UIColor(red: 241/255, green: 242/255, blue: 243/255, alpha: 1)
}

//MARK: - @IBDesignable

@IBDesignable class LabelButton: UILabel {
    var onClick: () -> Void = {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick()
    }
}


//MARK: - Extensions

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

//extension ViewPager {
//    func reloadData(completion: @escaping ()->()) {
//        UIView.animate(withDuration: 0, animations: { self.reloadData() })
//        { _ in completion() }
//    }
//}


extension UICollectionView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y:
                                                         locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}


extension UIImage {
    
    public class func gifImageWithData(data: NSData) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data, nil) else {
            return nil
        }
        
        return UIImage.animatedImageWithSource(source: source)
    }
    
    public class func gifImageWithURL(gifUrl:String) -> UIImage? {
        guard let bundleURL = NSURL(string: gifUrl)
            else {
                return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL as URL) else {
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a!
            a = b!
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b!
                b = rest
            }
        }
    }
    
    class func gcdForArray(array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(a: val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(index: Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(array: delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality:  quality.rawValue)
    }
    
    func png() -> Data? {
        return self.pngData()
    }
}

extension String {
    func strike() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 2,
            range: NSRange(location: 0, length: attributeString.length))
        
        return attributeString
    }
}

func convertImageToBase64String(img: UIImage) -> String {
    return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
}

func convertBase64StringToImage(imageBase64String:String) -> UIImage {
    let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
    let image = UIImage(data: imageData!)
    return image!
}

extension String {
    func toTrim() -> String {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString
    }
    
    func removeAllSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func first(char:Int) -> String {
        return String(self.prefix(char))
    }
    
    func last(char:Int) -> String
    {
        return String(self.suffix(char))
    }
    
    func excludingFirst(char:Int) -> String {
        return String(self.suffix(self.count - char))
    }
    
    func excludingLast(char:Int) -> String
    {
        return String(self.prefix(self.count - char))
    }
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}


extension UIView {
    //Button animation
    func fadeIn() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.7
        }, completion: { (valid) in
            self.fadeIn()
        })
    }
}

private struct AssociatedKeys {
    static var section = "section"
    static var row = "row"
}

extension UIButton {
    var section : Int {
        get {
            guard let number = objc_getAssociatedObject(self,   &AssociatedKeys.section) as? Int else {
                return -1
            }
            return number
        }
        
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.section,Int(value),objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var row : Int {
        get {
            guard let number = objc_getAssociatedObject(self, &AssociatedKeys.row) as? Int else {
                return -1
            }
            return number
        }
        
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.row,Int(value),objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, frame: CGRect,radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: frame).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}

extension Date {
    public func setTimeZero() -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components)
    }
    
    public func setTimeEnd() -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 23
        components.minute = 59
        components.second = 59
        
        return calendar.date(from: components)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIViewController {
    func makeToast(strMessage : String){
        showToast(message: strMessage, vc: self)
    }
}

func showToast(message : String, vc: UIViewController) {
    let toastContainer = UIView(frame: CGRect())
    toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastContainer.alpha = 0.0
    toastContainer.layer.cornerRadius = 25;
    toastContainer.clipsToBounds  =  true
    
    let toastLabel = UILabel(frame: CGRect())
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font.withSize(12.0)
    toastLabel.text = message
    toastLabel.clipsToBounds  =  true
    toastLabel.numberOfLines = 0
    
    toastContainer.addSubview(toastLabel)
    vc.view.addSubview(toastContainer)
    
    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastContainer.translatesAutoresizingMaskIntoConstraints = false
    
    let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
    let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
    let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
    let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
    toastContainer.addConstraints([a1, a2, a3, a4])
    
    let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: vc.view, attribute: .leading, multiplier: 1, constant: 65)
    let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: vc.view, attribute: .trailing, multiplier: 1, constant: -65)
    let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: vc.view, attribute: .bottom, multiplier: 1, constant: -75)
    vc.view.addConstraints([c1, c2, c3])
    
    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
        toastContainer.alpha = 1.0
    }, completion: { _ in
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
            toastContainer.alpha = 0.0
        }, completion: {_ in
            toastContainer.removeFromSuperview()
        })
    })
}


extension UITapGestureRecognizer {
    
    func didTapAttributedString(_ string: String, in label: UILabel) -> Bool {
        
        guard let text = label.text else {
            
            return false
        }
        
        let range = (text as NSString).range(of: string)
        return self.didTapAttributedText(label: label, inRange: range)
    }
    
    private func didTapAttributedText(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        guard let attributedText = label.attributedText else {
            
            assertionFailure("attributedText must be set")
            return false
        }
        
        let textContainer = createTextContainer(for: label)
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        if let font = label.font {
            
            textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))
        }
        textStorage.addLayoutManager(layoutManager)
        
        let locationOfTouchInLabel = location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let alignmentOffset = aligmentOffset(for: label)
        
        let xOffset = ((label.bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((label.bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - xOffset, y: locationOfTouchInLabel.y - yOffset)
        
        let characterTapped = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        let lineTapped = Int(ceil(locationOfTouchInLabel.y / label.font.lineHeight)) - 1
        let rightMostPointInLineTapped = CGPoint(x: label.bounds.size.width, y: label.font.lineHeight * CGFloat(lineTapped))
        let charsInLineTapped = layoutManager.characterIndex(for: rightMostPointInLineTapped, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return characterTapped < charsInLineTapped ? targetRange.contains(characterTapped) : false
    }
    
    private func createTextContainer(for label: UILabel) -> NSTextContainer {
        
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        return textContainer
    }
    
    private func aligmentOffset(for label: UILabel) -> CGFloat {
        
        switch label.textAlignment {
            
        case .left, .natural, .justified:
            
            return 0.0
        case .center:
            
            return 0.5
        case .right:
            
            return 1.0
            
            @unknown default:
            
            return 0.0
        }
    }
}

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}



enum FontNamesKeys: String {
    case Inter_Regular = "Inter-Regular"
    case Inter_Thin = "Inter-Thin"
    case Inter_Light = "Inter-Light"
    case Inter_Medium = "Inter-Medium"
    case Inter_SemiBold = "Inter-SemiBold"
    case Inter_Bold = "Inter-Bold"

}

func themeFonts(fontName: FontNamesKeys, size: CGFloat) -> UIFont {
    return UIFont(name: fontName.rawValue, size: size)!
}


//Font Family Name = [Inter]
//Font Names = [["Inter-Regular", "Inter-Thin", "Inter-Light", "Inter-Medium", "Inter-SemiBold", "Inter-Bold"]]

//Font Names = [["Poppins-Regular", "Poppins-Italic", "Poppins-Thin", "Poppins-ThinItalic", "Poppins-ExtraLight", "Poppins-ExtraLightItalic", "Poppins-Light", "Poppins-LightItalic", "Poppins-Medium", "Poppins-MediumItalic", "Poppins-SemiBold", "Poppins-SemiBoldItalic", "Poppins-Bold", "Poppins-BoldItalic", "Poppins-ExtraBold", "Poppins-ExtraBoldItalic", "Poppins-Black", "Poppins-BlackItalic"]]


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
