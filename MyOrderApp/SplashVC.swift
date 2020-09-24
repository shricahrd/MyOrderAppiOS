//  SVProgressHUD.dismiss()
//  EZLoadingActivity.hide()//
//  SplashVC.swift
//  PatientAppNew
//  Created by Malini on 3/4/16.
//  Copyright © 2016 . All Rights Reserved.
import UIKit
import EventKit
import CoreData
//import Alamofire
public var splashID: String = "0";
var userId: String = "0";
class SplashVC: UIViewController, URLSessionDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var splashImageView: UIImageView!
    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setSplashImage()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(dismissSplashController), userInfo: nil, repeats: false)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    @objc private func dismissSplashController() {
          self.moveToHomeAndLogin()
    }
//    func getUserID() -> String {
//        if let pkUD = UserDefaults.standard.value(forKey: UserInfo.pkUD) as? String {
//            return pkUD
//        }
//        return "0"
//    }
    func moveToHomeAndLogin() {
        if isKeyPresentInUserDefaults(key: "UserInfo") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "Home") as? Home {
//                 vc.navigationController?.isNavigationBarHidden = true
//              vc.navigationItem.hidesBackButton = true
              
                 self.navigationController?.show(vc,sender:self)
            }
        } else {
            let storyboard1: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let vc = storyboard1.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC {
                vc.navigationController?.isNavigationBarHidden = true
                vc.navigationItem.hidesBackButton = true
                self.navigationController?.show(vc,sender:self)
            }
        }
    }
    
    func setSplashImage() {
        //splashImageView.image = UIImage(named: "logo_splash")
    }
    
}
