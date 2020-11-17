//
//  SignUpViewController.swift
//  MyOrder
//
//  Created by gwl on 09/10/20.
//

import UIKit
class SignUpViewController: BaseViewController {
    @IBOutlet weak var viewTermConditions: UIView!
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonAccept: UIButton!
    var termAccepted = false
    var aSelectedUserType : UserType = .unknown
    let aSignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSignUp.makeBottomShadow()
        viewTermConditions.isHidden = true
        #if targetEnvironment(simulator)
        self.textFieldUsername.text = "Test"
        self.textFieldEmail.text = "test@cona.com"
        self.textFieldMobile.text = "4545451616"
        self.textFieldPassword.text = "test1234"
        #endif
    }
    @IBAction func actionOnBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func actionOnHideShowPassword(_ sender: Any) {
        self.textFieldPassword.isSecureTextEntry = !self.textFieldPassword.isSecureTextEntry
    }
    @IBAction func actionOnSignUp(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.view.resignFirstResponder()
            viewTermConditions.isHidden = false
        }
    }
    @IBAction func actionOnSignIn(_ sender: Any) {
        if let aLoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(aLoginViewController, animated: true)
        }
    }
    @IBAction func actionOnTermAccept(_ sender: Any) {
        termAccepted = !termAccepted
        if termAccepted == true {
            self.buttonAccept.backgroundColor = UIColor(named: "AppOrange")
        }else {
            self.buttonAccept.backgroundColor = UIColor(named: "AppLightOrange")
        }
    }
    @IBAction func actionOncancel(_ sender: Any) {
        viewTermConditions.isHidden = true
        termAccepted = false
    }
    @IBAction func actionOnAccept(_ sender: Any) {
        if termAccepted == true {
            viewTermConditions.isHidden = true
            serviceCall()
            termAccepted = false
        }
    }
    func isValidateUI() -> String? {
        if self.textFieldUsername.text?.isEmpty == true {
            return SelectUsername
        }
        if self.textFieldEmail.text?.isEmpty == true {
            return SelectEmail
        }
        if self.isValidEmail(self.textFieldEmail.text!) == false {
            return SelectVaildEmail
        }
        if self.textFieldMobile.text?.isEmpty == true {
            return SelectMobile
        }
        if self.textFieldMobile.text!.count < 10 || self.textFieldMobile.text!.count > 10 {
            return SelectDigitMobile
        }
        if self.textFieldPassword.text?.isEmpty == true {
            return SelectPassword
        }
        return nil
    }
    func serviceCall(){
        self.showActivity()
        self.aSignUpViewModel.registrationServiceCall(aRegistrationType: aSelectedUserType,
                                                      aUsername: self.textFieldUsername.text ?? "",
                                                      aMobile: self.textFieldMobile.text ?? "",
                                                      aPassword: self.textFieldPassword.text ?? "",
                                                      aEmail: self.textFieldEmail.text ?? "") { (model) in
            self.hideActivity()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let aPinViewController = self.storyboard?.instantiateViewController(withIdentifier: "PinViewController") as? PinViewController {
                    aPinViewController.fld_user_id = model?.id ?? 0
                    aPinViewController.message = OTPSend
                    aPinViewController.aSelectedUserType = self.aSelectedUserType
                    aPinViewController.mobile = self.textFieldMobile.text ?? ""
                    aPinViewController.isFromSignUp = true
                    self.navigationController?.pushViewController(aPinViewController, animated: true)
                }
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
