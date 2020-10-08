//
//  MyOrderStatusController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class MyOrderStatusController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var textFieldSearch: UITextField!
    var strcartcount = 0
    var cartCountLabel = UILabel()
    var tableViewList = UITableView()
    var arrayOrderList = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.title = ""
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        textFieldSearch = UITextField()
        
        self.uiSetUpScrollView()
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        print("topBarHeight:", topBarHeight)
        textFieldSearch.frame = CGRect(x: 16, y: 90, width: view.frame.size.width - 32 , height: 40)
        textFieldSearch.delegate = self
        self.view.addSubview(textFieldSearch)
               
        textFieldSearch.layer.borderColor = UIColor.gray.cgColor
        textFieldSearch.layer.borderWidth = 1
        textFieldSearch.layer.cornerRadius = 20
        textFieldSearch.clipsToBounds = true
               
        let paddingView_CurrentPwd:UIView=UIView()
        paddingView_CurrentPwd.frame=CGRect(x: 0,y: 0,width: 45,height: 20)
        let paddingRightView_CurrentPwd:UIView=UIView()
        paddingRightView_CurrentPwd.frame=CGRect(x: 0,y: 0,width: 20,height: 20)
        textFieldSearch.delegate = self
        textFieldSearch.textColor = UIColor.black
        textFieldSearch.leftView = paddingView_CurrentPwd
        textFieldSearch.rightView = paddingRightView_CurrentPwd
        textFieldSearch.placeholder = "Search"
        textFieldSearch.tintColor = UIColor.black;
        textFieldSearch.font = UIFont(name:"Arial",size:16.0)
        textFieldSearch.backgroundColor = UIColor.white
        textFieldSearch.layer.cornerRadius = 20.0
        textFieldSearch.isSecureTextEntry = false
        textFieldSearch.leftViewMode = .always
        textFieldSearch.rightViewMode = .always
        textFieldSearch.tag = 100
        textFieldSearch.returnKeyType = .next
        textFieldSearch.keyboardType = UIKeyboardType.asciiCapable

        let imagesearch = UIImageView()
        imagesearch.frame = CGRect(x:15, y: 10, width:  18, height: 18)
        imagesearch.image = UIImage(named: "search")
        imagesearch.backgroundColor = .clear
        imagesearch.contentMode = .scaleAspectFit
        textFieldSearch.addSubview(imagesearch)
        self.uisetUpTableView()
    }
    
    func uiSetUpScrollView() {
         let viewHeaderBg = UIView()
         viewHeaderBg.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 75);
         viewHeaderBg.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
         viewHeaderBg.layer.shadowColor = UIColor.black.cgColor
         viewHeaderBg.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
         viewHeaderBg.layer.masksToBounds = false
         viewHeaderBg.layer.shadowRadius = 0.6
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
         imageLogo.frame = CGRect(x: 80, y: 30, width:  screenWidth-160, height: 40)
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
         viewUnLine.frame = CGRect(x: 0, y: 75.0, width: screenWidth, height: 0.5);
         viewUnLine.backgroundColor = UIColor(red: 215.0 / 255.0, green: 215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
         viewUnLine.layer.shadowColor = UIColor.black.cgColor
         viewUnLine.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
         viewUnLine.layer.masksToBounds = false
         viewUnLine.layer.shadowRadius = 1.0
         viewUnLine.layer.shadowOpacity = 0.5
           
         cartCountLabel = UILabel()
         cartCountLabel.frame = CGRect(x:screenWidth-46, y: 28, width:  24, height: 24);
         self.cartCountLabel.layer.cornerRadius = self.cartCountLabel.frame.width/2
         self.cartCountLabel.clipsToBounds = true
         self.cartCountLabel.layer.borderColor = UIColor.white.cgColor
         self.cartCountLabel.layer.borderWidth = 2
         self.cartCountLabel.textAlignment = .center
         self.cartCountLabel.textColor = .white
         self.cartCountLabel.backgroundColor = .red
         self.cartCountLabel.font = UIFont(name:"Arial",size:12.0)
         viewHeaderBg.addSubview(self.cartCountLabel)
         //self.strcartcount = 2
         if self.strcartcount > 0 {
            self.cartCountLabel.isHidden = false
            self.cartCountLabel.text = "\(self.strcartcount)"
         } else {
            self.cartCountLabel.isHidden = true
         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.callOrderListApi()
    }
    
    func uisetUpTableView() {
        tableViewList = UITableView()
        tableViewList.frame = CGRect(x: 0, y: textFieldSearch.frame.maxY+2, width: screenWidth, height: screenHeight - (textFieldSearch.frame.maxY+2))
        tableViewList.backgroundColor = .yellow
        tableViewList.backgroundColor = .clear
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.separatorStyle = .none
        tableViewList.register(UINib(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
        view.addSubview(tableViewList)
    }
    
    @objc func clickOnCart(_ sender: AnyObject!) {
      
    }
       
    @objc func clickOnBack(_ sender: AnyObject!) {
          self.navigationController!.setNavigationBarHidden(false,animated: false)
          self.navigationItem.hidesBackButton = true
          self.navigationController?.popViewController(animated: true)
    }
       
    // MARK: - TableView Delegate Methods
       
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOrderList.count
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
         heading.text = "My Orders"
            heading.font = UIFont.boldSystemFont(ofSize: 16)
            heading.textColor = UIColor.darkGray
            heading.backgroundColor = .clear
            sectionHeader.addSubview(heading)
            return sectionHeader
     }

     func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath as IndexPath) as! OrdersCell
          cell.selectionStyle = .none
          cell.viewBg.layer.cornerRadius = 0
          cell.viewBg.clipsToBounds = true
          cell.contentView.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
          cell.viewBg.layer.shadowColor = UIColor.black.cgColor
          cell.viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 0.3)
          cell.viewBg.layer.masksToBounds = false
          cell.viewBg.layer.shadowRadius = 0.2
          cell.viewBg.layer.shadowOpacity = 0.3
            
          cell.moreDetail.layer.cornerRadius = 14
          cell.moreDetail.layer.borderWidth = 1.4
          cell.moreDetail.layer.borderColor = UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0,alpha:1.0).cgColor
          cell.moreDetail.clipsToBounds = true
          cell.moreDetail.titleLabel?.textColor = UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0,alpha:1.0)
          cell.moreDetail.titleLabel?.font = UIFont(name:"Arial",size:12.0)
            
          if let dict = self.arrayOrderList[indexPath.row] as? NSDictionary {
             let fld_order_qty = dict.value(forKey: "fld_order_qty") as? Int ?? 0
             let order_status = dict.value(forKey: "order_status") as? Int ?? 0
             let fld_order_date = dict.value(forKey: "fld_order_date") as? String ?? ""
             let fld_suborder_id = dict.value(forKey: "fld_suborder_id") as? String ?? ""
             let price = dict.value(forKey: "price") as? Int ?? 0
          
             cell.quantity.text = "Qty: \(fld_order_qty)"
             cell.price.text = "Price: \(price)"
             cell.orderNo.text = "Order No. \(fld_suborder_id)"
             cell.supplierName.text = "Supplier: \("fashion")"
            cell.date.text = CommonMethods.sharedInstance.getDateInNotificationString(fld_order_date)
           }
//            cell.btnEddit.addTarget(self, action: #selector(btnEddit), for: .touchUpInside)
//            cell.btnEddit.tag = indexPath.row
//            cell.btnDelete.addTarget(self, action: #selector(btnDelete), for: .touchUpInside)
//            cell.btnCheckUnckeck.addTarget(self, action: #selector(btnCheckUnckeck), for: .touchUpInside)
//            cell.btnCheckUnckeck.tag = indexPath.row
//            cell.btnDelete.tag = indexPath.row
            
//             if array_selecteditems.contains(self.arrayAddressList[indexPath.row] ) {
//                 cell.btnCheckUnckeck.layer.borderWidth = 1
//                 cell.btnCheckUnckeck.layer.borderColor = UIColor.darkGray.cgColor
//                 cell.btnCheckUnckeck.backgroundColor = .blue
//                 cell.btnCheckUnckeck.setImage(UIImage(named: "selectedCheckboxTick"), for: .normal)
//             } else {
//                 cell.btnCheckUnckeck.backgroundColor = .clear
//                 cell.btnCheckUnckeck.layer.borderWidth = 1
//                 cell.btnCheckUnckeck.layer.borderColor = UIColor.darkGray.cgColor
//             }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
            
        }
        
        @objc func btnEddit(sender: UIButton!) {
            //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
            //self.navigationController?.pushViewController(VC, animated: true)
            let index = sender.tag
//          if let dict = self.arrayAddressList[index] as? NSDictionary {
//             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//             if let vc = storyBoard.instantiateViewController(withIdentifier: "AddNewAddressController") as? AddNewAddressController {
//                vc.dictData = dict as! NSMutableDictionary
//                vc.screenMode = 2
//                self.navigationController?.pushViewController(vc, animated: true)
//             }
//          }
        }
    
    func callOrderListApi() {
  
        let json = [
                    "fld_user_id":getUserID(),
                    "fld_order_type":0,
                    "fld_page_no":0
         ] as [String : Any]
         print("Detail json: ", json)
         //DIProgressHud.show()
         postMyOrderAPIAction(WebService.order_list, parameters: json, showGenricErrorPopup: false) { (response) in
         print("order_list:", response ?? "")
         DispatchQueue.main.async {
          // DIProgressHud.hide()
         }
            
         if let status = response?.object(forKey: "status") as? Bool, status == true {
            DispatchQueue.main.async {
            let message = response?["message"] as? String
               self.arrayOrderList.removeAllObjects()
                if let dataArray = response?.object(forKey: "order_data") as? NSArray, dataArray.count > 0 {
                  self.arrayOrderList = dataArray as! NSMutableArray
               }
            }
          }
          
           DispatchQueue.main.async {
            self.tableViewList.reloadData()
           }
        }
    }
}
