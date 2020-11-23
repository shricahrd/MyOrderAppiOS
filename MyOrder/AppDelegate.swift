//
//  AppDelegate.swift
//  MyOrder
//
//  Created by gwl on 08/10/20.
//

import UIKit
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().barTintColor = .white
        //        UINavigationBar.appearance().tintColor = .white
        //        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
       
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController,
                                 completion: @escaping (_ control: UIViewController) -> Void) {
        if let navigationController = controller as? UINavigationController {
            completion(navigationController.visibleViewController!)
        }
        if let navigationController = controller as? FAPanelController {
            completion(navigationController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                completion(selected)
            }
        }
        if let presented = controller?.presentedViewController {
            completion(presented)
        }
    }
}
