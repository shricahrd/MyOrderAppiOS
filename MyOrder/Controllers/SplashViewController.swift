//
//  SplashViewController.swift
//  MyOrder
//
//  Created by gwl on 18/11/20.
//

import UIKit
class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let oldUser = UserDefaults.standard.value(forKey: OldUser) as? [String: Any]{
            let aLoginModel = LoginModel(fromDictionary:oldUser)
            let oldUserType = UserDefaults.standard.value(forKey: OldUserType) as! Int
            UserModel.shared.setUserModel(aLoginModel: aLoginModel, aUserType: UserType(rawValue: oldUserType) ?? .unknown)
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                BaseViewController().addSideMenu()
            }
        }else {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "WellcomeViewController") as! WellcomeViewController
            let centerNavVC = UINavigationController(rootViewController: redViewController)
            UIApplication.shared.windows.first?.rootViewController = centerNavVC
        }
    }
}
