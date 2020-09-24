//  ShippingAddressVC.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
@objc protocol ChangeAddressControllerDelegates {
    func PopupChangeAddressController()
    func ControllerChangeAddressDidDissmiss()
    func callAgainPoductSummary(dict: NSDictionary) -> Bool
}
class ShippingAddressVC: UIViewController {
    var arrayData = ["Invite Friends", "Fantasy Point System", "How to Play", "HelpDesk","About Us"]
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var tableMain: UITableView!
    var delegate: ChangeAddressControllerDelegates! = nil

    var arrayAddressList = NSMutableArray()
    var viewBottomBg = UIView()
    var btnPlus = UIButton()
    var ary_temp: NSMutableArray!
    var str_CAt_ids: NSMutableString!
    var array_selecteditems: NSMutableArray!
    var product_id = ""
    var iscomefromPlaceOrder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true
        
        ary_temp = NSMutableArray()
        array_selecteditems = NSMutableArray()
        self.uiSetUpScrollView()
        
    }
    
    func uiSetUpScrollView() {
        
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
                      viewHeaderBg.addSubview(btnCart)
               
                      let viewUnLine = UIView()
                      viewUnLine.frame = CGRect(x: 0, y: 75.0, width: screenWidth, height: 1.5);
                      viewUnLine.backgroundColor = UIColor(red: 215.0 / 255.0, green: 215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
                      viewUnLine.layer.shadowColor = UIColor.black.cgColor
                      viewUnLine.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                      viewUnLine.layer.masksToBounds = false
                      viewUnLine.layer.shadowRadius = 1.0
                      viewUnLine.layer.shadowOpacity = 0.5
                      viewHeaderBg.addSubview(viewUnLine)
        
        self.tableMain = UITableView()
        self.tableMain.frame = CGRect(x: 0, y: 75, width: screenWidth, height: screenHeight-75);
        self.tableMain.register(UINib(nibName: "ShippingAddressCell", bundle: nil), forCellReuseIdentifier: "ShippingAddressCell")
        
        self.tableMain.delegate = self
        self.tableMain.dataSource = self
        self.tableMain.separatorStyle = .none
        self.tableMain.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        self.view.addSubview(tableMain)
        
        self.bottomviewBG()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          self.callUserAddresssApi()
    }
    func bottomviewBG() {
        btnPlus = UIButton()
        btnPlus.frame = CGRect(x: screenWidth - 80, y: screenHeight - 100, width: 45, height: 45)
        btnPlus.backgroundColor = UIColor(red: 38.0 / 255.0, green: 141.0 / 255.0, blue:211.0 / 255.0, alpha: 1.0)
        btnPlus.layer.borderWidth = 0
        btnPlus.layer.cornerRadius = 45/2
        btnPlus.clipsToBounds = true
        btnPlus.setImage(UIImage(named: "addPlus"), for: UIControl.State.normal)
        btnPlus.addTarget(self,action:#selector(self.clickBtnPlus(_:)),for: UIControl.Event.touchUpInside)
        btnPlus.isUserInteractionEnabled = true
        self.view.addSubview(btnPlus)
    }
    
    @objc func clickOnCart(_ sender: AnyObject!) {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MyCartController") as? MyCartController {
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func clickOnBack(_ sender: AnyObject!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnGoToCart(_ sender: AnyObject!) {
        
    }

    @objc func clickBtnPlus(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "AddNewAddressController") as? AddNewAddressController {
            vc.screenMode = 1
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension ShippingAddressVC:UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayAddressList.count
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 35)
        sectionHeader.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        let heading = UILabel()
        heading.frame = CGRect(x: 16, y: 5, width: tableView.frame.size.width-32, height: 25)
        heading.text = "Shipping Address"
        heading.font = UIFont.boldSystemFont(ofSize: 16)
        heading.textColor = UIColor.darkGray
        heading.backgroundColor = .clear
        sectionHeader.addSubview(heading)
        return sectionHeader
    }

    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingAddressCell", for: indexPath as IndexPath) as! ShippingAddressCell
        cell.selectionStyle = .none
        cell.viewBG.layer.cornerRadius = 6
        cell.viewBG.clipsToBounds = true
        cell.contentView.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        cell.viewBG.layer.shadowColor = UIColor.black.cgColor
        cell.viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 0.4)
        cell.viewBG.layer.masksToBounds = false
        cell.viewBG.layer.shadowRadius = 0.2
        cell.viewBG.layer.shadowOpacity = 0.7

        if let dict = self.arrayAddressList[indexPath.row] as? NSDictionary {
            let fld_user_name = dict.value(forKey: "fld_user_name") as? String ?? ""
            let fld_user_city = dict.value(forKey: "fld_user_city") as? String ?? ""
            let fld_user_address = dict.value(forKey: "fld_user_address") as? String ?? ""
            let fld_user_locality = dict.value(forKey: "fld_user_locality") as? String ?? ""
            let fld_user_state = dict.value(forKey: "fld_user_state") as? String ?? ""
            let fld_user_pincode = dict.value(forKey: "fld_user_pincode") as? String ?? ""
            let str_address = fld_user_address + ", \(fld_user_locality)" + ", \(fld_user_city)" + ", \(fld_user_state)-\(fld_user_pincode)"
            cell.lblName.text = fld_user_name.capitalized
            cell.lblAddress.text = str_address
            cell.lblName.textColor = .black
            cell.lblName.font = UIFont.boldSystemFont(ofSize: 14.0)
            cell.lblAddress.font = UIFont(name: cell.lblAddress.font.fontName, size: 12)
            cell.lblUseastheshiipingaddress.text = "Use as the shipping address"
        }
        cell.btnEddit.addTarget(self, action: #selector(btnEddit), for: .touchUpInside)
        cell.btnEddit.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDelete), for: .touchUpInside)
        cell.btnCheckUnckeck.addTarget(self, action: #selector(btnCheckUnckeck), for: .touchUpInside)
        cell.btnCheckUnckeck.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
         if array_selecteditems.contains(self.arrayAddressList[indexPath.row] ) {
             cell.btnCheckUnckeck.layer.borderWidth = 1
             cell.btnCheckUnckeck.layer.borderColor = UIColor.darkGray.cgColor
             cell.btnCheckUnckeck.backgroundColor = .blue
             cell.btnCheckUnckeck.setImage(UIImage(named: "selectedCheckboxTick"), for: .normal)
         } else {
             cell.btnCheckUnckeck.backgroundColor = .clear
             cell.btnCheckUnckeck.layer.borderWidth = 1
             cell.btnCheckUnckeck.layer.borderColor = UIColor.darkGray.cgColor
         }
        return cell
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func btnEddit(sender: UIButton!) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
//        self.navigationController?.pushViewController(VC, animated: true)
        
        let index = sender.tag
        if let dict = self.arrayAddressList[index] as? NSDictionary {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "AddNewAddressController") as? AddNewAddressController {
               vc.dictData = dict as! NSMutableDictionary
                vc.screenMode = 2
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }

        
    }
    
    @objc func btnDelete(sender: UIButton!) {
//      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//      let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
//      self.navigationController?.pushViewController(VC, animated: true)
        self.view.isUserInteractionEnabled = false
        let index = sender.tag
        var fldAddressId = ""
        if let dict = self.arrayAddressList[index] as? NSDictionary {
           if let fld_address_id = dict.value(forKey: "fld_address_id") as? Int {
              fldAddressId = "\(fld_address_id)"
           }
        }
        let json = [
                    "fld_user_id":getUserID(),
                    "fld_address_id": fldAddressId
                ] as [String : Any]
        print("Detail json: ", json)
        postMyOrderAPIAction(WebService.deleteAddress, parameters: json, showGenricErrorPopup: false) { (response) in
        print("response detail:", response ?? "")
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
//           DIProgressHud.hide()
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
                           self.callUserAddresssApi()
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
    
    @objc func btnCheckUnckeck(sender: UIButton!) {
          let tag = sender.tag
          array_selecteditems.removeAllObjects()
          if !array_selecteditems.contains(self.arrayAddressList[tag]) {
             array_selecteditems.add(self.arrayAddressList[tag])
          } else {
             array_selecteditems.remove(self.arrayAddressList[tag])
          }
          ary_temp = array_selecteditems
          print("array_temp:", ary_temp ?? 0)
          self.tableMain.reloadData()
                var fldAddressId = ""
                if let dict = self.arrayAddressList[tag] as? NSDictionary {
                   if let fld_address_id = dict.value(forKey: "fld_address_id") as? Int {
                      fldAddressId = "\(fld_address_id)"
                   }
                }
                let json = [
                    "fld_user_id":getUserID(),
                    "fld_address_id": fldAddressId,
                    "fld_address_default": 1
                        ] as [String : Any]
                print("Detail json: ", json)
                postMyOrderAPIAction(WebService.addDefaultAddress, parameters: json, showGenricErrorPopup: false) { (response) in
                print("response detail:", response ?? "")
                DispatchQueue.main.async {
                    self.view.isUserInteractionEnabled = true
        //           DIProgressHud.hide()
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
                                     if let dict = self.arrayAddressList[tag] as? NSDictionary {
                                        var isSuccess = false
                                        if self.delegate != nil {
                                           isSuccess = self.delegate.callAgainPoductSummary(dict: dict)
                                           if isSuccess == true {
                                             if self.iscomefromPlaceOrder == true {
                                                self.dismissPopup()
                                             } else {
                                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                if let VC = storyBoard.instantiateViewController(withIdentifier: "PlaceOrderController") as? PlaceOrderController {
                                                   self.navigationController?.pushViewController(VC, animated: true)
                                                }
                                             }
                                          }
                                        } else {
                                           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                           if let vc = storyBoard.instantiateViewController(withIdentifier: "PlaceOrderController") as? PlaceOrderController {
                                              vc.dictData = dict
                                              self.navigationController?.pushViewController(vc, animated: true)
                                           }
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
    
    func dismissPopup() {
         self.navigationController?.popViewController(animated: true)
    }
    
    
    func callUserAddresssApi() {
         let json = [
             "fld_user_id":getUserID()
         ] as [String : Any]

         print("Detail json: ", json)
         postMyOrderAPIAction(WebService.userAddresss, parameters: json, showGenricErrorPopup: false) { (response) in
         print("response detail:", response ?? "")
         DispatchQueue.main.async {
             DIProgressHud.hide()
         }
         let message = response?["message"] as? String ?? ""
         if let status = response?.object(forKey: "status") as? Bool, status == true {
            DispatchQueue.main.async {
              if let dataArray = response?.object(forKey: "user_address") as? NSArray, dataArray.count > 0 {
                 self.arrayAddressList = dataArray as! NSMutableArray
               }
            }
          } else {
           DispatchQueue.main.async {
               Utility.showAlert(withMessage: message, onController: self)
             }
           }
           DispatchQueue.main.async {
              self.tableMain.reloadData()
           }
        }
    }
   
}
