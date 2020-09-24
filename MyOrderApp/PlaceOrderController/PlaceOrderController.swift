//
//  PlaceOrderController.swift
//  MyOrderApp
//
//  Created by Apple on 9/11/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class PlaceOrderController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   var screenSize: CGRect = UIScreen.main.bounds
   var screenWidth: CGFloat = 0.0
   var screenHeight: CGFloat = 0.0
   var viewBottomBg = UIView()
   var btnPlaceOrder = UIButton()

    var tableMain = UITableView()
    
    var dictData = NSDictionary()
    var dictAmountData = NSDictionary()
    var arrayCartList = NSMutableArray()
    
    var shipping_id = ""
    
    enum TableSection {
        
           static let shippingAddress = 0
           static let productSummary = 1
           static let totalAmount = 2
           static let count = 3
       }
   override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:248.0 / 255.0, green:248.0 / 255.0, blue:248.0 / 255.0, alpha: 1.0);
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        self.uiSetUpScrollView()
        
        registerNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
 
    }
    
    func registerNib() {
         tableMain =  UITableView()
         tableMain.frame = CGRect(x: 0, y: 75, width: screenWidth, height: screenHeight-110)
         tableMain.register(UINib(nibName: "CheckOutCell", bundle: nil), forCellReuseIdentifier: "CheckOutCell")
         tableMain.delegate = self
         tableMain.dataSource = self
         tableMain.separatorStyle = .none
         view.addSubview(tableMain)

         tableMain.register(UINib(nibName: "SummaryAmountCell", bundle: nil), forCellReuseIdentifier: "SummaryAmountCell")
         tableMain.backgroundColor = UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
         tableMain.register(UINib(nibName: "TotalQuantityCell", bundle: nil), forCellReuseIdentifier: "TotalQuantityCell")
         tableMain.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "SummaryCell")
         tableMain.register(UINib(nibName: "PlaceAmountCell", bundle: nil), forCellReuseIdentifier: "PlaceAmountCell")
         self.bottomviewBG()
         self.callCartReviewApi()
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
    //  btnCart.addTarget(self,action:#selector(self.clickOnCart(_:)),for: UIControl.Event.touchUpInside)
        btnCart.isUserInteractionEnabled = true
    //  viewHeaderBg.addSubview(btnCart)
        
        let viewUnLine = UIView()
        viewUnLine.frame = CGRect(x: 0, y: 75, width: screenWidth, height: 1.0);
        viewUnLine.backgroundColor = UIColor(red: 215.0 / 255.0, green: 215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
        viewUnLine.layer.shadowColor = UIColor.black.cgColor
        viewUnLine.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewUnLine.layer.masksToBounds = false
        viewUnLine.layer.shadowRadius = 1.0
        viewUnLine.layer.shadowOpacity = 0.5
        viewHeaderBg.addSubview(viewUnLine)
    }
    
    @objc func clickOnBack(_ sender: AnyObject!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func bottomviewBG() {
        viewBottomBg = UIView()
        viewBottomBg.frame = CGRect(x: CGFloat(0), y:view.frame.size.height - 100, width: CGFloat(screenWidth), height: 100)
        viewBottomBg.backgroundColor = UIColor(red:215.0 / 255.0, green:215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
        viewBottomBg.layer.shadowColor = UIColor.clear.cgColor
        viewBottomBg.layer.shadowOffset = CGSize(width: 0.0, height: 12.0)
        viewBottomBg.layer.masksToBounds = false
        viewBottomBg.layer.shadowRadius = 12.0
        viewBottomBg.layer.shadowOpacity = 0.5
        view.addSubview(viewBottomBg)
        
        btnPlaceOrder = UIButton()
        btnPlaceOrder.frame = CGRect(x: 26, y: 28, width: (viewBottomBg.frame.size.width - 52), height: 50)
        btnPlaceOrder.backgroundColor = .clear
        btnPlaceOrder.setTitle(" PLACE ORDER ", for: .normal)
        btnPlaceOrder.setTitleColor(.white, for: .normal)
        btnPlaceOrder.layer.borderWidth = 0
        btnPlaceOrder.layer.cornerRadius = 24
        btnPlaceOrder.clipsToBounds = true
        btnPlaceOrder.backgroundColor = .blue
        btnPlaceOrder.addTarget(self,action:#selector(self.clickPlaceOrder(_:)),for: UIControl.Event.touchUpInside)
        btnPlaceOrder.isUserInteractionEnabled = true
        viewBottomBg.addSubview(btnPlaceOrder)
        
    }
    
    @objc func clickPlaceOrder(_ sender: AnyObject!) {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to place order?", preferredStyle:.alert)
            alertController.addAction(UIAlertAction(title:"NO",style:UIAlertAction.Style.default, handler:{(action: UIAlertAction) in
        }));
        alertController.addAction(UIAlertAction(title:"YES", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
            self.callPlaceOrderApi()
        }));
        self.present(alertController, animated: true, completion: nil)
    }
    
    func PopupChangeAddressController() {
         
    }
    
    func ControllerChangeAddressDidDissmiss() {
         
    }
    
    func callAgainPoductSummary(dict: NSDictionary) -> Bool {
        print("dict:", dict);
        return true;
    }
    
    func callPlaceOrderApi() {
        if let fld_address_id = dictData.value(forKey: "fld_address_id") as? Int {
             shipping_id = "\(fld_address_id)"
         }
         if let fld_address_id = dictData.value(forKey: "fld_address_id") as? String {
            shipping_id = "\(fld_address_id)"
         }
         var totalQty = ""
         var totalAmount = ""
        //var discountValue = ""
        //var netAmount = ""
         if let cart_total = self.dictAmountData.value(forKey: "cart_total") as? Int {
            totalAmount = "\(cart_total)"
         }
         if let cart_total = self.dictAmountData.value(forKey: "cart_total") as? String {
            totalAmount = "\(cart_total)"
         }
         if let total_qty = self.dictAmountData.value(forKey: "total_qty") as? Int {
            totalQty = "\(total_qty)"
         }
         if let total_qty = self.dictAmountData.value(forKey: "total_qty") as? String {
            totalQty = "\(total_qty)"
         }
         let json = [
             "fld_user_id":getUserID(),
             "fld_shipping_id": shipping_id,
             "fld_purchase_type":2,
             "fld_coupon_code":"",
             "fld_txn_id":"",
             "fld_txn_status":"",
             "fld_shipping_charges":0,
             "fld_payment_mode":0,
             "fld_grand_total":totalAmount,
             "fld_wallet_amount":0,
             "fld_coupon_percent":0,
             "fld_discount_amount":0,
             "fld_tax":0
            ] as [String : Any]

         print("Detail json: ", json)
         postMyOrderAPIAction(WebService.saveOrder, parameters: json, showGenricErrorPopup: false) { (response) in
         print("response detail:", response ?? "")
//         DispatchQueue.main.async {
//            DIProgressHud.hide()
//         }
           if let status = response?.object(forKey: "status") as? Bool, status == true {
               DispatchQueue.main.async {
                  self.callSuccessPopUp()
               }
            }
        }
    }
    
    func callSuccessPopUp() {
                let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                if let vc = storyboard.instantiateViewController(withIdentifier: "ContinueShopingVC") as? ContinueShopingVC {
                   self.navigationController?.pushViewController(vc, animated: true)
                }
        
    }
    
    func callCartReviewApi() {
         let json = [
             "fld_user_id":getUserID()
         ] as [String : Any]

         print("Detail json: ", json)
         postMyOrderAPIAction(WebService.cart_review, parameters: json, showGenricErrorPopup: false) { (response) in
         print("response detail:", response ?? "")
         DispatchQueue.main.async {
            DIProgressHud.hide()
         }
         let message = response?["message"] as? String ?? ""
            
         if let status = response?.object(forKey: "status") as? Bool, status == true {
            DispatchQueue.main.async {
              self.dictAmountData = response ?? NSDictionary()
              if let dataArray = response?.object(forKey: "cart_data") as? NSArray, dataArray.count > 0 {
                 let dict = [
                    "title":""
                 ]
                 self.arrayCartList = dataArray as! NSMutableArray
                 print("self.arrayCartList: ",self.arrayCartList)
                self.arrayCartList.insert(dict, at: 0)
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
    
      // MARK: - TableView Delegate Methods
        func numberOfSections(in tableView: UITableView) -> Int {
            return TableSection.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == TableSection.shippingAddress {
                return 1
            } else if section == TableSection.productSummary {
                return self.arrayCartList.count
            } else {
                return 1
            }
        }
           
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == TableSection.productSummary {
               return 35
            } else {
               return 40
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == TableSection.productSummary {
                return 40
            } else if section == TableSection.shippingAddress {
                return 40
            } else if section == TableSection.totalAmount {
                return 50
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let sectionHeader = UIView()
            sectionHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40)
            sectionHeader.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
            let heading = UILabel()
            heading.frame = CGRect(x: 16, y: 5, width: tableView.frame.size.width-32, height: 35)
            if section == TableSection.shippingAddress {
                heading.text = "Shipping Address"
            }
            if section == TableSection.productSummary {
                heading.text = "Product Summary"
            }
            heading.font = UIFont.boldSystemFont(ofSize: 16)
            if section == TableSection.totalAmount {
               sectionHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
               heading.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
               heading.font = UIFont.boldSystemFont(ofSize: 0)
            }
            heading.textColor = UIColor.darkGray
            heading.backgroundColor = .clear
            sectionHeader.addSubview(heading)
            return sectionHeader
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == TableSection.shippingAddress {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOutCell", for: indexPath) as? CheckOutCell {
                    cell.selectionStyle = .none
                    cell.contentView.backgroundColor = UIColor(red:248.0 / 255.0, green:248.0 / 255.0, blue:248.0 / 255.0, alpha: 1.0)
                    cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                    cell.changeButton.tag = indexPath.row
                    cell.changeButton.addTarget(self, action: #selector(self.changeAddress), for: UIControl.Event.touchUpInside)
                    cell.viewBg.layer.cornerRadius = 6
                    cell.viewBg.clipsToBounds = true
//                  cell.name.text = ""
//                  cell.address.text = ""
                    if dictData.count > 0 {
                            let fld_user_name = dictData.value(forKey: "fld_user_name") as? String ?? ""
                            let fld_user_city = dictData.value(forKey: "fld_user_city") as? String ?? ""
                            let fld_user_address = dictData.value(forKey: "fld_user_address") as? String ?? ""
                            let fld_user_locality = dictData.value(forKey: "fld_user_locality") as? String ?? ""
                            let fld_user_state = dictData.value(forKey: "fld_user_state") as? String ?? ""
                            let fld_user_pincode = dictData.value(forKey: "fld_user_pincode") as? String ?? ""
                            let str_address = fld_user_address + ", \(fld_user_locality)" + ", \(fld_user_city)" + ", \(fld_user_state)-\(fld_user_pincode)"
                            cell.name.text = fld_user_name.capitalized
                            cell.address.text = str_address
                            cell.name.textColor = .black
                            cell.name.font = UIFont.boldSystemFont(ofSize: 14.0)
                            cell.address.font = UIFont(name: cell.address.font.fontName, size: 12)
                    }
                    return cell
                }
            } else if indexPath.section == TableSection.productSummary {
                if indexPath.row == 0 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell {
                       cell.selectionStyle = .none
                       cell.contentView.backgroundColor = UIColor(red:248.0 / 255.0, green:248.0 / 255.0, blue:248.0 / 255.0, alpha: 1.0)
                       return cell
                    }
                } else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryAmountCell", for: indexPath) as? SummaryAmountCell {
                       cell.selectionStyle = .none
                       cell.contentView.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                      cell.viewBg.backgroundColor = .clear
                      if let dict = self.arrayCartList[indexPath.row] as? NSDictionary {
                                            var fldproductprice = ""
                                            var fldproductqty = ""
                                            let fld_product_name = dict.value(forKey: "fld_product_name") as? String ?? ""
                                            if let fld_product_qty = dict.value(forKey: "fld_product_qty") as? Int {
                                               fldproductqty = "\(fld_product_qty)"
                                            }
                                            if let fld_product_qty = dict.value(forKey: "fld_product_qty") as? String {
                                               fldproductqty = "\(fld_product_qty)"
                                            }
                                            if let fld_product_price = dict.value(forKey: "fld_product_price") as? Int {
                                               fldproductprice = "\(fld_product_price)"
                                            }
                                            if let fld_product_price = dict.value(forKey: "fld_product_price") as? String {
                                               fldproductprice = "\(fld_product_price)"
                                            }
                                            cell.itemName.text = fld_product_name.capitalized
                                            cell.amoutQty.text = fldproductqty
                                            cell.price.text = fldproductprice
                        }
                        return cell
                    }
                }
            }
            
            else if indexPath.section == TableSection.totalAmount {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceAmountCell", for: indexPath) as? PlaceAmountCell {
                   cell.selectionStyle = .none
                   cell.contentView.backgroundColor = UIColor(red:248.0 / 255.0, green:248.0 / 255.0, blue:248.0 / 255.0, alpha: 1.0)
                   var totalQty = ""
                   var totalAmount = ""
//                   var discountValue = ""
//                   var netAmount = ""
                   if let cart_total = self.dictAmountData.value(forKey: "cart_total") as? Int {
                        totalAmount = "\(cart_total)"
                    }
                    if let cart_total = self.dictAmountData.value(forKey: "cart_total") as? String {
                        totalAmount = "\(cart_total)"
                    }
                    if let total_qty = self.dictAmountData.value(forKey: "total_qty") as? Int {
                       totalQty = "\(total_qty)"
                    }
                    if let total_qty = self.dictAmountData.value(forKey: "total_qty") as? String {
                       totalQty = "\(total_qty)"
                   }
                   cell.quantity.text = totalQty
                   cell.totalAmount.text = "\u{20B9}\(totalAmount)"
                   cell.discountValue.text = "\u{20B9}\("0")"
                   cell.netamount.text = "\u{20B9}\(totalAmount)"
                   return cell
                }
             }
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
    //        if indexPath.section == TableSection.viewAttachedPresc {
    //            let storyboard = UIStoryboard(name:"Assessments", bundle: Bundle.main)
    //            let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "attachedPrescriptionListController") as! AttachedPrescriptionListController
    //            attachedPrescriptionListController.orderId = orderId
    //            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
    //        }
        }

      @objc func changeAddress(_ sender: UIButton) {
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddressVC") as? ShippingAddressVC {
                vc.iscomefromPlaceOrder = true
               self.navigationController?.pushViewController(vc, animated: true)
            }
      }
}
