//
//  ForgetPasswordViewController.swift
//  MyOrder
//
//  Created by gwl on 09/10/20.
//

import UIKit

class ForgetPasswordViewController: BaseViewController {
    @IBOutlet weak var textFieldMobile: UITextField!
    var aSelectedUserType : UserType = .unknown
    let aForgetPasswordViewModel = ForgetPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        #if targetEnvironment(simulator)
        self.textFieldMobile.text = "4545451616"
        #endif
    }
    @IBAction func actionOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnContinue(_ sender: Any) {
        if let text = self.isValidateUI() {
            self.showAlartWith(message: text)
        }else {
            self.textFieldMobile.resignFirstResponder()
            self.serviceCall()
        }
    }
    func isValidateUI() -> String? {
        if self.textFieldMobile.text?.isEmpty == true {
            return SelectMobile
        }
        if self.textFieldMobile.text!.count < 10 || self.textFieldMobile.text!.count > 10 {
            return SelectDigitMobile
        }
        return nil
    }
    func serviceCall(){
        self.showActivity()
        self.aForgetPasswordViewModel.forgetServiceCall(aRegistrationType: aSelectedUserType,
                                                      aMobile: self.textFieldMobile.text ?? "") { (model) in
            self.hideActivity()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                if let aPinViewController = self.storyboard?.instantiateViewController(withIdentifier: "PinViewController") as? PinViewController {
                    aPinViewController.fld_user_id = model?.fld_user_id ?? 0
                    aPinViewController.message = model?.message ?? OTPSend
                    aPinViewController.aSelectedUserType = self.aSelectedUserType
                    aPinViewController.mobile = self.textFieldMobile.text ?? ""
                    self.navigationController?.pushViewController(aPinViewController, animated: true)
                }
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
