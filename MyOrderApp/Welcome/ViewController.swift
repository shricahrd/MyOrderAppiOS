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


class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    var viewTextBg: UIView!
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var forgotbutton: UIButton!
    var signin: UIButton!
    
    
    var catagaryLogin = String()
    
    var loginType = LoginType.DISTRIBUTOR
    
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var scrollViewMain: UIScrollView!
    var viewBG: UIView!
    var btnSignIn = UIButton()
    enum tags {
            static let username = 1
            static let password = 2
           
       }
override func viewDidLoad() {
    super.viewDidLoad()
    screenWidth = screenSize.width
    screenHeight = screenSize.height
   
    self.view.backgroundColor = UIColorforBackGroundColor
//    self.viewBg.layer.cornerRadius = 30
//    self.viewBg.clipsToBounds = true
//    self.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha:1.0)
//    self.viewBg.layer.borderWidth = 1.4;
//    self.viewBg.layer.borderColor = UIColor.gray.withAlphaComponent(0.1).cgColor
//    self.viewBg.layer.masksToBounds = false
//    self.viewBg.layer.shadowRadius = 3.0
//    self.viewBg.layer.shadowColor = UIColor.black.cgColor
//    self.viewBg.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//    self.viewBg.layer.shadowOpacity = 0.7
    
//    self.signin.layer.cornerRadius = 12;
    
    
    switch loginType {
   
    case .STOCKIST: break
        
    case .DISTRIBUTOR: break
        
    case .RETAILER: break
        
    case .SALESAGENT: break
        
    case .MANUFACTURER:break
        
   
    }
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
        viewBG.frame = CGRect(x: CGFloat(0), y:-60, width: CGFloat(screenWidth), height: screenHeight/2+80)
     } else {
        viewBG.frame = CGRect(x: CGFloat(0), y:-60, width: CGFloat(screenWidth), height: screenHeight/2+150)
     }
     viewBG.backgroundColor = UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0, alpha: 1.0)
     viewBG.layer.shadowColor = UIColor.black.cgColor
     viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
     viewBG.layer.masksToBounds = false
     viewBG.layer.shadowRadius = 1.0
     viewBG.layer.shadowOpacity = 0.5
     viewBG.cornerRadius = 30
     viewBG.clipsToBounds = true
     scrollViewMain.addSubview(viewBG)
    
     let imageLogo = UIImageView()
     imageLogo.frame = CGRect(x: screenWidth/2-30, y: 80, width:  60, height: 60)
     imageLogo.image = UIImage(named: "logoSignIn")
     imageLogo.contentMode =  .scaleAspectFit
     imageLogo.backgroundColor = .clear;
     imageLogo.clipsToBounds = true
     viewBG.addSubview(imageLogo)
                
     let welcomeTitle = UILabel()
     welcomeTitle.frame = CGRect(x: 16, y: imageLogo.frame.maxY + 8, width: screenWidth-32, height: 30);
     welcomeTitle.text = "Sign in";
     welcomeTitle.textColor = .white
     welcomeTitle.textAlignment = .center
     welcomeTitle.font = UIFont.boldSystemFont(ofSize: 26.0)
     viewBG.addSubview(welcomeTitle)
        
     viewTextBg = UIView()
     viewTextBg.frame = CGRect(x: CGFloat(0), y: viewBG.frame.height - 270, width: screenWidth, height: 270)
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
     fullnameTitle.frame = CGRect(x: 16, y: 5, width: screenWidth-50, height: 30);
     fullnameTitle.text = "Username ";
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
            
        let addressTitle = UILabel()
        addressTitle.frame = CGRect(x: 16, y: viewUnLine.frame.maxY+5, width: screenWidth-50, height: 30);
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
        passwordTextField.placeholder = "301, New Mumbai"
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
        btnSignIn.setTitle(" SignIn ", for: .normal)
        btnSignIn.setTitleColor(.white, for: .normal)
        btnSignIn.layer.borderWidth = 0
        btnSignIn.layer.cornerRadius = 22
        btnSignIn.clipsToBounds = true
        btnSignIn.backgroundColor = .red
        btnSignIn.addTarget(self,action:#selector(self.clickOnSignIn(_:)),for: UIControl.Event.touchUpInside)
        btnSignIn.isUserInteractionEnabled = true
        viewTextBg.addSubview(btnSignIn)
        
        scrollViewMain.keyboardDismissMode = .interactive
 }
    
    @objc func clickOnSignIn(_ sender: AnyObject!) {
        view.endEditing(true)
        
        print("userNameTextField.text!",userNameTextField.text! )
        print("passwordTextField.text!",passwordTextField.text! )
        if (userNameTextField.text==""||userNameTextField.text==" ") {
            self.showAlertView("Please enter Username.")
        } else if (passwordTextField.text==""||passwordTextField.text==" ") {
            self.showAlertView("Please enter your password.")
        } else {
          if catagaryLogin == "1"{  // MAnufacture
             manufatur(mobileNumber: userNameTextField.text! , password: passwordTextField.text!)
          } else if catagaryLogin == "2"{ // Dustabuter
//           self.callDistributorLoginApi()
             dustabuter(mobileNumber: userNameTextField.text!, password: passwordTextField.text!)
          } else if catagaryLogin == "3"{  // btnRetailer
             btnRetailer(mobileNumber: userNameTextField.text!, password: passwordTextField.text!)
          } else if catagaryLogin == "4"{ // btnStokist
             Stokist(mobileNumber: userNameTextField.text!, password: passwordTextField.text!)
          } else if catagaryLogin == "5" { // btnSalesAgent
             salesAgent(mobileNumber: userNameTextField.text!, password: passwordTextField.text!)
          } else {
            
          }
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
            scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 100), animated: true)
          } else if textField.isEqual(passwordTextField) {
            scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 150), animated: true)
          }
    }

    @IBAction func forgotButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordController") as! ForgotPasswordController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlertView(_ text:String) {
           let alertController = UIAlertController(title: "", message: text, preferredStyle:.alert)
           alertController.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
          }));
          self.present(alertController, animated: true, completion: nil)
     }

    func callDistributorLoginApi() {
        let json =  [
            "fld_user_password":passwordTextField.text!,
            "fld_user_phone": userNameTextField.text!
         ] as [String : Any]
        print("Detail json: ", json)
         postMyOrderAPIAction(WebService.distributor_login, parameters: json, showGenricErrorPopup: false) { (response) in
         print("response detail:", response ?? "")
         let message = response?["message"] as? String ?? ""
         if let status = response?.object(forKey: "status") as? Bool, status == true {
            DispatchQueue.main.async {
                let message = response?["message"] as? String ?? ""
                let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
                self.present(alert,animated:true, completion:nil)
                let delay = 2.0 * Double(NSEC_PER_SEC)
                let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                     self.dismiss(animated: true, completion: {
                     if let dictData = response?.object(forKey: "login_data") as? NSDictionary, dictData.count > 0 {
                        var strflduserid = ""
                        let dict_UserDetail:NSMutableDictionary! = NSMutableDictionary()
                        if let fld_user_id = dictData.value(forKey: "fld_user_id") as? Int {
                           strflduserid = "\(fld_user_id)"
                        }
                        if let fld_user_id = dictData.value(forKey: "fld_user_id") as? String {
                           strflduserid = "\(fld_user_id)"
                        }
                        dict_UserDetail.setValue("\(strflduserid)",forKey:"fld_user_id")
                        UserDefaults.standard.setValue(dict_UserDetail, forKey:"UserInfo");
                        UserDefaults.standard.synchronize();
                        UserDefaults.standard.setValue("\(strflduserid)", forKey:"fld_user_id");
                        UserDefaults.standard.synchronize();
                        if let userid = UserDefaults.standard.value(forKey: "fld_user_id") as? String {
                           print("userid", userid)
                        }
                        print(" getUserID()",  getUserID())
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: "Home") as? Home {
                          //vc.navigationController?.isNavigationBarHidden = true
                          //vc.navigationItem.hidesBackButton = true
                           self.navigationController?.show(vc,sender:self)
                        }
                   }
                });
              }
            }
          } else {
            DispatchQueue.main.async {
               Utility.showAlert(withMessage: message, onController: self)
             }
           }
        }
    }
    
//    @IBAction func signin(_ sender: Any) {
//        if catagaryLogin == "1"{  // MAnufacture
//            manufatur(mobileNumber: userName.text ?? "", password: password.text ?? "")
//        } else if catagaryLogin == "2"{ // Dustabuter
//            dustabuter(mobileNumber: userName.text ?? "", password: password.text ?? "")
//        } else if catagaryLogin == "3"{  // btnRetailer
//            btnRetailer(mobileNumber: userName.text ?? "", password: password.text ?? "")
//        } else if catagaryLogin == "4"{ // btnStokist
//            Stokist(mobileNumber: userName.text ?? "", password: password.text ?? "")
//        } else if catagaryLogin == "5" { // btnSalesAgent
//            salesAgent(mobileNumber: userName.text ?? "", password: password.text ?? "")
//        } else {
//        }
//    }
}

// MAEK:- LOGIN API
extension ViewController {
    // Manufature
    func manufatur(mobileNumber:String,password:String){
        ApiClient.loder(roughter: APIRouter.loginManufacture(mobileNumber: mobileNumber, password: password)) { (loginResponce:LoginResponce) in
            print("\(loginResponce)")
            if loginResponce.status == true {
                var strflduserid = ""
                let dict_UserDetail:NSMutableDictionary! = NSMutableDictionary()
                if let fld_user_id = loginResponce.loginData?.fldUserID {
                   strflduserid = "\(fld_user_id)"
                }
                if let fld_user_id = loginResponce.loginData?.fldUserID as? String {
                    strflduserid = "\(fld_user_id)"
                }
                dict_UserDetail.setValue("\(strflduserid)",forKey:"fld_user_id")
                UserDefaults.standard.setValue(dict_UserDetail, forKey:"UserInfo");
                UserDefaults.standard.synchronize();
                UserDefaults.standard.setValue("\(strflduserid)", forKey:"fld_user_id");
                UserDefaults.standard.synchronize();
                if let userid = UserDefaults.standard.value(forKey: "fld_user_id") as? String {
                   print("userid", userid)
                }
                print(" getUserID()",  getUserID())
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
                var strflduserid = ""
                let dict_UserDetail:NSMutableDictionary! = NSMutableDictionary()
                if let fld_user_id = loginResponce.loginData?.fldUserID {
                   strflduserid = "\(fld_user_id)"
                }
                if let fld_user_id = loginResponce.loginData?.fldUserID as? String {
                    strflduserid = "\(fld_user_id)"
                }
                dict_UserDetail.setValue("\(strflduserid)",forKey:"fld_user_id")
                UserDefaults.standard.setValue(dict_UserDetail, forKey:"UserInfo");
                UserDefaults.standard.synchronize();
                UserDefaults.standard.setValue("\(strflduserid)", forKey:"fld_user_id");
                UserDefaults.standard.synchronize();
                if let userid = UserDefaults.standard.value(forKey: "fld_user_id") as? String {
                   print("userid", userid)
                }
                print(" getUserID()",  getUserID())
                if loginResponce.loginData?.isOtpVerified == 0 {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
                        vc.userId = "\(loginResponce.loginData?.fldUserID ?? 0)"
                        vc.flage = "1"
                        vc.phoneNumber = "\(loginResponce.loginData?.fldUserPhone ?? "")"
                        vc.userType = "2"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "Home") as? Home {
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
                var strflduserid = ""
                let dict_UserDetail:NSMutableDictionary! = NSMutableDictionary()
                if let fld_user_id = loginResponce.loginData?.fldUserID {
                   strflduserid = "\(fld_user_id)"
                }
                if let fld_user_id = loginResponce.loginData?.fldUserID as? String {
                    strflduserid = "\(fld_user_id)"
                }
                dict_UserDetail.setValue("\(strflduserid)",forKey:"fld_user_id")
                UserDefaults.standard.setValue(dict_UserDetail, forKey:"UserInfo");
                UserDefaults.standard.synchronize();
                UserDefaults.standard.setValue("\(strflduserid)", forKey:"fld_user_id");
                UserDefaults.standard.synchronize();
                if let userid = UserDefaults.standard.value(forKey: "fld_user_id") as? String {
                   print("userid", userid)
                }
                print(" getUserID()",  getUserID())
                if loginResponce.loginData?.isOtpVerified == 0 {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPController") as? VerifyOTPController {
                        vc.userId = "\(loginResponce.loginData?.fldUserID ?? 0)"
                        vc.flage = "1"
                        vc.phoneNumber = "\(loginResponce.loginData?.fldUserPhone ?? "")"
                        vc.userType = "3"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "Home") as? Home {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            } else {
                Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
            }
        }
    }
    
    //7405655808
    //1010
    func Stokist(mobileNumber:String,password:String){
        ApiClient.loder(roughter: APIRouter.loginstockfacture(mobileNumber: mobileNumber, password: password)) { (loginResponce:LoginResponce) in
            print("\(loginResponce)")
            if loginResponce.status == true {
                var strflduserid = ""
                let dict_UserDetail:NSMutableDictionary! = NSMutableDictionary()
                if let fld_user_id = loginResponce.loginData?.fldUserID {
                   strflduserid = "\(fld_user_id)"
                }
                if let fld_user_id = loginResponce.loginData?.fldUserID as? String {
                    strflduserid = "\(fld_user_id)"
                }
                dict_UserDetail.setValue("\(strflduserid)",forKey:"fld_user_id")
                UserDefaults.standard.setValue(dict_UserDetail, forKey:"UserInfo");
                UserDefaults.standard.synchronize();
                UserDefaults.standard.setValue("\(strflduserid)", forKey:"fld_user_id");
                UserDefaults.standard.synchronize();
                if let userid = UserDefaults.standard.value(forKey: "fld_user_id") as? String {
                   print("userid", userid)
                }
                print(" getUserID()",  getUserID())
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
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "Home") as? Home {
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
                var strflduserid = ""
                let dict_UserDetail:NSMutableDictionary! = NSMutableDictionary()
                if let fld_user_id = loginResponce.loginData?.fldUserID {
                   strflduserid = "\(fld_user_id)"
                }
                if let fld_user_id = loginResponce.loginData?.fldUserID as? String {
                    strflduserid = "\(fld_user_id)"
                }
                dict_UserDetail.setValue("\(strflduserid)",forKey:"fld_user_id")
                UserDefaults.standard.setValue(dict_UserDetail, forKey:"UserInfo");
                UserDefaults.standard.synchronize();
                UserDefaults.standard.setValue("\(strflduserid)", forKey:"fld_user_id");
                UserDefaults.standard.synchronize();
                if let userid = UserDefaults.standard.value(forKey: "fld_user_id") as? String {
                   print("userid", userid)
                }
                print(" getUserID()",  getUserID())
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
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyBoard.instantiateViewController(withIdentifier: "Home") as? Home {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            } else {
                Utility.showAlert(withMessage: loginResponce.message ?? "", onController: self)
            }
        }
    }
}
