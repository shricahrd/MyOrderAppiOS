//  ViewController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 06/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
import UIKit


enum LoginType {
    
    case STOCKIST
    case DISTRIBUTOR
    case RETAILER
    case SALESAGENT
    case MANUFACTURER
    
    
}


class ViewController: UIViewController {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var forgotbutton: UIButton!
    @IBOutlet var signin: UIButton!
    
    
    var catagaryLogin = String()
    
    var loginType = LoginType.DISTRIBUTOR
    
override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColorforBackGroundColor
    
    self.viewBg.layer.cornerRadius = 30
    self.viewBg.clipsToBounds = true
    self.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha:1.0)
    self.viewBg.layer.borderWidth = 1.4;
    self.viewBg.layer.borderColor = UIColor.gray.withAlphaComponent(0.1).cgColor
    self.viewBg.layer.masksToBounds = false
    self.viewBg.layer.shadowRadius = 3.0
    self.viewBg.layer.shadowColor = UIColor.black.cgColor
    self.viewBg.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    self.viewBg.layer.shadowOpacity = 0.7
    
    self.signin.layer.cornerRadius = 12;
    
    
    switch loginType {
   
    case .STOCKIST: break
        
    case .DISTRIBUTOR: break
        
    case .RETAILER: break
        
    case .SALESAGENT: break
        
    case .MANUFACTURER:break
        
   
    }
    /*
     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterPlay") as! RegisterPlay
     self.navigationController?.pushViewController(vc, animated: true)
    */
    
    
    
    
    
    
    
 }

    @IBAction func forgotButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordController") as! ForgotPasswordController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func signin(_ sender: Any) {
        
        
        if catagaryLogin == "1"{  // MAnufacture
            manufatur(mobileNumber: userName.text ?? "", password: password.text ?? "")
            
        } else if catagaryLogin == "2"{ // Dustabuter
            dustabuter(mobileNumber: userName.text ?? "", password: password.text ?? "")

            
        } else if catagaryLogin == "3"{  // btnRetailer
            
            btnRetailer(mobileNumber: userName.text ?? "", password: password.text ?? "")

            
            
        } else if catagaryLogin == "4"{ // btnStokist
            
            Stokist(mobileNumber: userName.text ?? "", password: password.text ?? "")

            
            
        } else if catagaryLogin == "5" { // btnSalesAgent
            
            salesAgent(mobileNumber: userName.text ?? "", password: password.text ?? "")

        }else {
            
            
        }
        
        
    }
}

// MAEK:- LOGIN API
extension ViewController {
    
    // Manufature
    
    func manufatur(mobileNumber:String,password:String){
        
        ApiClient.loder(roughter: APIRouter.loginManufacture(mobileNumber: mobileNumber, password: password)) { (loginResponce:LoginResponce) in
            
            print("\(loginResponce)")
            
            if loginResponce.status == true {
                
                if loginResponce.loginData?.isOtpVerified == 0 {
                    
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
                        
                        vc.userId = "\(loginResponce.loginData?.fldUserID ?? 0)"
                        vc.flage = "1"
                        vc.phoneNumber = "\(loginResponce.loginData?.fldUserPhone ?? "")"
                        vc.userType = "1"

                        
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else {
                    Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
                    
                    
                }
                
            } else {
                
                Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
            }
            
        }
    }
    
    
    // Dustabuter
    func dustabuter(mobileNumber:String,password:String){
        
        ApiClient.loder(roughter: APIRouter.logindistributorfacture(mobileNumber: mobileNumber, password: password)) { (loginResponce:LoginResponce) in
            
            print("\(loginResponce)")
            
            if loginResponce.status == true {
                
                if loginResponce.loginData?.isOtpVerified == 0 {
                    
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
                        
                        vc.userId = "\(loginResponce.loginData?.fldUserID ?? 0)"
                        vc.flage = "1"
                        vc.phoneNumber = "\(loginResponce.loginData?.fldUserPhone ?? "")"
                        vc.userType = "2"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            } else {
                
                Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
            }
        }
    }
    //btnRetailer
    
    func btnRetailer(mobileNumber:String,password:String){
        
        ApiClient.loder(roughter: APIRouter.loginretailerfacture(mobileNumber: mobileNumber, password: password)) { (loginResponce:LoginResponce) in
            
            print("\(loginResponce)")
            
            if loginResponce.status == true {
                
                if loginResponce.loginData?.isOtpVerified == 0 {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
                        
                        vc.userId = "\(loginResponce.loginData?.fldUserID ?? 0)"
                        vc.flage = "1"
                        vc.phoneNumber = "\(loginResponce.loginData?.fldUserPhone ?? "")"
                        vc.userType = "3"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            } else {
                
                Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
            }
            
        }
    }
    
    //btnStokist
    
    
    func Stokist(mobileNumber:String,password:String){
        
        ApiClient.loder(roughter: APIRouter.loginstockfacture(mobileNumber: mobileNumber, password: password)) { (loginResponce:LoginResponce) in
            
            print("\(loginResponce)")
            
            if loginResponce.status == true {
                
                if loginResponce.loginData?.isOtpVerified == 0 {
                    
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
                        
                        vc.userId = "\(loginResponce.loginData?.fldUserID ?? 0)"
                        vc.flage = "1"
                        vc.phoneNumber = "\(loginResponce.loginData?.fldUserPhone ?? "")"
                        vc.userType = "4"
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            } else {
                
                Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
            }
            
        }
    }
    
    
    //SalesAgent
    
    
    func salesAgent(mobileNumber:String,password:String){
        
        ApiClient.loder(roughter: APIRouter.loginsalesagentfacture(mobileNumber: mobileNumber, password: password)) { (loginResponce:LoginResponce) in
            
            print("\(loginResponce)")
            
            if loginResponce.status == true {
                
                if loginResponce.loginData?.isOtpVerified == 0 {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
                        vc.userId = "\(loginResponce.loginData?.fldUserID ?? 0)"
                        vc.flage = "1"
                        vc.phoneNumber = "\(loginResponce.loginData?.fldUserPhone ?? "")"
                        vc.userType = "5"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            } else {
                
                Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
            }
            
        }
    }
}
