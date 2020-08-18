//  SignupTermsCController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 17/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
class SignupTermsCController: UIViewController {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var popUpBG: UIView!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var textViewDetail: UITextView!
    @IBOutlet var radioButton: UIButton!
    
    var termsCController = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBg.layer.cornerRadius = 35
        viewBg.clipsToBounds = true
        popUpBG.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        acceptButton.layer.cornerRadius=25
        acceptButton.clipsToBounds = true
        
        radioButton.layer.borderWidth = 1
        radioButton.layer.borderColor = UIColor.gray.cgColor
        radioButton.layer.cornerRadius = 11
        radioButton.clipsToBounds = true
    }
    

    @IBAction func acceptAction(_ sender: Any) {
        if termsCController == true{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }else {
            
            Utility.showAlert(withMessage: "I Agree to Terms", onController: self)

        }

        
        
    }

    @IBAction func radioButton(_ sender: UIButton) {
        
        if (sender.isSelected) {
            sender.isSelected = false
            
            termsCController = true
            radioButton.setImage(UIImage(named: "radioButtonSelected"), for: .normal)
        } else {
            sender.isSelected = true
             radioButton.setImage(UIImage(named: "radioButton"), for: .normal)
        }
    }
    
}
