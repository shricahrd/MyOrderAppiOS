//  WelcomeVC.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
import SVProgressHUD

class WelcomeVC: UIViewController {
    @IBOutlet var viewBG: UIView!
    @IBOutlet var btnManufacture: UIButton!
    @IBOutlet var btnDistributor: UIButton!
    @IBOutlet var btnRetailer: UIButton!
    @IBOutlet var btnStockist: UIButton!
    @IBOutlet var btnSalesAgent: UIButton!
    @IBOutlet var btnGetStarted: UIButton!
    
    
    var selectLoginType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBG.layer.cornerRadius = 35
        btnManufacture.layer.cornerRadius = 15
        btnManufacture.clipsToBounds = true
        btnDistributor.layer.cornerRadius = 15
        btnDistributor.clipsToBounds = true
        btnRetailer.layer.cornerRadius = 15
        btnRetailer.clipsToBounds = true
        btnStockist.layer.cornerRadius = 15
        btnStockist.clipsToBounds = true
        btnSalesAgent.layer.cornerRadius = 15
        btnSalesAgent.clipsToBounds = true
        btnGetStarted.layer.cornerRadius = 25
        btnGetStarted.clipsToBounds = true
    }
    
    @IBAction func btnGetStarted(_ sender: Any) {
        
        if selectLoginType == "" {
                   
                   Utility.showAlert(withMessage: "Please choose role first", onController: self)
                   
        } else if selectLoginType == "1" {
            
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.ManuFactursReg
                
                
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
            
        } else if selectLoginType == "2" {
            
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Distributor
                
                
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
        } else  if selectLoginType == "3" {
            
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Retailer
                
                
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
        } else if selectLoginType == "4" {
            
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Stocker
                
                
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
            
            
        }else if selectLoginType == "5" {
            
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                attachedPrescriptionListController.catagaryLogin = "5"
                
                attachedPrescriptionListController.loginType = .SALESAGENT
                self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
            }
        }
        
        
       // let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//        if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//           self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//        }
    }
    
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        
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
    
    
    
    
    @IBAction func btnManufacture(_ sender: Any) {
        
        selectLoginType = "1"
//        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//              if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//                  attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.ManuFactursReg
//
//
//                  self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//              }
        
    }
    
    
    @IBAction func btnDistributor(_ sender: Any) {
        selectLoginType = "2"

        
//        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//        if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//            attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Distributor
//
//
//            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//        }
      
        
        
    }
    
    @IBAction func btnRetailer(_ sender: Any) {
        selectLoginType = "3"

//        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//        if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//            attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Retailer
//
//
//            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//        }
    }
    
    @IBAction func btnStokist(_ sender: Any) {
        selectLoginType = "4"

//        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//        if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//            attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.Stocker
//
//
//            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//        }
        
    }
    
    
    @IBAction func btnSalesAgent(_ sender: Any) {
        
        selectLoginType = "5"

        
        
//        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//        if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
//            attachedPrescriptionListController.typesOfRegistation = TypesOfRegistation.RalesAgent
//
//
//            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//        }
        
    }
    
}
