//  VerifyOTPController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class VerifyOTPController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var viewBg: UIView!
    @IBOutlet var textFieldOtp: UITextField!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var verifyButton: UIButton!
    @IBOutlet var resendButton: UIButton!
    @IBOutlet var sentOtpMessage: UILabel!
    @IBOutlet var messageBg: UIView!
    
    
    var userId = String()
    var flage = String()
    var phoneNumber = String()
    
    
    var userType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBg.layer.cornerRadius = 35
        viewBg.clipsToBounds = true
        textFieldOtp.layer.borderWidth = 1
        textFieldOtp.layer.borderColor = UIColor.lightGray.cgColor
        textFieldOtp.delegate = self
        
    }
    
    @IBAction func verifyAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordController") as? ForgotPasswordController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    @IBAction func resendOtpAction(_ sender: Any) {
        
        if userType == "1" {
            veriFeyOtp(userId: userId, otp: textFieldOtp.text!, flage: flage, phoneNumber: phoneNumber)
        }else if userType == "2" {
            Verifystockfacture(userId: userId, otp: textFieldOtp.text!, flage: flage, phoneNumber: phoneNumber)
        }else if userType == "3" {
            Verifydistributorfacture(userId: userId, otp: textFieldOtp.text!, flage: flage, phoneNumber: phoneNumber)
        } else if userType == "4" {
            Verifyretailerfacture(userId: userId, otp: textFieldOtp.text!, flage: flage, phoneNumber: phoneNumber)
        } else if userType == "5" {
            Verifysalesagentfacture(userId: userId, otp: textFieldOtp.text!, flage: flage, phoneNumber: phoneNumber)
        }
    }
    
    
    
    func veriFeyOtp(userId:String,otp:String,flage:String,phoneNumber:String){
        
        ApiClient.loder(roughter: APIRouter.VerifyManufactur(userId: userId, Otp: otp, flag: flage, phoneNumber: phoneNumber)) { (verifeyoTpResponce:LoginResponce) in
            
            print("\(verifeyoTpResponce)")
        }
    }
    
    func Verifystockfacture(userId:String,otp:String,flage:String,phoneNumber:String){
        ApiClient.loder(roughter: APIRouter.Verifystockfacture(userId: userId, Otp: otp, flag: flage, phoneNumber: phoneNumber)) { (verifeyoTpResponce:LoginResponce) in
            
            print("\(verifeyoTpResponce)")
        }
    }
    
    
    
    func Verifydistributorfacture(userId:String,otp:String,flage:String,phoneNumber:String){
        ApiClient.loder(roughter: APIRouter.Verifydistributorfacture(userId: userId, Otp: otp, flag: flage, phoneNumber: phoneNumber)) { (verifeyoTpResponce:LoginResponce) in
            
            print("\(verifeyoTpResponce)")
        }
    }
    
    
    func Verifyretailerfacture(userId:String,otp:String,flage:String,phoneNumber:String){
        ApiClient.loder(roughter: APIRouter.Verifyretailerfacture(userId: userId, Otp: otp, flag: flage, phoneNumber: phoneNumber)) { (verifeyoTpResponce:LoginResponce) in
            
            print("\(verifeyoTpResponce)")
        }
    }
    
    func Verifysalesagentfacture(userId:String,otp:String,flage:String,phoneNumber:String){
        ApiClient.loder(roughter: APIRouter.Verifysalesagentfacture(userId: userId, Otp: otp, flag: flage, phoneNumber: phoneNumber)) { (verifeyoTpResponce:LoginResponce) in
            
            print("\(verifeyoTpResponce)")
        }
    }
}
