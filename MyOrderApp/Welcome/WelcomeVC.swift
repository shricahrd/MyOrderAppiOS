//  WelcomeVC.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
import SVProgressHUD

class WelcomeVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource{

    
    
    var screenSize: CGRect = UIScreen.main.bounds
      var screenWidth: CGFloat = 0.0
      var screenHeight: CGFloat = 0.0
    var scrollViewMain: UIScrollView!
    var viewBG: UIView!
    var btnManufacture: UIButton!
    var btnDistributor: UIButton!
    var btnRetailer: UIButton!
    var btnStockist: UIButton!
    var btnSalesAgent: UIButton!
    var btnGetStarted: UIButton!
    
    var viewBottomBG: UIView!
    var selectLoginType = ""
    
    var btnAlreadyHaveAccount: UIButton!
    var btnSignIn: UIButton!
    
    var tableViewList = UITableView()
    var arrayCategory = NSMutableArray()
    var array_temp:NSMutableArray!
    var str_id:NSMutableString!
    var array_selecteditems = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height

        array_temp = NSMutableArray()
        array_selecteditems = NSMutableArray()

        arrayCategory.removeAllObjects()
        let dict =  [
            "title": "MANUFACTURER",
            "type": "1" ]
        arrayCategory.add(dict)
        
        let dict1 = [
            "title": "DISTRIBUTOR",
            "type": "2" ]
        arrayCategory.add(dict1)
        
        let dict2 =  [
            "title": "RETAILER",
            "type": "3" ]
        arrayCategory.add(dict2)
        
        let dict3 = [
            "title": "STOCKLIST",
            "type": "4" ]
        arrayCategory.add(dict3)
        
        let dict4 = [
            "title": "SALES AGENT",
            "type": "5" ]
        arrayCategory.add(dict4)

        self.uiSetUp()
    }
    
    func uiSetUp() {
     scrollViewMain = UIScrollView()
     scrollViewMain.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
     scrollViewMain.bounces = true
     scrollViewMain.delegate = self
     scrollViewMain.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
     view.addSubview(scrollViewMain)
    
        
        print("screenWidth:", screenWidth)
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
    
     let imageLogo = UIImageView()
     imageLogo.frame = CGRect(x: screenWidth/2-22, y: 80, width:  45, height: 45)
     imageLogo.image = UIImage(named: "menuBag")
     imageLogo.contentMode =  .scaleAspectFit
     imageLogo.backgroundColor = .clear;
     imageLogo.clipsToBounds = true
     viewBG.addSubview(imageLogo)
                
     let welcomeTitle = UILabel()
     welcomeTitle.frame = CGRect(x: 16, y: imageLogo.frame.maxY + 8, width: screenWidth-32, height: 30);
     welcomeTitle.text = "Welcome";
     welcomeTitle.textColor = .white
     welcomeTitle.textAlignment = .center
     welcomeTitle.font = UIFont.boldSystemFont(ofSize: 26.0)
     viewBG.addSubview(welcomeTitle)
    
     let chooseTitle = UILabel()
     chooseTitle.frame = CGRect(x: 16, y: welcomeTitle.frame.maxY + 30, width: screenWidth-32, height: 30);
     chooseTitle.text = "Choose your Role for Sign up";
     chooseTitle.textColor = .white
     chooseTitle.textAlignment = .center
     chooseTitle.font = UIFont.boldSystemFont(ofSize: 12.0)
     viewBG.addSubview(chooseTitle)
      
        
     tableViewList = UITableView()
     tableViewList.frame = CGRect(x: 0, y: chooseTitle.frame.maxY, width: screenWidth, height: viewBG.frame.size.height - (chooseTitle.frame.maxY + 70))
     tableViewList.backgroundColor = .yellow
     tableViewList.delegate = self
     tableViewList.dataSource = self
     tableViewList.separatorStyle = .none
     tableViewList.keyboardDismissMode = .interactive
     tableViewList.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
     viewBG.addSubview(tableViewList)
     self.registerNib()
        

//     btnManufacture = UIButton()
//     btnManufacture.frame = CGRect(x: 36, y: chooseTitle.frame.maxY + 8, width: screenWidth - 72, height: 45)
//     btnManufacture.backgroundColor = .clear
//     btnManufacture.setTitle("MANUFACTURER", for: .normal)
//     btnManufacture.setTitleColor(.black, for: .normal)
//     btnManufacture.layer.borderWidth = 0
//     btnManufacture.layer.cornerRadius = 21
//     btnManufacture.clipsToBounds = true
//     btnManufacture.backgroundColor = .white
//     btnManufacture.addTarget(self,action:#selector(self.btnManufacture(_:)),for: UIControl.Event.touchUpInside)
//     btnManufacture.isUserInteractionEnabled = true
//     viewBG.addSubview(btnManufacture)
//
//     btnDistributor = UIButton()
//     btnDistributor.frame = CGRect(x: 36, y: btnManufacture.frame.maxY + 8, width: screenWidth - 72, height: 45)
//     btnDistributor.backgroundColor = .clear
//     btnDistributor.setTitle("DISTRIBUTOR", for: .normal)
//     btnDistributor.setTitleColor(.black, for: .normal)
//     btnDistributor.layer.borderWidth = 0
//     btnDistributor.layer.cornerRadius = 21
//     btnDistributor.clipsToBounds = true
//     btnDistributor.backgroundColor = .white
//     btnDistributor.addTarget(self,action:#selector(self.btnDistributor(_:)),for: UIControl.Event.touchUpInside)
//     btnDistributor.isUserInteractionEnabled = true
//     viewBG.addSubview(btnDistributor)
//
//    btnRetailer = UIButton()
//    btnRetailer.frame = CGRect(x: 36, y: btnDistributor.frame.maxY + 8, width: screenWidth - 72, height: 45)
//    btnRetailer.backgroundColor = .clear
//    btnRetailer.setTitle("RETAILER", for: .normal)
//    btnRetailer.setTitleColor(.black, for: .normal)
//    btnRetailer.layer.borderWidth = 0
//    btnRetailer.layer.cornerRadius = 21
//    btnRetailer.clipsToBounds = true
//    btnRetailer.backgroundColor = .white
//    btnRetailer.addTarget(self,action:#selector(self.btnRetailer(_:)),for: UIControl.Event.touchUpInside)
//    btnRetailer.isUserInteractionEnabled = true
//    viewBG.addSubview(btnRetailer)
//
//    btnStockist = UIButton()
//    btnStockist.frame = CGRect(x: 36, y: btnRetailer.frame.maxY + 8, width: screenWidth - 72, height: 45)
//    btnStockist.backgroundColor = .clear
//    btnStockist.setTitle("STOCKLIST", for: .normal)
//    btnStockist.setTitleColor(.black, for: .normal)
//    btnStockist.layer.borderWidth = 0
//    btnStockist.layer.cornerRadius = 21
//    btnStockist.clipsToBounds = true
//    btnStockist.backgroundColor = .white
//    btnStockist.addTarget(self,action:#selector(self.btnStockist(_:)),for: UIControl.Event.touchUpInside)
//    btnStockist.isUserInteractionEnabled = true
//    viewBG.addSubview(btnStockist)
//
//    btnSalesAgent = UIButton()
//    btnSalesAgent.frame = CGRect(x: 36, y: btnStockist.frame.maxY + 8, width: screenWidth - 72, height: 45)
//    btnSalesAgent.backgroundColor = .clear
//    btnSalesAgent.setTitle("SALES AGENT", for: .normal)
//    btnSalesAgent.setTitleColor(.black, for: .normal)
//    btnSalesAgent.layer.borderWidth = 0
//    btnSalesAgent.layer.cornerRadius = 21
//    btnSalesAgent.clipsToBounds = true
//    btnSalesAgent.backgroundColor = .white
//    btnSalesAgent.addTarget(self,action:#selector(self.btnSalesAgent(_:)),for: UIControl.Event.touchUpInside)
//    btnSalesAgent.isUserInteractionEnabled = true
//    viewBG.addSubview(btnSalesAgent)
        
        viewBG.layer.cornerRadius = 35
        
//        btnManufacture.layer.cornerRadius = 12
//        btnManufacture.clipsToBounds = true
//        btnDistributor.layer.cornerRadius = 12
//        btnDistributor.clipsToBounds = true
//        btnRetailer.layer.cornerRadius = 12
//        btnRetailer.clipsToBounds = true
//        btnStockist.layer.cornerRadius = 12
//        btnStockist.clipsToBounds = true
//        btnSalesAgent.layer.cornerRadius = 12
//        btnSalesAgent.clipsToBounds = true
        
        btnGetStarted = UIButton()
        btnGetStarted.frame = CGRect(x: screenWidth/2-100, y: tableViewList.frame.maxY + 50, width: 200, height: 45)
        btnGetStarted.backgroundColor = .clear
        btnGetStarted.setTitle(" GET STARTED   ->", for: .normal)
        btnGetStarted.setTitleColor(.white, for: .normal)
        btnGetStarted.layer.borderWidth = 0
        btnGetStarted.layer.cornerRadius = 21
        btnGetStarted.clipsToBounds = true
        btnGetStarted.backgroundColor = .red
        btnGetStarted.addTarget(self,action:#selector(self.clickGetStarted(_:)),for: UIControl.Event.touchUpInside)
        btnGetStarted.isUserInteractionEnabled = true
        viewBG.addSubview(btnGetStarted)
        
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
        btnAlreadyHaveAccount.addTarget(self,action:#selector(self.clickAlreadyHaveAccount(_:)),for: UIControl.Event.touchUpInside)
        btnAlreadyHaveAccount.isUserInteractionEnabled = true
        viewBottomBG.addSubview(btnAlreadyHaveAccount)
        
        btnSignIn = UIButton()
        btnSignIn.frame = CGRect(x: btnAlreadyHaveAccount.frame.maxX+1, y: 0, width: viewBottomBG.frame.size.width - (btnAlreadyHaveAccount.frame.maxX+1), height: 50)
        btnSignIn.backgroundColor = .clear
        btnSignIn.setTitle("Sign In", for: .normal)
        btnSignIn.setTitleColor(.red, for: .normal)
        btnSignIn.titleLabel?.font = UIFont(name:"Arial",size:10.0)
        btnSignIn.titleLabel?.textAlignment = .left
        btnSignIn.addTarget(self,action:#selector(self.btnSignIn(_:)),for: UIControl.Event.touchUpInside)
        btnSignIn.isUserInteractionEnabled = true
        viewBottomBG.addSubview(btnSignIn)
        self.scrollViewMain.contentSize = CGSize(width: 0, height: viewBottomBG.frame.maxY + 400)
    }
    
    func registerNib() {
         tableViewList.register(UINib(nibName: "WelcomeCell", bundle: nil), forCellReuseIdentifier: "WelcomeCell")
         tableViewList.delegate = self
         tableViewList.dataSource = self
         tableViewList.separatorStyle = .none
         tableViewList.backgroundColor = .clear
    }
    
    // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
            
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
         
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
         
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
         
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeCell", for: indexPath) as? WelcomeCell {
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0, alpha: 1.0)
                cell.viewBG.backgroundColor = .white
                cell.viewBG.layer.cornerRadius = 12
                cell.viewBG.clipsToBounds = true
                if let dict = self.arrayCategory[indexPath.row] as? NSDictionary {
                    let titleText = dict.value(forKey: "title") as? String ?? ""
                    cell.title.text = titleText
                }
                if array_selecteditems.contains(self.arrayCategory[indexPath.row] ) {
                   cell.viewBG.backgroundColor = UIColor.lightGray
                } else {
                   cell.viewBG.backgroundColor = UIColor.white
                }
                return cell
            }
             return UITableViewCell()
        
    }
    
    @objc func selectedAction(_ sender: UIButton) {
         let tag = sender.tag
         if !array_selecteditems.contains(self.arrayCategory[tag]) {
            array_selecteditems.add(self.arrayCategory[tag])
         } else {
            array_selecteditems.remove(self.arrayCategory[tag])
         }
         array_temp = array_selecteditems
        
         print("array_temp:", array_temp ?? 0)
    }
    
         
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        tableView.deselectRow(at: indexPath, animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        array_selecteditems.removeAllObjects()
        if !array_selecteditems.contains(self.arrayCategory[indexPath.row]) {
            array_selecteditems.add(self.arrayCategory[indexPath.row])
        } else {
           array_selecteditems.remove(self.arrayCategory[indexPath.row])
        }
        
         if let dict = self.arrayCategory[indexPath.row] as? NSDictionary {
            let type = dict.value(forKey: "type") as? String ?? ""
            selectLoginType = type
         }
        
        print("selectLoginType:", selectLoginType)
        self.tableViewList.reloadData()
        
     //        if indexPath.section == TableSection.viewAttachedPresc {
     //            let storyboard = UIStoryboard(name:"Assessments", bundle: Bundle.main)
     //            let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "attachedPrescriptionListController") as! AttachedPrescriptionListController
     //            attachedPrescriptionListController.orderId = orderId
     //            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
     //        }
    }
    @objc func btnManufacture(_ sender: AnyObject!) {
          selectLoginType = "1"
    }
    
    @objc func btnDistributor(_ sender: AnyObject!) {
          selectLoginType = "2"
    }
    
    @objc func btnRetailer(_ sender: AnyObject!) {
          selectLoginType = "3"
    }
    
    @objc func btnStockist(_ sender: AnyObject!) {
          selectLoginType = "4"
    }
    
    @objc func btnSalesAgent(_ sender: AnyObject!) {
          selectLoginType = "5"
    }

    @objc func btnSignIn(_ sender: AnyObject!) {
        if selectLoginType == "" {
            Utility.showAlert(withMessage: "Please choose role first", onController: self)
        } else if selectLoginType == "1"{
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                attachedPrescriptionListController.catagaryLogin = "1"
                attachedPrescriptionListController.loginType = .MANUFACTURER
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
        } else if selectLoginType == "2"{
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                attachedPrescriptionListController.catagaryLogin = "2"

                attachedPrescriptionListController.loginType = .DISTRIBUTOR
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
        } else if selectLoginType == "3"{
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                attachedPrescriptionListController.catagaryLogin = "3"

                attachedPrescriptionListController.loginType = .RETAILER
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
        } else if selectLoginType == "4"{
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                attachedPrescriptionListController.catagaryLogin = "4"

                
                attachedPrescriptionListController.loginType = .STOCKIST
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
        } else if selectLoginType == "5"{
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                attachedPrescriptionListController.catagaryLogin = "5"

                attachedPrescriptionListController.loginType = .SALESAGENT
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
        }
    }
    
    @objc func clickAlreadyHaveAccount(_ sender: AnyObject!) {
           
    }
    
    @objc func clickOnGoToCart(_ sender: AnyObject!) {
        
    }
   
    @objc func clickGetStarted(_ sender: AnyObject!) {
//                if selectLoginType == "" {
//
//                           Utility.showAlert(withMessage: "Please choose role first", onController: self)
//
//                } else if selectLoginType == "1" {
//
//                    let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//                    if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//                        attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.ManuFactursReg
//
//
//                        self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//                    }
//                } else if selectLoginType == "2" {
//
//                    let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//                    if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//                        attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Distributor
//
//
//                        self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//                    }
//
//                } else  if selectLoginType == "3" {
//
//                    let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//                    if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//                        attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Retailer
//
//
//                        self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//                    }
//                } else if selectLoginType == "4" {
//
//                    let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//                    if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//                        attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Stocker
//
//
//                        self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//                    }
//
//
//                }else if selectLoginType == "5" {
//
//                    let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//                    if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
//                        attachedPrescriptionListController.catagaryLogin = "5"
//
//                        attachedPrescriptionListController.loginType = .SALESAGENT
//                        self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//                    }
//                }
//
                
               // let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        //        if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
        //           self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
        //        }
          
      }

    
    
    
//    @IBAction func btnSignIn(_ sender: Any) {
//
//
//        if selectLoginType == "" {
//
//            Utility.showAlert(withMessage: "Please choose role first", onController: self)
//
//        } else if selectLoginType == "1"{
//            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
//                attachedPrescriptionListController.catagaryLogin = "1"
//
//                attachedPrescriptionListController.loginType = .MANUFACTURER
//                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//            }
//
//        } else if selectLoginType == "2"{
//            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
//                attachedPrescriptionListController.catagaryLogin = "2"
//
//                attachedPrescriptionListController.loginType = .DISTRIBUTOR
//                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//            }
//
//        } else if selectLoginType == "3"{
//            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
//                attachedPrescriptionListController.catagaryLogin = "3"
//
//                attachedPrescriptionListController.loginType = .RETAILER
//                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//            }
//
//        } else if selectLoginType == "4"{
//            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
//                attachedPrescriptionListController.catagaryLogin = "4"
//
//
//                attachedPrescriptionListController.loginType = .STOCKIST
//                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//            }
//
//        } else if selectLoginType == "5"{
//            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
//                attachedPrescriptionListController.catagaryLogin = "5"
//
//                attachedPrescriptionListController.loginType = .SALESAGENT
//                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//            }
//
//        }
//    }
    
}
