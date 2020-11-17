//
//  LoginViewController.swift
//  MyOrder
//
//  Created by gwl on 09/10/20.
//

import UIKit
class LoginViewController: BaseViewController {
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var viewSignIn: UIView!
    var aSelectedUserType : UserType = .unknown
    let aLoginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad() 
        viewSignIn.makeBottomShadow()
        #if targetEnvironment(simulator)
        switch aSelectedUserType {
        case .retailer:
            self.textFieldUsername.text = "8989000986"
            self.textFieldPassword.text = "12345678"
        case .distributor:
            self.textFieldUsername.text = "7405655808"
            self.textFieldPassword.text = "1234567890"
        case .manufacture:
            self.textFieldUsername.text = "8200145181"
            self.textFieldPassword.text = "1234567890"
        case .stockist:
            self.textFieldUsername.text = "8200145181"
            self.textFieldPassword.text = "1234567890"
        case .agent:
            self.textFieldUsername.text = "7405655808"
            self.textFieldPassword.text = "123123123"
        default:
            self.textFieldUsername.text = ""
            self.textFieldPassword.text = ""
        }
        #endif
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func actionOnBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func buttonShowHidePassword(_ sender: Any) {
        self.textFieldPassword.isSecureTextEntry = !self.textFieldPassword.isSecureTextEntry
    }
    @IBAction func actionOnForgetpassword(_ sender: Any) {
        if let aForgetPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController {
            aForgetPasswordViewController.aSelectedUserType = self.aSelectedUserType
            self.navigationController?.pushViewController(aForgetPasswordViewController, animated: true)
        }
    }
    @IBAction func actionOnSignIn(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.textFieldUsername.resignFirstResponder()
            self.textFieldPassword.resignFirstResponder()
            self.serviceCall()
        }
    }
    @IBAction func actionOnSignUp(_ sender: Any) {
        if let aSignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(aSignUpViewController, animated: true)
        }
    }
    
    func isValidateUI() -> String? {
//        if self.textFieldUsername.text?.isEmpty == true {
//            return SelectUsername
//        }
//        if self.textFieldEmail.text?.isEmpty == true {
//            return SelectEmail
//        }
//        if self.isValidEmail(self.textFieldEmail.text!) == false {
//            return SelectVaildEmail
//        }
        if self.textFieldUsername.text?.isEmpty == true {
            return SelectMobile
        }
        if self.textFieldUsername.text!.count < 10 || self.textFieldUsername.text!.count > 10 {
            return SelectDigitMobile
        }
        if self.textFieldPassword.text?.isEmpty == true {
            return SelectPassword
        }
        return nil
    }
    func serviceCall(){
//        #if targetEnvironment(simulator)
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//            self.addSideMenu()
//        }
//        #else
        self.showActivity()
        self.aLoginViewModel.loginServiceCall(aRegistrationType: aSelectedUserType,
                                                      aMobile: self.textFieldUsername.text ?? "",
                                                      aPassword: self.textFieldPassword.text ?? "") { (model) in
            self.hideActivity()
            UserModel.shared.setUserModel(aLoginModel: model, aUserType: self.aSelectedUserType)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.addSideMenu()
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
//        #endif
       
    }
}
