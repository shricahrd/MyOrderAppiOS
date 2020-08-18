//
//  ForgotPasswordController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signInAction(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    func forgotPassword(mobileNumber:String,flg:String){
        
        
    }
    
   

}
