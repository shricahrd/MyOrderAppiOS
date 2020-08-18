//
//  CheckoutVC.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController  {
    var arrayData = ["Invite Friends", "Fantasy Point System", "How to Play", "HelpDesk","About Us"]
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    @IBOutlet var tableMain: UITableView!
    @IBOutlet var btnPlaceOrder: UIButton!
    
    enum TableSection {
        static let shiipingAddress = 0
        static let productSummary = 1
        static let totalAmount = 2
        static let count = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true
        btnPlaceOrder.layer.cornerRadius = 15
        btnPlaceOrder.clipsToBounds = true
        self.registerNib()
    }
    
    func registerNib() {
         tableMain.register(UINib(nibName: "CheckOutCell", bundle: nil), forCellReuseIdentifier: "CheckOutCell")
         tableMain.delegate = self
         tableMain.dataSource = self
         tableMain.separatorStyle = .none
         tableMain.register(UINib(nibName: "SummaryAmountCell", bundle: nil), forCellReuseIdentifier: "SummaryAmountCell")
         tableMain.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
         tableMain.register(UINib(nibName: "TotalQuantityCell", bundle: nil), forCellReuseIdentifier: "TotalQuantityCell")
         tableMain.register(UINib(nibName: "SummaryCell", bundle: nil), forCellReuseIdentifier: "SummaryCell")
    }

    @IBAction func clickBtnBACK(_ sender: Any) {
        
    }
    
    @IBAction func clickBtnPlaceOrder(_ sender: Any) {
        
    }
    
}
extension CheckoutVC:UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TableSection.shiipingAddress {
            return 1
        } else if section == TableSection.productSummary {
            return 4
        } else {
            return 4
        }
    }
       
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == TableSection.productSummary {
           return 35
        } else {
           return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == TableSection.productSummary {
            return 40
        } else if section == TableSection.shiipingAddress {
            return 40
        } else if section == TableSection.totalAmount {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 35)
        sectionHeader.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        let heading = UILabel()
        heading.frame = CGRect(x: 16, y: 5, width: tableView.frame.size.width-32, height: 25)
        if section == TableSection.shiipingAddress {
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
        if indexPath.section == TableSection.shiipingAddress {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOutCell", for: indexPath) as? CheckOutCell {
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                cell.changeButton.tag = indexPath.row
                cell.changeButton.addTarget(self, action: #selector(self.contactUs), for: UIControl.Event.touchUpInside)
                cell.viewBg.layer.cornerRadius = 6
                cell.viewBg.clipsToBounds = true
                return cell
            }
        } else if indexPath.section == TableSection.productSummary {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryAmountCell", for: indexPath) as? SummaryAmountCell {
               cell.selectionStyle = .none
               cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
               cell.viewBg.backgroundColor = .clear
              
               cell.itemName.text = "PullOver"
               cell.amoutQty.text = "10"
               cell.price.text = "1440"
                
               return cell
             }
            
        } else if indexPath.section == TableSection.totalAmount {
            if indexPath.section == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell {
                   cell.selectionStyle = .none
                   cell.contentView.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                
                   return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "TotalQuantityCell", for: indexPath) as? TotalQuantityCell {
                           cell.selectionStyle = .none
                           cell.contentView.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                                          // cell.viewBg.backgroundColor = UIColor(red:248.0 / 255.0, green:248.0 / 255.0, blue:248.0 / 255.0, alpha: 1.0)
                           cell.amountHeader.text = "Total Quantity:"
                           cell.totalPrice.text = "4888"
                             
                           return cell
                         }
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
    
    @objc func contactUs(_ sender: UIButton) {
        
    }
    
    
    @objc func requestCancel(_ sender: UIButton) {
      
    }

    @objc func clickPayNaow(sender: UIButton!) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
//        self.navigationController?.pushViewController(VC, animated: true)
    }
   
    }
   

