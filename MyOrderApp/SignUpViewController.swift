//  SignUpViewController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 07/07/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit
import SVProgressHUD
import Firebase


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

class SignUpViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {

    var typesOfRegistation = TypesOfRegistation.ManuFactursReg
    var registatorViewModels: RegistationViewModels?
    var scrollViewMain = UIScrollView()
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0

    var viewBG: UIView!
    var btnSignIn = UIButton()
    
    var viewTextBg: UIView!
    var userNameTextField: UITextField!
    var emailTextField: UITextField!
    var mobileTextField: UITextField!
    var passwordTextField: UITextField!
    
    var forgotbutton: UIButton!
    var signin: UIButton!
    var viewBottomBG: UIView!
    var selectLoginType = ""
    var btnAlreadyHaveAccount: UIButton!
 
    enum tags {
         static let username = 1
         static let email = 2
         static let mobile = 3
         static let password = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        self.view.backgroundColor = UIColorforBackGroundColor
        setUp()
        FirebaseApp.configure()
        self.uiSetUp()
    }
    
    func uiSetUp() {
        scrollViewMain = UIScrollView()
        scrollViewMain.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        scrollViewMain.bounces = true
        scrollViewMain.delegate = self
        scrollViewMain.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        view.addSubview(scrollViewMain)

        viewBG = UIView()
        if screenHeight == 896.0 {
           viewBG.frame = CGRect(x: CGFloat(0), y:-60, width: CGFloat(screenWidth), height: screenHeight-200)
        } else {
           viewBG.frame = CGRect(x: CGFloat(0), y:-60, width: CGFloat(screenWidth), height: screenHeight-80)
        }
        viewBG.backgroundColor = UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0, alpha: 1.0)
        viewBG.layer.shadowColor = UIColor.black.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 12.0)
        viewBG.layer.masksToBounds = false
        viewBG.layer.shadowRadius = 12.0
        viewBG.layer.shadowOpacity = 0.5
        scrollViewMain.addSubview(viewBG)
        
        viewBG.layer.cornerRadius = 30
         
        let imageLogo = UIImageView()
        imageLogo.frame = CGRect(x: screenWidth/2-22, y: 80, width:  45, height: 45)
        imageLogo.image = UIImage(named: "menuBag")
        imageLogo.contentMode =  .scaleAspectFit
        imageLogo.backgroundColor = .clear;
        imageLogo.clipsToBounds = true
        viewBG.addSubview(imageLogo)
                     
        let welcomeTitle = UILabel()
        welcomeTitle.frame = CGRect(x: 16, y: imageLogo.frame.maxY + 8, width: screenWidth-32, height: 30);
        welcomeTitle.text = "Sign Up";
        welcomeTitle.textColor = .white
        welcomeTitle.textAlignment = .center
        welcomeTitle.font = UIFont.boldSystemFont(ofSize: 26.0)
        viewBG.addSubview(welcomeTitle)
           
        viewTextBg = UIView()
        viewTextBg.frame = CGRect(x: CGFloat(0), y: welcomeTitle.frame.maxY + 20, width: screenWidth, height: screenHeight-(welcomeTitle.frame.maxY + 100))
        viewTextBg.backgroundColor = .white
        viewTextBg.layer.shadowColor = UIColor.black.cgColor
        viewTextBg.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        viewTextBg.layer.masksToBounds = false
        viewTextBg.layer.shadowRadius = 3.0
        viewTextBg.layer.shadowOpacity = 0.5
        viewTextBg.cornerRadius = 30
        viewTextBg.clipsToBounds = true
        viewBG.addSubview(viewTextBg)
           
        let fullnameTitle = UILabel()
        fullnameTitle.frame = CGRect(x: 16, y: 10, width: screenWidth-50, height: 30);
        fullnameTitle.text = "UserName ";
        fullnameTitle.font = UIFont.boldSystemFont(ofSize: 12)
        viewTextBg.addSubview(fullnameTitle)
               
        userNameTextField = UITextField()
        userNameTextField.frame = CGRect(x: 16, y: fullnameTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
        userNameTextField.delegate = self
        userNameTextField.tag = tags.username
        viewTextBg.addSubview(userNameTextField)
               
        let paddingView_CurrentPwd:UIView=UIView()
        paddingView_CurrentPwd.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
        userNameTextField.delegate = self
        userNameTextField.textColor = UIColor.black
        userNameTextField.leftView = paddingView_CurrentPwd
        userNameTextField.placeholder = "RK Kumar"
        userNameTextField.tintColor = UIColor.black;
        userNameTextField.font = UIFont(name:"Arial",size:12.0)
        userNameTextField.backgroundColor = .clear
        userNameTextField.isSecureTextEntry = false
        userNameTextField.leftViewMode = .always
        userNameTextField.rightViewMode = .always
        userNameTextField.tag = 100
        userNameTextField.returnKeyType = .next
        userNameTextField.keyboardType = UIKeyboardType.asciiCapable
               
        let viewUnLine = UIView()
        viewUnLine.frame = CGRect(x: 16, y: self.userNameTextField.frame.maxY+1, width: screenWidth-32, height: 1.5);
        viewUnLine.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
        viewTextBg.addSubview(viewUnLine)
        
        let emailTitle = UILabel()
        emailTitle.frame = CGRect(x: 16, y: viewUnLine.frame.maxY+5, width: screenWidth-50, height: 30);
        emailTitle.text = "Email ";
        emailTitle.font = UIFont.boldSystemFont(ofSize: 12)
        viewTextBg.addSubview(emailTitle)
        
        emailTextField = UITextField()
        emailTextField.frame = CGRect(x: 16, y: emailTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
        emailTextField.delegate = self
        emailTextField.tag = tags.email
        viewTextBg.addSubview(emailTextField)
               
        let paddingView_email:UIView=UIView()
        paddingView_email.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
        emailTextField.delegate = self
        emailTextField.textColor = UIColor.black
        emailTextField.leftView = paddingView_email
        emailTextField.placeholder = "abcd@gmail.com"
        emailTextField.tintColor = UIColor.black;
        emailTextField.font = UIFont(name:"Arial",size:12.0)
        emailTextField.backgroundColor = .clear
        emailTextField.isSecureTextEntry = false
        emailTextField.leftViewMode = .always
        emailTextField.rightViewMode = .always
        emailTextField.tag = 100
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = UIKeyboardType.asciiCapable
               
        let viewUnLineEmail = UIView()
        viewUnLineEmail.frame = CGRect(x: 16, y: self.emailTextField.frame.maxY+1, width: screenWidth-32, height: 1.5);
        viewUnLineEmail.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
        viewTextBg.addSubview(viewUnLineEmail)
        
        let mobileTitle = UILabel()
        mobileTitle.frame = CGRect(x: 16, y: viewUnLineEmail.frame.maxY+5, width: screenWidth-50, height: 30);
        mobileTitle.text = "Mobile ";
        mobileTitle.textColor = .darkText
        mobileTitle.font = UIFont.boldSystemFont(ofSize: 12)
        viewTextBg.addSubview(mobileTitle)
        
        mobileTextField = UITextField()
        mobileTextField.frame = CGRect(x: 16, y: mobileTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
        mobileTextField.delegate = self
        mobileTextField.tag = tags.mobile
        viewTextBg.addSubview(mobileTextField)
               
        let paddingView_mobile:UIView=UIView()
        paddingView_mobile.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
        mobileTextField.delegate = self
        mobileTextField.textColor = UIColor.black
        mobileTextField.leftView = paddingView_mobile
        mobileTextField.placeholder = "9188888889"
        mobileTextField.tintColor = UIColor.black;
        mobileTextField.font = UIFont(name:"Arial",size:12.0)
        mobileTextField.backgroundColor = .clear
        mobileTextField.isSecureTextEntry = false
        mobileTextField.leftViewMode = .always
        mobileTextField.rightViewMode = .always
        mobileTextField.tag = 100
        mobileTextField.returnKeyType = .next
        mobileTextField.keyboardType = UIKeyboardType.asciiCapableNumberPad
               
        let viewUnLineMobile = UIView()
        viewUnLineMobile.frame = CGRect(x: 16, y: self.mobileTextField.frame.maxY+1, width: screenWidth-32, height: 1.5);
        viewUnLineMobile.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
        viewTextBg.addSubview(viewUnLineMobile)

        let addressTitle = UILabel()
        addressTitle.frame = CGRect(x: 16, y: viewUnLineMobile.frame.maxY+5, width: screenWidth-50, height: 30);
        addressTitle.text = "Password ";
        addressTitle.textColor = .darkText
        addressTitle.font = UIFont.boldSystemFont(ofSize: 12)
        viewTextBg.addSubview(addressTitle)

        let paddingViewAddress: UIView = UIView()
        paddingViewAddress.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
        passwordTextField = UITextField()
        passwordTextField.frame = CGRect(x: 16, y: addressTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
        passwordTextField.delegate = self
        passwordTextField.tag = tags.password
        passwordTextField.textColor = UIColor.black
        passwordTextField.leftView = paddingViewAddress
        passwordTextField.placeholder = "******"
        passwordTextField.tintColor = UIColor.black;
        passwordTextField.font = UIFont(name:"Arial",size:12.0)
        passwordTextField.backgroundColor = .clear
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftViewMode = .always
        passwordTextField.rightViewMode = .always
        passwordTextField.returnKeyType = .next
        passwordTextField.keyboardType = UIKeyboardType.asciiCapable
        viewTextBg.addSubview(passwordTextField)

        let viewUnLine1 = UIView()
        viewUnLine1.frame = CGRect(x: 16, y: self.passwordTextField.frame.maxY+1, width: screenWidth-32, height: 1.5);
        viewUnLine1.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
        viewTextBg.addSubview(viewUnLine1)
           
        btnSignIn = UIButton()
        btnSignIn.frame = CGRect(x: 26, y: viewUnLine1.frame.maxY+50, width: viewTextBg.frame.size.width - 52, height: 45)
        btnSignIn.backgroundColor = .clear
        btnSignIn.setTitle(" SIGN UP ", for: .normal)
        btnSignIn.setTitleColor(.white, for: .normal)
        btnSignIn.layer.borderWidth = 0
        btnSignIn.layer.cornerRadius = 22
        btnSignIn.clipsToBounds = true
        btnSignIn.backgroundColor = .red
        btnSignIn.addTarget(self,action:#selector(self.clickOnSignIn(_:)),for: UIControl.Event.touchUpInside)
        btnSignIn.isUserInteractionEnabled = true
        viewTextBg.addSubview(btnSignIn)
        scrollViewMain.keyboardDismissMode = .interactive
        
        let eyeButton = UIButton()
        eyeButton.frame = CGRect(x: passwordTextField.frame.maxX - 40, y: addressTitle.frame.maxY+2, width: 30, height: 30)
        eyeButton.backgroundColor = .clear
        if let img = UIImage(named: "grayEyeCut") {
           eyeButton.setImage(img, for: .normal)
        }
        eyeButton.addTarget(self,action:#selector(self.toggleBtn(_:)),for: UIControl.Event.touchUpInside)
        viewTextBg.addSubview(eyeButton)
        
        viewBottomBG = UIView()
        viewBottomBG.frame = CGRect(x:screenWidth/2-80, y: viewBG.frame.maxY + 30, width: CGFloat(160), height: 50)
        viewBottomBG.backgroundColor = .clear
        scrollViewMain.addSubview(viewBottomBG)
        
        btnAlreadyHaveAccount = UIButton()
        btnAlreadyHaveAccount.frame = CGRect(x: 3, y: 0, width: viewBottomBG.frame.size.width - 42, height: 50)
        btnAlreadyHaveAccount.backgroundColor = .clear
        btnAlreadyHaveAccount.setTitle("Already have an Account?", for: .normal)
        btnAlreadyHaveAccount.setTitleColor(.black, for: .normal)
        btnAlreadyHaveAccount.titleLabel?.font = UIFont(name:"Arial",size:10.0)
        btnAlreadyHaveAccount.titleLabel?.textAlignment = .left
        btnAlreadyHaveAccount.isMultipleTouchEnabled = true
        btnAlreadyHaveAccount.addTarget(self,action:#selector(self.clickAlreadyHaveAccount(_:)),for: UIControl.Event.touchUpInside)
        btnAlreadyHaveAccount.isUserInteractionEnabled = true
        viewBottomBG.addSubview(btnAlreadyHaveAccount)
        
        signin = UIButton()
        signin.frame = CGRect(x: btnAlreadyHaveAccount.frame.maxX+1, y: 0, width: viewBottomBG.frame.size.width - (btnAlreadyHaveAccount.frame.maxX+1), height: 50)
        signin.backgroundColor = .clear
        signin.setTitle("Sign In", for: .normal)
        signin.setTitleColor(.red, for: .normal)
        signin.isMultipleTouchEnabled = true
        signin.titleLabel?.font = UIFont(name:"Arial",size:10.0)
        signin.titleLabel?.textAlignment = .left
        signin.addTarget(self,action:#selector(self.btnSignIn(_:)),for: UIControl.Event.touchUpInside)
        signin.isUserInteractionEnabled = true
        viewBottomBG.addSubview(signin)
        
        self.scrollViewMain.contentSize = CGSize(width: 0, height: viewBottomBG.frame.maxY + 400)
    }
    
    @objc func clickAlreadyHaveAccount(_ sender: AnyObject!) {
           
    }
    
    @objc func btnSignIn(_ sender: AnyObject!) {
        let dict = [
            "name":"ram",
            "email":"ram@ram.com",
            "password":"123456",
            "contact_number":8010490862,
            "fld_device_id":"nnnnnbbbb"
        ] as [String : Any]
        
    }
    
    //MARK: toggleBtn Action
    @objc func toggleBtn(_ sender: UIButton!) {
        if sender.isSelected == true {
           sender.isSelected = false
           if let img = UIImage(named: "grayEyeCut") {
              sender.setImage(img, for: .normal);
           }
           passwordTextField.isSecureTextEntry = true
        } else {
            sender.isSelected = true
            passwordTextField.isSecureTextEntry = false
            if let img = UIImage(named: "greyEye") {
               sender.setImage(img, for: .normal);
            }
        }
    }
    
    @objc func clickOnSignIn(_ sender: AnyObject!) {
        self.view.endEditing(true)

          switch typesOfRegistation {
          case .ManuFactursReg:
              updateCommand()
              self.registatorViewModels?.validate(completion: { (isValid, message) in
              if(isValid){
                  guard self.registatorViewModels != nil else{
                     return
                  }
                  self.manufactureRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
                  } else {
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
                      
                      self.distributorRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
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
                      self.retailerRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
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
                      self.stockistRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
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
                      self.salesagentRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
                      // self.performLogin(loginCommand: loginCommand)
                  }else{
                      Utility.showAlert(withMessage: message!, onController: self)
                  }
                  
              })
              
          }
      }
    
    func setUp(){
        registatorViewModels = RegistationViewModels.init(name: "", email: "", password: "", contact_number: "")
    }
    
    
    @IBAction func unshow(_ sender: Any) {
        
    }
    
    private func updateCommand() {
        self.registatorViewModels?.name = self.userNameTextField.text ?? ""  //self.textFieldEmail.text?.trimmingCharacters(in: .whitespaces)
        self.registatorViewModels?.email = self.emailTextField.text ?? ""  //self.textFieldPassword.text
        self.registatorViewModels?.password = self.passwordTextField.text ?? ""  //"customer"
        self.registatorViewModels?.contact_number =  self.mobileTextField.text ?? "" //"EMAIL"
        
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
                self.manufactureRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
                } else {
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
                    self.distributorRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
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
                    self.retailerRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
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
                    self.stockistRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
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
                    self.salesagentRegister(name:self.userNameTextField.text ?? "" , email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", contactNumbar: self.mobileTextField.text ?? "", devigeId: "shgjhsfghfsg")
                    // self.performLogin(loginCommand: loginCommand)
                }else{
                    Utility.showAlert(withMessage: message!, onController: self)
                }
                
            })
            
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         view.endEditing(true)
         scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 0), animated: true)
         return true
     }
         
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         return true
    }
         
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         return true
    }
         
    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField.isEqual(userNameTextField) {
           scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 80), animated: true)
         } else if textField.isEqual(emailTextField) {
           scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 90), animated: true)
         } else if textField.isEqual(mobileTextField) {
           scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 110), animated: true)
         } else if textField.isEqual(passwordTextField) {
           scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 120), animated: true)
         }
    }
    
    func showAlertView(_ text:String) {
           let alertController = UIAlertController(title: "", message: text, preferredStyle:.alert)
           alertController.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
          }));
          self.present(alertController, animated: true, completion: nil)
     }

    @IBAction func signin(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "SignupTermsCController") as? SignupTermsCController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}


extension SignUpViewController {
    func manufactureRegister(name:String,email:String,password:String,contactNumbar:String,devigeId:String) {
//      SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.manufactureRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
//          SVProgressHUD.dismiss()
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
        
//        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.stockistRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
            
//            SVProgressHUD.dismiss()
            
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
        
//        SVProgressHUD.show()
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
        
//        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.retailerRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
            
//            SVProgressHUD.dismiss()
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
        
//        SVProgressHUD.show()
        ApiClient.loder(roughter: APIRouter.salesagentRegister(name: name, email: email, password: password, contactNumber: contactNumbar, devigeId: devigeId)) { (manufactureRegister:RegistationResponce) in
            print("\(manufactureRegister)")
//            SVProgressHUD.dismiss()
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

