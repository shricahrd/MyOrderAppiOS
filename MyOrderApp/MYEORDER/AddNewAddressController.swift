//  AddNewAddressController.swift
//  MyOrderApp
//  Created by Apple on 9/8/20.
//  Copyright © 2020 rakesh. All rights reserved.


import UIKit

class AddNewAddressController: UIViewController,  UIScrollViewDelegate, UITextFieldDelegate {
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var scrollViewMain = UIScrollView()
    var viewBottomBg = UIView()
    var btnSave = UIButton()
    var fullnameTitle:UILabel!
    var addressTitle:UILabel!
    var cityTitle:UILabel!
    var stateTitle:UILabel!
    var countryTitle:UILabel!
    var zipcodeTitle:UILabel!
    var fullNameTextField: UITextField!
    var addressTextField: UITextField!
    var cityTextField: UITextField!
    var stateTextField: UITextField!
    var countryTextField: UITextField!
    var zipcodeTextField: UITextField!
    var addressid = ""
   
    var arraycity = NSMutableArray()
    var arraystate = NSMutableArray()
    var arraycountry = NSMutableArray()

    var dictData = NSMutableDictionary()
    enum ScreenMode {
           static let addnewaddress = 1
           static let editnewaddress = 2
    }
    var screenMode = 0
    enum tags {
         static let fname = 1
         static let address = 2
         static let city = 3
         static let state = 4
         static let country = 5
         static let zipcode = 6
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        print("addressid:", addressid)
        callUISetUpHeader()
        self.uiSetUpScrollView()
        self.bottomviewBG()
//      self.callGetSateApi()
        
        if self.screenMode == ScreenMode.addnewaddress {
            
        } else if self.screenMode == ScreenMode.editnewaddress {
            
        }
        
    }
    
    func callUISetUpHeader() {
         let viewHeaderBg = UIView()
                      viewHeaderBg.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 75);
                      viewHeaderBg.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                      viewHeaderBg.layer.shadowColor = UIColor.black.cgColor
                      viewHeaderBg.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
                      viewHeaderBg.layer.masksToBounds = false
                      viewHeaderBg.layer.shadowRadius = 2.0
                      viewHeaderBg.layer.shadowOpacity = 0.5
                      self.view.addSubview(viewHeaderBg)
                      
                      let btnBack = UIButton()
                      btnBack.frame = CGRect(x:16, y: 40, width: 20, height: 20)
                      btnBack.backgroundColor = .clear
                      btnBack.setImage(UIImage(named: "backArrow"), for: .normal)
                      btnBack.addTarget(self,action:#selector(self.clickOnBack(_:)),for: UIControl.Event.touchUpInside)
                      btnBack.isUserInteractionEnabled = true
                      viewHeaderBg.addSubview(btnBack)
                      
                      let imageLogo = UIImageView()
                      imageLogo.frame = CGRect(x:80, y: 30, width:  screenWidth-160, height: 40)
                      imageLogo.image = UIImage(named: "logo")
                      imageLogo.contentMode =  .center
                      imageLogo.clipsToBounds = true
                      viewHeaderBg.addSubview(imageLogo)
                      
                      let btnCart = UIButton()
                      btnCart.frame = CGRect(x:screenWidth-50, y: 40, width:  25, height: 25)
                      btnCart.backgroundColor = .clear
                      btnCart.setImage(UIImage(named: "cartLogo"), for: .normal)
                      btnCart.addTarget(self,action:#selector(self.clickOnCart(_:)),for: UIControl.Event.touchUpInside)
                      btnCart.isUserInteractionEnabled = true
                      //viewHeaderBg.addSubview(btnCart)
               
                      let viewUnLine = UIView()
                      viewUnLine.frame = CGRect(x: 0, y: 75.0, width: screenWidth, height: 1.5);
                      viewUnLine.backgroundColor = UIColor(red: 215.0 / 255.0, green: 215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
                      viewUnLine.layer.shadowColor = UIColor.black.cgColor
                      viewUnLine.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                      viewUnLine.layer.masksToBounds = false
                      viewUnLine.layer.shadowRadius = 1.0
                      viewUnLine.layer.shadowOpacity = 0.5
                      viewHeaderBg.addSubview(viewUnLine)
     }
    
    func uiSetUpScrollView() {
        scrollViewMain.frame = CGRect(x: 0, y: 75, width: screenWidth, height: screenHeight-75);
        scrollViewMain.bounces = true
        scrollViewMain.delegate = self
        scrollViewMain.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        view.addSubview(scrollViewMain)
            
        let newaddressTitle = UILabel()
        newaddressTitle.frame = CGRect(x: 16, y: 10, width: screenWidth-50, height: 30);
       
        if self.screenMode == ScreenMode.addnewaddress {
             newaddressTitle.text = "Add New Address ";
        } else if self.screenMode == ScreenMode.editnewaddress {
             newaddressTitle.text = "Update Your Address ";
        }
        newaddressTitle.textColor = .black
        newaddressTitle.font = UIFont.boldSystemFont(ofSize: 16)
        scrollViewMain.addSubview(newaddressTitle)
            
        let fullnameTitle = UILabel()
        fullnameTitle.frame = CGRect(x: 16, y: newaddressTitle.frame.maxY+5, width: screenWidth-50, height: 30);
        fullnameTitle.text = "Full name ";
        fullnameTitle.font = UIFont.boldSystemFont(ofSize: 12)
        scrollViewMain.addSubview(fullnameTitle)
            
        fullNameTextField = UITextField()
        fullNameTextField.frame = CGRect(x: 16, y: fullnameTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
        fullNameTextField.delegate = self
        fullNameTextField.tag = tags.fname
        scrollViewMain.addSubview(fullNameTextField)
            
        let paddingView_CurrentPwd:UIView=UIView()
        paddingView_CurrentPwd.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
        fullNameTextField.delegate = self
        fullNameTextField.textColor = UIColor.black
        fullNameTextField.leftView = paddingView_CurrentPwd
        fullNameTextField.placeholder = "RK Kumar"
        fullNameTextField.tintColor = UIColor.black;
        fullNameTextField.font = UIFont(name:"Arial",size:12.0)
        fullNameTextField.backgroundColor = .clear
        fullNameTextField.isSecureTextEntry = false
        fullNameTextField.leftViewMode = .always
        fullNameTextField.rightViewMode = .always
        fullNameTextField.tag = 100
        fullNameTextField.returnKeyType = .next
        fullNameTextField.keyboardType = UIKeyboardType.asciiCapable
            
        let viewUnLine = UIView()
        viewUnLine.frame = CGRect(x: 16, y: self.fullNameTextField.frame.maxY+1, width: screenWidth-32, height: 1.5);
        viewUnLine.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
        scrollViewMain.addSubview(viewUnLine)
            
        let addressTitle = UILabel()
        addressTitle.frame = CGRect(x: 16, y: viewUnLine.frame.maxY+5, width: screenWidth-50, height: 30);
        addressTitle.text = "Address ";
        addressTitle.textColor = .darkText
        addressTitle.font = UIFont.boldSystemFont(ofSize: 12)
        scrollViewMain.addSubview(addressTitle)

        let paddingViewAddress:UIView=UIView()
        paddingViewAddress.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
        addressTextField = UITextField()
         addressTextField.frame = CGRect(x: 16, y: addressTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
         addressTextField.delegate = self
         addressTextField.tag = tags.address
         addressTextField.textColor = UIColor.black
         addressTextField.leftView = paddingViewAddress
         addressTextField.placeholder = "301, New Mumbai"
         addressTextField.tintColor = UIColor.black;
         addressTextField.font = UIFont(name:"Arial",size:12.0)
         addressTextField.backgroundColor = .clear
         addressTextField.isSecureTextEntry = false
         addressTextField.leftViewMode = .always
         addressTextField.rightViewMode = .always
         addressTextField.returnKeyType = .next
         addressTextField.keyboardType = UIKeyboardType.asciiCapable
         scrollViewMain.addSubview(addressTextField)

         let viewUnLine1 = UIView()
         viewUnLine1.frame = CGRect(x: 16, y: self.addressTextField.frame.maxY+5, width: screenWidth-32, height: 1.5);
         viewUnLine1.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewUnLine1)
        
        cityTitle = UILabel()
        cityTitle.frame = CGRect(x: 16, y: viewUnLine1.frame.maxY+5, width: screenWidth-50, height: 30);
        cityTitle.text = "City ";
        cityTitle.textColor = .darkText
        cityTitle.font = UIFont.boldSystemFont(ofSize: 12)
        scrollViewMain.addSubview(cityTitle)

         let paddingViewCity:UIView=UIView()
         paddingViewAddress.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
         cityTextField = UITextField()
         cityTextField.frame = CGRect(x: 16, y: cityTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
         cityTextField.delegate = self
         cityTextField.tag = tags.city
         cityTextField.textColor = UIColor.black
         cityTextField.leftView = paddingViewCity
         cityTextField.placeholder = "East Mumbai"
         cityTextField.tintColor = UIColor.black;
         cityTextField.font = UIFont(name:"Arial",size:12.0)
         cityTextField.backgroundColor = .clear
         cityTextField.isSecureTextEntry = false
         cityTextField.leftViewMode = .always
         cityTextField.rightViewMode = .always
         cityTextField.returnKeyType = .next
         cityTextField.keyboardType = UIKeyboardType.asciiCapable
         scrollViewMain.addSubview(cityTextField)

         let viewUnLine2 = UIView()
         viewUnLine2.frame = CGRect(x: 16, y: self.cityTextField.frame.maxY+5, width: screenWidth-32, height: 1.5);
         viewUnLine2.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewUnLine2)
        
         stateTitle = UILabel()
         stateTitle.frame = CGRect(x: 16, y: viewUnLine2.frame.maxY+5, width: screenWidth-50, height: 30);
         stateTitle.text = "State/Province/Region ";
         stateTitle.textColor = .darkText
         stateTitle.font = UIFont.boldSystemFont(ofSize: 12)
         scrollViewMain.addSubview(stateTitle)

          let paddingViewState:UIView=UIView()
          paddingViewState.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
          stateTextField = UITextField()
          stateTextField.frame = CGRect(x: 16, y: stateTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
          stateTextField.delegate = self
          stateTextField.tag = tags.state
          stateTextField.textColor = UIColor.black
          stateTextField.leftView = paddingViewState
          stateTextField.placeholder = "East Mumbai"
          stateTextField.tintColor = UIColor.black;
          stateTextField.font = UIFont(name:"Arial",size:12.0)
          stateTextField.backgroundColor = .clear
          stateTextField.isSecureTextEntry = false
          stateTextField.leftViewMode = .always
          stateTextField.rightViewMode = .always
          stateTextField.returnKeyType = .next
          stateTextField.keyboardType = UIKeyboardType.asciiCapable
          scrollViewMain.addSubview(stateTextField)

          let viewUnLine3 = UIView()
          viewUnLine3.frame = CGRect(x: 16, y: self.stateTextField.frame.maxY+5, width: screenWidth-32, height: 1.5);
          viewUnLine3.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
          scrollViewMain.addSubview(viewUnLine3)
        
        self.countryTitle = UILabel()
        self.countryTitle.frame = CGRect(x: 16, y: viewUnLine3.frame.maxY+5, width: screenWidth-50, height: 30);
        self.countryTitle.text = "Country ";
        self.countryTitle.textColor = .darkText
        self.countryTitle.font = UIFont.boldSystemFont(ofSize: 12)
        self.scrollViewMain.addSubview(countryTitle)

         let paddingViewCountry:UIView=UIView()
         paddingViewCountry.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
         
         self.countryTextField = UITextField()
         self.countryTextField.frame = CGRect(x: 16, y: countryTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
         self.countryTextField.delegate = self
         self.countryTextField.tag = tags.country
         self.countryTextField.textColor = UIColor.black
         self.countryTextField.leftView = paddingViewCountry
         self.countryTextField.placeholder = "India"
         self.countryTextField.tintColor = UIColor.black;
         self.countryTextField.font = UIFont(name:"Arial",size:12.0)
         self.countryTextField.backgroundColor = .clear
         self.countryTextField.isSecureTextEntry = false
         self.countryTextField.leftViewMode = .always
         self.countryTextField.rightViewMode = .always
         self.countryTextField.returnKeyType = .next
         self.countryTextField.keyboardType = UIKeyboardType.asciiCapable
         scrollViewMain.addSubview(countryTextField)

         let viewUnLine4 = UIView()
         viewUnLine4.frame = CGRect(x: 16, y: self.countryTextField.frame.maxY+5, width: screenWidth-32, height: 1.5);
         viewUnLine4.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewUnLine4)
        
        countryTitle = UILabel()
        countryTitle.frame = CGRect(x: 16, y: viewUnLine4.frame.maxY+5, width: screenWidth-50, height: 30);
        countryTitle.text = "Zip Code (Postal Code) ";
        countryTitle.textColor = .darkText
        countryTitle.font = UIFont.boldSystemFont(ofSize: 12)
        scrollViewMain.addSubview(countryTitle)

         let paddingViewZipCode:UIView=UIView()
         paddingViewZipCode.frame=CGRect(x: 0,y: 0,width: 0,height: 20)
         zipcodeTextField = UITextField()
         zipcodeTextField.frame = CGRect(x: 16, y: countryTitle.frame.maxY, width: view.frame.size.width - 32 , height: 35)
         zipcodeTextField.delegate = self
         self.zipcodeTextField.tag = tags.zipcode
         zipcodeTextField.textColor = UIColor.black
         zipcodeTextField.leftView = paddingViewZipCode
         zipcodeTextField.placeholder = "201302"
         zipcodeTextField.tintColor = UIColor.black;
         zipcodeTextField.font = UIFont(name:"Arial",size:12.0)
         zipcodeTextField.backgroundColor = .clear
         zipcodeTextField.isSecureTextEntry = false
         zipcodeTextField.leftViewMode = .always
         zipcodeTextField.rightViewMode = .always
         zipcodeTextField.returnKeyType = .done
         zipcodeTextField.keyboardType = UIKeyboardType.asciiCapable
         scrollViewMain.addSubview(zipcodeTextField)

         let viewUnLine5 = UIView()
         viewUnLine5.frame = CGRect(x: 16, y: self.zipcodeTextField.frame.maxY+5, width: screenWidth-32, height: 1.5);
         viewUnLine5.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue:231.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewUnLine5)
        
         print("dictData:", dictData)
         if dictData.count > 0 {
            let fld_user_name = dictData.value(forKey: "fld_user_name") as? String ?? ""
            let fld_user_city = dictData.value(forKey: "fld_user_city") as? String ?? ""
            let fld_user_address = dictData.value(forKey: "fld_user_address") as? String ?? ""
            //let fld_user_locality = dictData.value(forKey: "fld_user_locality") as? String ?? ""
            let fld_user_state = dictData.value(forKey: "fld_user_state") as? String ?? ""
            let fld_user_pincode = dictData.value(forKey: "fld_user_pincode") as? String ?? ""
            let fld_user_country = dictData.value(forKey: "fld_user_country") as? String ?? ""
            
            if let fld_address_id = dictData.value(forKey: "fld_address_id") as? Int {
               self.addressid = "\(fld_address_id)"
            }
            if let fld_address_id = dictData.value(forKey: "fld_address_id") as? String {
               self.addressid = "\(fld_address_id)"
           }
            
            fullNameTextField.text = fld_user_name
            addressTextField.text = fld_user_address
            cityTextField.text = fld_user_city
            stateTextField.text = fld_user_state
            countryTextField.text = fld_user_country
            zipcodeTextField.text = fld_user_pincode
         }
        
         self.scrollViewMain.contentSize = CGSize(width: 0, height: viewUnLine5.frame.maxY + 200)
    }
    
 
    
    func callUi8SetUp() {
        
    }
    
    func bottomviewBG() {
        
        viewBottomBg = UIView()
        viewBottomBg.frame = CGRect(x: CGFloat(0), y:view.frame.size.height - 100, width: CGFloat(screenWidth), height: 100)
        viewBottomBg.backgroundColor = UIColor(red:215.0 / 255.0, green:215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
        viewBottomBg.layer.shadowColor = UIColor.black.cgColor
        viewBottomBg.layer.shadowOffset = CGSize(width: 0.0, height: 12.0)
        viewBottomBg.layer.masksToBounds = false
        viewBottomBg.layer.shadowRadius = 12.0
        viewBottomBg.layer.shadowOpacity = 0.5
        view.addSubview(viewBottomBg)
        
        btnSave = UIButton()
        btnSave.frame = CGRect(x: 26, y: 28, width: (viewBottomBg.frame.size.width - 52), height: 50)
        btnSave.backgroundColor = .clear
        btnSave.setTitle(" SAVE ", for: .normal)
        btnSave.setTitleColor(.white, for: .normal)
        btnSave.layer.borderWidth = 0
        btnSave.layer.cornerRadius = 24
        btnSave.clipsToBounds = true
        btnSave.backgroundColor = .blue
        btnSave.addTarget(self,action:#selector(self.clickOnSAVE(_:)),for: UIControl.Event.touchUpInside)
        btnSave.isUserInteractionEnabled = true
        viewBottomBg.addSubview(btnSave)
        
    }
    
    @objc func clickOnCart(_ sender: AnyObject!) {
        
    }
    
    @objc func clickOnBack(_ sender: AnyObject!) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func clickOnSAVE(_ sender: AnyObject!) {
        self.view.isUserInteractionEnabled = false
        if (fullNameTextField.text==""||fullNameTextField.text==" ") {
            self.showAlertView("Please enter your full name.")
        } else if (addressTextField.text==""||addressTextField.text==" ") {
            self.showAlertView("Please enter your address.")
        } else if (cityTextField.text==""||cityTextField.text==" ") {
            self.showAlertView("Please select city.")
        } else if (stateTextField.text==""||stateTextField.text==" ") {
            self.showAlertView("Please select state.")
        } else if (countryTextField.text==""||countryTextField.text==" ") {
            self.showAlertView("Please select country.")
        } else if (zipcodeTextField.text==""||zipcodeTextField.text==" ") {
            self.showAlertView("Please enter zip code.")
        } else {
            if self.screenMode == ScreenMode.addnewaddress {
               self.callAddAddressApi()
            } else if self.screenMode == ScreenMode.editnewaddress {
               self.callUpdateApi()
            }
        }
    }
    
    func showAlertView(_ text:String) {
           let alertController = UIAlertController(title: "", message: text, preferredStyle:.alert)
           alertController.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
                                            
          }));
          self.present(alertController, animated: true, completion: nil)
    }
    
    
    //Contry api
    func callGetCountryApi() {
        let json = [:] as [String : Any]
        print("Detail json: ", json)
        //DIProgressHud.show()
        getAPIAction(WebService.state_listing, parameters: nil, showGenricErrorPopup: false) { (response) in
        print("response detail:", response ?? "")
        DispatchQueue.main.async {
           //DIProgressHud.hide()
        }
        let message = response?["message"] as? String ?? ""
        if let status = response?.object(forKey: "status") as? Bool, status == true {
            if let dataArray = response?["state_data"] as? NSArray, dataArray.count > 0 {
               self.arraystate = dataArray as! NSMutableArray
            }
            DispatchQueue.main.async {
                
            }
        } else {
          DispatchQueue.main.async {
          //Utility.showAlert(withMessage: message, onController: self)
          }
        }
      }
    }

    func callGetCityApi() {
            let json = [
            "fld_state_id":38,
            "fld_city_id":5022
            ] as [String : Any]
            print("Detail json: ", json)

            postMyOrderAPIAction(WebService.area_listing, parameters: json, showGenricErrorPopup: false) { (response) in
                print("response detail:", response ?? "")

                let message = response?["message"] as? String ?? ""
                if let status = response?.object(forKey: "status") as? Bool, status == true {
                  if let dataArray = response?["area_data"] as? NSArray, dataArray.count > 0 {
                     self.arraystate = dataArray as! NSMutableArray
                  }
                } else {
                   DispatchQueue.main.async {
                     Utility.showAlert(withMessage: message, onController: self)
                   }
               }
            }
        }
    
//    func callGetCountryApi() {
//        
//      
//            let json = [
//                "fld_user_id":1,
//                "fld_address_id": addressid,
//                "fld_user_name": "aaamm R",
//                "fld_user_phone": "9999999999",
//                "fld_user_email": "ccc@gmail.com",
//                "fld_user_city": "Bangalore",
//                "fld_user_address": "Malagala",
//                "fld_user_locality": "Navarbhavi",
//                "fld_user_state": "Karnataka",
//                "fld_user_pincode": "560072",
//                "fld_address_type": 2,
//                "fld_address_default": 0
//                ] as [String : Any]
//            
//            print("Detail json: ", json)
//    //        DIProgressHud.show()
//            postMyOrderAPIAction(WebService.updateAddress, parameters: json, showGenricErrorPopup: false) { (response) in
//                       print("response detail:", response ?? "")
//                       DispatchQueue.main.async {
//    //                    DIProgressHud.hide()
//                       }
//                       let message = response?["message"] as? String ?? ""
//                       if let status = response?.object(forKey: "status") as? Bool, status == true {
//                          DispatchQueue.main.async {
//                             let message = response?["message"] as? String
//                             let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
//                                     self.present(alert,animated:true, completion:nil)
//                                     let delay = 2.0 * Double(NSEC_PER_SEC)
//                                     let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
//                                     DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
//                                         self.dismiss(animated: true, completion: {
//                                            self.navigationController?.popViewController(animated: true)
//                                     });
//                              }
//                          }
//                       } else {
//                         DispatchQueue.main.async {
//                           Utility.showAlert(withMessage: message, onController: self)
//                         }
//                       }
//                }
//        }
    
    func callAddAddressApi() {
            let json = [
                "fld_user_id": getUserID(),
                "fld_user_name": fullNameTextField.text!,
                "fld_user_phone": "",
                "fld_user_email": "",
                "fld_user_city": cityTextField.text!,
                "fld_user_address": addressTextField.text!,
                "fld_user_locality": "",
                "fld_user_state": stateTextField.text!,
                "fld_user_pincode": zipcodeTextField.text!,
                "fld_user_country": countryTextField.text!,
                "fld_address_type": 2,
                "fld_address_default": 0
                ] as [String : Any]
        
            print("Detail json: ", json)
    //      DIProgressHud.show()
            postMyOrderAPIAction(WebService.addAddress, parameters: json, showGenricErrorPopup: false) { (response) in
            print("response detail:", response ?? "")
                       DispatchQueue.main.async {
                        self.view.isUserInteractionEnabled = true
    //                    DIProgressHud.hide()
                       }
                       let message = response?["message"] as? String ?? ""
                       if let status = response?.object(forKey: "status") as? Bool, status == true {
                          DispatchQueue.main.async {
                             let message = response?["message"] as? String
                             let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
                                     self.present(alert,animated:true, completion:nil)
                                     let delay = 2.0 * Double(NSEC_PER_SEC)
                                     let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                                     DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                                         self.dismiss(animated: true, completion: {
                                         self.navigationController?.popViewController(animated: true)
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
    
    func callUpdateApi() {
        let json = [
            "fld_user_id":getUserID(),
            "fld_address_id": self.addressid,
            "fld_user_name": fullNameTextField.text!,
            "fld_user_phone": "",
            "fld_user_email": "",
            "fld_user_city": cityTextField.text!,
            "fld_user_address": addressTextField.text!,
            "fld_user_locality": "",
            "fld_user_country": countryTextField.text!,
            "fld_user_state": stateTextField.text!,
            "fld_user_pincode": zipcodeTextField.text!,
            "fld_address_type": 2,
            "fld_address_default": 0
            ] as [String : Any]
        
        
        print("Detail json: ", json)
//        DIProgressHud.show()
        postMyOrderAPIAction(WebService.updateAddress, parameters: json, showGenricErrorPopup: false) { (response) in
                   print("response detail:", response ?? "")
             
                   DispatchQueue.main.async {
                    self.view.isUserInteractionEnabled = true
//                    DIProgressHud.hide()
                   }
                   let message = response?["message"] as? String ?? ""
                   if let status = response?.object(forKey: "status") as? Bool, status == true {
                      DispatchQueue.main.async {
                         let message = response?["message"] as? String
                         let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
                         self.present(alert,animated:true, completion:nil)
                                 let delay = 2.0 * Double(NSEC_PER_SEC)
                                 let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                                 DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                                     self.dismiss(animated: true, completion: {
                                        self.navigationController?.popViewController(animated: true)
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
    
    // MARK: - UITextFieldDelegate
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         view.endEditing(true)
         scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 0), animated: true)
         return true
     }
     
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if textField.tag == tags.zipcode {
             if string.cString(using: String.Encoding.utf8) != nil {
//                 let  char = string.cString(using: String.Encoding.utf8)!
//                 let isBackSpace = strcmp(char, "\\b")
//                 let str = string
//                 let decimalCharacters = CharacterSet.decimalDigits
//                 let decimalRange = str.rangeOfCharacter(from: decimalCharacters)
//                 if decimalRange != nil {
//                     if (isBackSpace == -92) {
//                         return true
//                     } else if string.isEmpty {
//                         return true
//                     } else {
//                         let currentText = textField.text ?? ""
//                         guard let stringRange = Range(range, in: currentText) else { return false }
//                         _ = currentText.replacingCharacters(in: stringRange, with: string)
//                         let rangeLength: NSRange = ((textField.text as? NSString!)!.range(of: textField.text!))
//                         if rangeLength.length == 7 {
//                             return false
//                         }
//                         if (rangeLength.length == 3) || (rangeLength.length == 7) {
//                             let str = "\(String(describing: textField.text!)) "
//                             textField.text = str
//                         }
//                     }
//                 }
             } else if string.isEmpty {
                 return true
             } else {
                 return false
             }
         }
         return true
     }
     
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         return true
     }
     
     func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField.isEqual(countryTextField) {
//           self.pickerViewCountryCode.isHidden = false
//           self.countryCodeTextField.becomeFirstResponder()
//           self.pickerViewCountryCode.reloadAllComponents()
             scrollViewMain.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
         }
        
         if textField.isEqual(cityTextField) {
//             self.pickerViewRelation.isHidden = false
//             self.relationTextField.becomeFirstResponder()
//             self.pickerViewRelation.reloadAllComponents()
//             if !isSelectedRelation {
//                 if relationListArray.count > 0 {
//                     if let dict =  relationListArray[0] as? NSDictionary {
//                         let display = dict["display"] as? String ?? ""
//                         self.relationTextField.text = display
//                         self.relationValue = dict["value"] as? String ?? ""
//                     }
//                 }
//             }
             scrollViewMain.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        }

        if textField.isEqual(cityTextField) {
            scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 100), animated: true)
        } else if textField.isEqual(stateTextField) {
            scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 150), animated: true)
        } else if textField.isEqual(countryTextField) {
            scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 200), animated: true)
        } else if textField.isEqual(zipcodeTextField) {
            scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 250), animated: true)
        }
        
        
//         if UIScreen.main.bounds.height <= 667 {
//            scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 90), animated: true)
//         } else {
//             scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 150), animated: true)
//             if textField.tag == tags.state || textField.tag == tags.country || textField.tag == tags.zipcode {
//                 scrollViewMain.setContentOffset(CGPoint(x: scrollViewMain.contentOffset.x, y: 250), animated: true)
//             }
//         }
     }

//    {
//    "fld_user_id":1,
//    "fld_address_id": 158,
//    "fld_user_name": "aaamm R",
//    "fld_user_phone": "9999999999",
//    "fld_user_email": "ccc@gmail.com",
//    "fld_user_city": "Bangalore",
//    "fld_user_address": "Malagala",
//    "fld_user_locality": "Navarbhavi",
//    "fld_user_state": "Karnataka",
//    "fld_user_pincode": "560072",
//    "fld_address_type": 2,
//    "fld_address_default": 0
//    }
    
}
