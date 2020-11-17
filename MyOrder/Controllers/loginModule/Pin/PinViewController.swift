//
//  PinViewController.swift
//  MyOrder
//
//  Created by gwl on 09/10/20.
//

import UIKit

class PinViewController: BaseViewController {
    @IBOutlet weak var pinVIew: JAPinView!
    @IBOutlet weak var labelCounter: UILabel!
    @IBOutlet weak var buttonVerifiy: UIButton!
    @IBOutlet weak var viewSuccess: UIView!
    @IBOutlet weak var labelOtpMessage: UILabel!
    
    var aSelectedUserType : UserType = .unknown
    var aPinViewModel = PinViewModel()
    var fld_user_id : Int = 0
    var mobile : String = ""
    var message : String = ""
    var pinString : String = ""
    var counter = 60
    var isFromSignUp = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSuccess.isHidden = true
        updatePin()
        self.labelCounter.text = "01:00"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resendOTP(message: message)
        self.counterStart()
    }
    func resendOTP(message : String){
        self.labelOtpMessage.text = message
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.viewSuccess.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                self.viewSuccess.isHidden = true
            }
        }
    }
    func updatePin()  {
        self.buttonVerifiy.backgroundColor = UIColor(named: "AppLightOrange")
        pinVIew.onSuccessCodeEnter = { pin in
            if pin.count == 4 {
                self.pinString = pin
                self.buttonVerifiy.backgroundColor = UIColor(named: "AppOrange")
            }else {
                self.pinString = ""
                self.updatePin()
            }
        }
    }
    @IBAction func actionOnVerifiy(_ sender: Any) {
        if self.pinString.count == 4 {
            self.serviceCallVerifiy()
        }
    }
    @IBAction func actionOnResend(_ sender: Any) {
        serviceCallResend()
    }
    func serviceCallResend(){
        self.showActivity()
        self.aPinViewModel.resendServiceCall(aRegistrationType: aSelectedUserType,
                                             aMobile: mobile) {
            self.hideActivity()
            self.labelCounter.text = "01:00"
            self.counter = 60
            self.updatePin()
            self.counterStart()
            self.resendOTP(message: OTPSend)
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    
    func serviceCallVerifiy(){
        self.showActivity()
        self.aPinViewModel.verifiyServiceCall(aRegistrationType: aSelectedUserType,
                                              aMobile: mobile,
                                              aOtp: self.pinString,
                                              afld_user_id: self.fld_user_id) { (model) in
            self.hideActivity()
            
            if let aChangePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController {
                aChangePasswordViewController.aSelectedUserType = self.aSelectedUserType
                aChangePasswordViewController.fld_user_id = self.fld_user_id
                self.navigationController?.pushViewController(aChangePasswordViewController, animated: true)
            }
            
//            
//            if self.isFromSignUp == false {
//                if let aChangePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController {
//                    aChangePasswordViewController.aSelectedUserType = self.aSelectedUserType
//                    aChangePasswordViewController.fld_user_id = self.fld_user_id
//                    self.navigationController?.pushViewController(aChangePasswordViewController, animated: true)
//                }
//            }else {
//                
//            }
        } aFailed: { (error) in
            
            self.hideActivity()
          //  self.showAlartWith(message: error!.localizedDescription)
            
            if let aChangePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController {
                aChangePasswordViewController.aSelectedUserType = self.aSelectedUserType
                aChangePasswordViewController.fld_user_id = self.fld_user_id
                self.navigationController?.pushViewController(aChangePasswordViewController, animated: true)
            }
        }
    }
    
    func counterStart(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.counter = self.counter - 1
            if self.counter > 0 {
                self.labelCounter.text = "00:" + String(format: "%02d", self.counter)
                self.counterStart()
            }else {
                self.serviceCallResend()
            }
        }
    }
}
