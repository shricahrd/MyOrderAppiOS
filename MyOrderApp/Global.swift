
import Foundation
import UIKit
import UserNotifications

enum UserInfo {
    static let tokenId = "token"
}

enum AppNotifications {
    static let newMessage = "newMessage"
    static let logingStatus = "co.di.loginStatus"
    static let tokenErrorStatus = "co.di.ErrorStatus"
    static let afterLoginGetReminder = "co.di.GetReminder"
    static let newAppt = "co.di.newAppt"
    static let emailVerified = "emailVerified"
    static let showCalendar = "showCalendar"
}


extension UIView {
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
    
}

func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
    guard let url = URL(string: urlString) else {
        return closure(nil)
    }
    let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
        guard error == nil else {
            print("error: \(String(describing: error))")
            return closure(nil)
        }
        guard response != nil else {
            print("no response")
            return closure(nil)
        }
        guard data != nil else {
            print("no data")
            return closure(nil)
        }
        DispatchQueue.main.async {
            closure(UIImage(data: data!))
        }
    }; task.resume()
}

class CommonMethods {
    static let sharedInstance = CommonMethods()
    var userFollowUps: [NSDictionary]?
    var newWindow : UIWindow?
    var view = UIViewController()
    
    // MARK:- Popup
    func showCustomAlertViewWith(title: String?, message: String, buttonTitle: String?) {
        let alertView = SIAlertView(title: title, andMessage: message)
        if buttonTitle != nil {
            alertView?.addButton(withTitle: buttonTitle, type: .cancel, handler: { (alert) in
                NotificationCenter.default.post(name:Notification.Name(rawValue:AppNotifications.tokenErrorStatus), object: nil, userInfo: nil)
            })
        } else {
            alertView?.addButton(withTitle: "OK", type: .cancel, handler: { (alert) in
            })
        }
        alertView?.transitionStyle = .fade
        alertView?.show()
    }
    
    func afterGetErrorPushSplash(errorCode : String, viewController: UIViewController,tab:UITabBarController) {
    }
    
    func deleteLogout() {
 
    }
    
    // Get Doctor ingo and push to doctor profile
    func getDoctorInfoAndPushProfile(id : String, specialistId: String, viewController: UIViewController, canScheduleAppt: Bool) {
    }

    func callSplashApi(_ viewController: UIViewController) {
    }
    
    func responseInOffline(dict: NSDictionary?, _ viewController: UIViewController) {
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getCurrentMillis()->Int64{
        return  Int64(NSDate().timeIntervalSince1970 * 1000)
    }
    
    func getSixteenDigitRandomNumber() -> String {
        let sz: UInt64 = 100000000
        let ld: UInt64 = UInt64(arc4random_uniform(9)+1)
        let ms: UInt64 = UInt64(arc4random_uniform(UInt32(sz/10)))
        let ls: UInt64 = UInt64(arc4random_uniform(UInt32(sz)))
        let digits: UInt64 = ld * (sz*sz/10) + (ms * sz) + ls
        return "\(digits)"
    }

    // rk
    func getDateInNotificationString(_ monthString: String) -> String {
        var month = monthString
        month = month.replacingOccurrences(of: "T", with: " ")
        month = month.replacingOccurrences(of: ".000Z", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current// TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDateString = dateFormatter.date(from: month)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "dd-MM-yyyy"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    
    // rk
    func getMonthFromDateString(_ monthString: String) -> String {
        var month = monthString
        month = month.replacingOccurrences(of: "T", with: " ")
        month = month.replacingOccurrences(of: ".000Z", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current// TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDateString = dateFormatter.date(from: month)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "MMM"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    
    //rk
    func getDateStringSingleDigits(_ dateString: String) -> String {
        var date = dateString
        date = date.replacingOccurrences(of: "T", with: " ")
        date = date.replacingOccurrences(of: ".000Z", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDateString = dateFormatter.date(from: date)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "d"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    
    //rk
    func getDateString(_ dateString: String) -> String {
        var date = dateString
        date = date.replacingOccurrences(of: "T", with: " ")
        date = date.replacingOccurrences(of: ".000Z", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current// TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDateString = dateFormatter.date(from: date)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "dd"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    
    //rk
    func getTimeString(_ timeString: String) -> String {
        var time = timeString
        time = time.replacingOccurrences(of: "T", with: " ")
        time = time.replacingOccurrences(of: ".000Z", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current// TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDateString = dateFormatter.date(from: time)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "hh:mm a"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    
    func getupcomingTimeString(_ timeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm:ss"
        let localDateString = dateFormatter.date(from: timeString)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "hh:mm"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }

    func getTimeForNewPaymentString(_ timeString: String) -> String {
        var time = timeString
        time = time.replacingOccurrences(of: "T", with: " ")
        time = time.replacingOccurrences(of: ".000Z", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDateString = dateFormatter.date(from: time)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "h:mm a"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    //rk
    func getTime(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        dateFormatter.timeZone = TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "HH:mm:ss"
        //dateFormatter.timeStyle = .short
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
    }
    
    func getTime12format(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        guard let date12 = dateFormatter.date(from: date) else {
            return ""
        }
        dateFormatter.dateFormat = "h:mm a"
        let date22 = dateFormatter.string(from: date12)
        //dateFormatter.timeStyle = .short
        return date22
    }
    
    //get month for visit history
    func getMonthString(_ monthString: String) -> String {
        let month = monthString
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let localDateString = dateFormatter.date(from: month)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "MMM"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    
    func getDate(_ date: String) -> String {
        let day = date
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "IST")
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let localDateString = dateFormatter.date(from: day)
        if localDateString != nil {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.timeZone = TimeZone.autoupdatingCurrent
            displayDateFormatter.dateStyle = DateFormatter.Style.long
            displayDateFormatter.timeStyle = DateFormatter.Style.none
            displayDateFormatter.dateFormat = "dd"
            let displayDate = displayDateFormatter.string(from: localDateString!)
            return displayDate
        }
        return ""
    }
    
    func getTimeZoneName() -> String {
        var myTimeZoneName : String {
            return TimeZone.current.identifier
        }
        return myTimeZoneName
    }
    
    func fetchUserFollowups() {
    }
    
    func updateUserFollowUps(_ followups: [NSDictionary]) {
        userFollowUps = followups
    }
    
    func removeUserFollowUps() {
        userFollowUps = nil
    }
    
    func hexStringToUIColorOpacity (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.85)
        )
    }
    
   @objc func linkHraData() {
    }
    
    func linkBranchData(params: [AnyHashable: Any]) {
    }
    
    
    func openInAppWebPage(_ urlSting: String, navigationContontroller: UINavigationController, pageTitle: String?, showShareOption: Bool) {
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

func getDeviceToken() -> String {
    if let deviceToken = UserDefaults.standard.value(forKey: UserInfo.tokenId) as? String {
        return deviceToken
    }
    return ""
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

func isValidEmail( _ testStr:String) -> Bool {
    let testStr = testStr.trimmingCharacters(in: CharacterSet.whitespaces);
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result=emailTest.evaluate(with: testStr)
    return result
}

