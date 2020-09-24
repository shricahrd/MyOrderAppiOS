//  SignUpViewController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 07/07/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit
import SVProgressHUD



class Utility : NSObject {
let prefs = UserDefaults.standard

//static var assetArray = AssetList()

 @objc static func showAlert(withMessage : String, onController : UIViewController) {
    let alertController = UIAlertController(title: "MyOrder", message: withMessage, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    onController.present(alertController, animated: true, completion: nil)
 }
}

enum TypesOfRegistation {
    case ManuFactursReg
    case Distributor
    case Retailer
    case Stocker
    case RalesAgent
}

class SignUpViewController: UIViewController {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var userName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var mobile: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var unshow: UIButton!
    @IBOutlet var signup: UIButton!
    @IBOutlet var btnSignin: UIButton!
    var typesOfRegistation = TypesOfRegistation.ManuFactursReg
    var registatorViewModels: RegistationViewModels?
    
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
        
        self.signup.layer.cornerRadius = 12;
        
        setUp()
        
        /*
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterPlay") as! RegisterPlay
         self.navigationController?.pushViewController(vc, animated: true)
         */
        
        
    }
    
    
    func setUp(){
        registatorViewModels = RegistationViewModels.init(name: "", email: "", password: "", contact_number: "")
    }
    
    
    @IBAction func unshow(_ sender: Any) {
        
    }
    
    private func updateCommand() {
        self.registatorViewModels?.name = self.userName.text ?? ""  //self.textFieldEmail.text?.trimmingCharacters(in: .whitespaces)
        self.registatorViewModels?.email = self.email.text ?? ""  //self.textFieldPassword.text
        self.registatorViewModels?.password = self.password.text ?? ""  //"customer"
        self.registatorViewModels?.contact_number =  self.mobile.text ?? "" //"EMAIL"
        
    }
    
    
    
    
    @IBAction func signup(_ sender: Any) {
        
        
        switch typesOfRegistation {
        case .ManuFactursReg:
            
            updateCommand()
            self.registatorViewModels?.validate(completion: { (isValid, message) in
                
                if(isValid){
                    guard self.registatorViewModels != nil else{
                        return
                    }
                    
                    self.manufactureRegister(name:self.userName.text ?? "" , email: self.email.text ?? "", password: self.password.text ?? "", contactNumbar: self.mobile.text ?? "", devigeId: "shgjhsfghfsg")
                    // self.performLogin(loginCommand: loginCommand)
                }else{
                    Utility.showAlert(withMessage: message!, onController: self)
                }
                
            })
        case.Distributor:
            
            updateCommand()
            self.registatorViewModels?.validate(completion: { (isValid, message) in
                
                if(isValid){
                    guard self.registatorViewModels != nil else{
                        return
                    }
                    
                    self.distributorRegister(name:self.userName.text ?? "" , email: self.email.text ?? "", password: self.password.text ?? "", contactNumbar: self.mobile.text ?? "", devigeId: "shgjhsfghfsg")
                    // self.performLogin(loginCommand: loginCommand)
                }else{
                    Utility.showAlert(withMessage: message!, onController: self)
                }
                
            })
            
            
            
        case.RalesAgent:
            
            updateCommand()
            self.registatorViewModels?.validate(completion: { (isValid, message) in
                
                if(isValid){
                    guard self.registatorViewModels != nil else{
                        return
                    }
                    
                    self.retailerRegister(name:self.userName.text ?? "" , email: self.email.text ?? "", password: self.password.text ?? "", contactNumbar: self.mobile.text ?? "", devigeId: "shgjhsfghfsg")
                    // self.performLogin(loginCommand: loginCommand)
                }else{
                    Utility.showAlert(withMessage: message!, onController: self)
                }
                
            })
            
            
            
            
            
        case.Stocker:
            
            
            updateCommand()
            self.registatorViewModels?.validate(completion: { (isValid, message) in
                
                if(isValid){
                    guard self.registatorViewModels != nil else{
                        return
                    }
                    
                    self.stockistRegister(name:self.userName.text ?? "" , email: self.email.text ?? "", password: self.password.text ?? "", contactNumbar: self.mobile.text ?? "", devigeId: "shgjhsfghfsg")
                    // self.performLogin(loginCommand: loginCommand)
                }else{
                    Utility.showAlert(withMessage: message!, onController: self)
                }
                
            })
            
            
            
        case .Retailer:
            
            updateCommand()
            self.registatorViewModels?.validate(completion: { (isValid, message) in
                
                if(isValid){
                    guard self.registatorViewModels != nil else{
                        return
                    }
                    
                    self.salesagentRegister(name:self.userName.text ?? "" , email: self.email.text ?? "", password: self.password.text ?? "", contactNumbar: self.mobile.text ?? "", devigeId: "shgjhsfghfsg")
                    // self.performLogin(loginCommand: loginCommand)
                }else{
                    Utility.showAlert(withMessage: message!, onController: self)
                }
                
            })
            
        }
        
        
        
        
        
        
        
        
        
        
        
        //            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //            if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
        //                self.navigationController?.pushViewController(vc, animated: true)
        //            }
    }
    @IBAction func signin(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}


extension SignUpViewController {
    
    
    func manufactureRegister(name:String,email:String,password:String,contactNumbar:String,devigeId:String){
        
        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.manufactureRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
            SVProgressHUD.dismiss()
            let manufacture = manufactureRegister.statusCode
            if manufacture == 201 {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                print("RegisterSuccess")
            }else {
                Utility.showAlert(withMessage: manufactureRegister.message ?? "", onController: self)
                print("Failuer")
            }
        }
        
    }
}

//MARK:- stockistRegister
extension SignUpViewController {
    
    
    func stockistRegister(name:String,email:String,password:String,contactNumbar:String,devigeId:String){
        
        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.stockistRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
            
            SVProgressHUD.dismiss()
            
            let manufacture = manufactureRegister.statusCode
            if manufacture == 201 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                print("RegisterSuccess")
            }else {
                
                Utility.showAlert(withMessage: manufactureRegister.message ?? "", onController: self)
                
                print("Failuer")
                
                
            }
        }
        
    }
}

//MARK:- distributorRegister
extension SignUpViewController {
    
    
    func distributorRegister(name:String,email:String,password:String,contactNumbar:String,devigeId:String){
        
        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.distributorRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
            let manufacture = manufactureRegister.statusCode
            if manufacture == 201 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }else {
                Utility.showAlert(withMessage: manufactureRegister.message ?? "", onController: self)
                print("Failuer")
                
                
            }
        }
    }
}

//MARK:- retailerRegister
extension SignUpViewController {
    
    
    func retailerRegister(name:String,email:String,password:String,contactNumbar:String,devigeId:String){
        
        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.retailerRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
            
            SVProgressHUD.dismiss()
            let manufacture = manufactureRegister.statusCode
            
            
            if manufacture == 201 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }else {
                
                Utility.showAlert(withMessage: manufactureRegister.message ?? "", onController: self)
                
                print("Failuer")
                
                
            }
        }
        
    }
}

//MARK:- retailerRegister
extension SignUpViewController {
    
    
    func salesagentRegister(name:String,email:String,password:String,contactNumbar:String,devigeId:String){
        
        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.salesagentRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
            SVProgressHUD.dismiss()
            let manufacture = manufactureRegister.status
            
            
            if manufacture == true {
                
                
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }else {
                
                Utility.showAlert(withMessage: manufactureRegister.message ?? "", onController: self)
                
                print("Failuer")
                
                
            }
        }
        
    }
}

