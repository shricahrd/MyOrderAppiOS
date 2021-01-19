//
//  ChangePasswordViewController.swift
//  MyOrder
//
//  Created by sourabh on 10/10/20.
//

import UIKit

class ChangePasswordViewController: BaseViewController {
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonBack: UIButton!

    var aChangePasswordViewModel = ChangePasswordViewModel()
    var aSelectedUserType : UserType = .unknown
    var fld_user_id = 0
    var shouldShowBack = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonBack.isHidden = self.shouldShowBack
    }
    @IBAction func actionOnHideShowConfirmPassword(_ sender: Any) {
        self.textFieldConfirmPassword.isSecureTextEntry = !self.textFieldConfirmPassword.isSecureTextEntry
    }
    @IBAction func actionOnHideShowPassword(_ sender: Any) {
        self.textFieldPassword.isSecureTextEntry = !self.textFieldPassword.isSecureTextEntry
    }
    @IBAction func actionOnSubmit(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.textFieldPassword.resignFirstResponder()
            self.textFieldConfirmPassword.resignFirstResponder()
        }
    }
    @IBAction func actionOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func isValidateUI() -> String? {
        if self.textFieldPassword.text?.isEmpty == true {
            return SelectPassword
        }
        if self.textFieldConfirmPassword.text?.isEmpty == true {
            return SelectConfirmPassword
        }
        if self.textFieldPassword.text != self.textFieldConfirmPassword.text {
            return SelectPasswordMatched
        }
        return nil
    }
    
    func resetServiceCall(){
        self.showActivity()
        aChangePasswordViewModel.resetServiceCall(aRegistrationType: aSelectedUserType,
                                                  aPassword: self.textFieldConfirmPassword.text ?? "",
                                                  afld_user_id: self.fld_user_id) { (model) in
            self.hideActivity()
            
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
