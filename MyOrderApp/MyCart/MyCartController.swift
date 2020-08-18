//
//  MyCartController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 15/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class MyCartController: UIViewController {
var arrayData = ["Invite Friends", "Fantasy Point System", "How to Play", "HelpDesk","About Us"]
var screenSize:CGRect = UIScreen.main.bounds
var screenWidth:CGFloat = 0.0
var screenHeight:CGFloat = 0.0
@IBOutlet var tableViewList: UITableView!
    @IBOutlet var checkoutButton: UIButton!
    
enum TableSection {
    static let productDetail = 0
    static let color = 1
    static let sizes = 2
    static let quantity = 3
    static let totalquantity = 4
    static let count = 5
    
 }
    
 override func viewDidLoad() {
    super.viewDidLoad()
    self.screenWidth = screenSize.width
    self.screenHeight = screenSize.height
    self.navigationController?.isNavigationBarHidden = true
    self.registerNib()
 }
    
func registerNib() {
  tableViewList.register(UINib(nibName: "MyCartProductCell", bundle: nil), forCellReuseIdentifier: "MyCartProductCell")
   tableViewList.register(UINib(nibName: "productColorCell", bundle: nil), forCellReuseIdentifier: "productColorCell")
  tableViewList.register(UINib(nibName: "productSizesHeader", bundle: nil), forCellReuseIdentifier: "productSizesHeader")
  let nib = UINib(nibName: "productSizesHeader", bundle: nil)
       
  tableViewList.register(nib, forHeaderFooterViewReuseIdentifier: "productSizesHeader")
  tableViewList.register(UINib(nibName: "NumberOfSizesCell", bundle: nil), forCellReuseIdentifier: "NumberOfSizesCell")
  tableViewList.register(UINib(nibName: "ProductQuantityCell", bundle: nil), forCellReuseIdentifier: "ProductQuantityCell")
  tableViewList.register(UINib(nibName: "TotalProductQuantitiyCell", bundle: nil), forCellReuseIdentifier: "TotalProductQuantitiyCell")
  tableViewList.delegate = self
  tableViewList.dataSource = self
  tableViewList.separatorStyle = .none
  checkoutButton.layer.cornerRadius = 10
  checkoutButton.clipsToBounds = true
  
}
    @IBAction func checkoutButton(_ sender: Any) {
    }
}

extension MyCartController:UITableViewDelegate, UITableViewDataSource {
     // MARK: - TableView Delegate Methods
     func numberOfSections(in tableView: UITableView) -> Int {
         return TableSection.count
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == TableSection.productDetail {
             return 1
         } else if section == TableSection.color {
             return 1
         } else if section == TableSection.sizes {
             return 8
         } else if section == TableSection.quantity {
             return 1
         } else {
             return 1
         }
     }
        
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.section == TableSection.productDetail {
            return 35
         } else {
            return 35
         }
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
     }
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         if section == TableSection.productDetail {
             return 0
         } else if section == TableSection.color {
             return 0
         } else if section == TableSection.sizes {
             return 35
         }
         return 0
     }
     
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          switch section {
                case 0 :
                     return UIView()
                case 1 :
                     return UIView()
                case 2 :
                    let cell = tableView.dequeueReusableCell(withIdentifier: "productSizesHeader") as! productSizesHeader
                    return cell
                default:
                    let view1 = UIView.init()
                    return view1
                }
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.section == TableSection.productDetail {
             if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartProductCell", for: indexPath) as? MyCartProductCell {
                 cell.selectionStyle = .none
                 cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                 cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                 cell.imageproduct.image = UIImage(named: "imagegrid")
                 cell.deleteProduct.addTarget(self, action: #selector(self.deleteProduct), for: UIControl.Event.touchUpInside)
                 cell.deleteProduct.tag = indexPath.row
                 cell.viewBg.layer.cornerRadius = 6
                 cell.viewBg.clipsToBounds = true
                 cell.colorName.text = "Color"
                 cell.productColorName.text = "Dark Blue..."
                 cell.quantity.text = "25"
                 cell.dropDownButton.addTarget(self, action: #selector(self.dropDownButton), for: UIControl.Event.touchUpInside)
                 cell.dropDownButton.tag = indexPath.row
                 return cell
             }
         } else if indexPath.section == TableSection.color {
            
             if let cell = tableView.dequeueReusableCell(withIdentifier: "productColorCell", for: indexPath) as? productColorCell {
               cell.selectionStyle = .none
               cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
               cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                           
               cell.viewBg.layer.cornerRadius = 6
               cell.viewBg.clipsToBounds = true
               cell.color.text = "Color"
               cell.productColorName.text = "Dark Blue..."
               cell.quantity.text = "25"
               return cell
            }
             
         } else if indexPath.section == TableSection.sizes {
           if let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfSizesCell", for: indexPath) as? NumberOfSizesCell {
              cell.selectionStyle = .none
              cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
             cell.productSize.text = "XS"
             cell.productPrice.text = "750"
             cell.productQuantity.text = "25"
             cell.removeButton.addTarget(self, action: #selector(self.removeButton), for: UIControl.Event.touchUpInside)
             cell.removeButton.tag = indexPath.row
             return cell
            }
          } else if indexPath.section == TableSection.quantity {
           if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductQuantityCell", for: indexPath) as? ProductQuantityCell {
              cell.selectionStyle = .none
              cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
             cell.quantity.text = "75"
             cell.amount.text = "750"
             let paddingView_:UIView=UIView()
             paddingView_.frame=CGRect(x: 0,y: 0,width: 5,height: 10)
             let paddingRight:UIView=UIView()
             paddingRight.frame=CGRect(x: 0,y: 0,width: 20,height: 20)
             cell.textFieldEnterCoupon.delegate = self as? UITextFieldDelegate
             cell.textFieldEnterCoupon.textColor = UIColor.black
             cell.textFieldEnterCoupon.leftView = paddingView_
             cell.textFieldEnterCoupon.rightView = paddingRight
                   
             cell.textFieldEnterCoupon.tintColor = UIColor.black;
             cell.textFieldEnterCoupon.font = UIFont(name:"Arial",size:18.0)
             cell.textFieldEnterCoupon.backgroundColor = UIColor.white
             cell.textFieldEnterCoupon.layer.borderWidth = 0.6
             cell.textFieldEnterCoupon.layer.borderColor = UIColor.lightGray.cgColor
             cell.textFieldEnterCoupon.layer.cornerRadius = 6.0
             cell.textFieldEnterCoupon.isSecureTextEntry = true
             cell.textFieldEnterCoupon.leftViewMode = .always
             cell.textFieldEnterCoupon.rightViewMode = .always
             cell.textFieldEnterCoupon.tag = 100
             cell.textFieldEnterCoupon.returnKeyType = .next
             cell.textFieldEnterCoupon.keyboardType = UIKeyboardType.asciiCapable
             return cell
           }
          } else if indexPath.section == TableSection.totalquantity {
             if let cell = tableView.dequeueReusableCell(withIdentifier: "TotalProductQuantitiyCell", for: indexPath) as? TotalProductQuantitiyCell {
                  cell.selectionStyle = .none
             cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
             cell.totalQuantity.text = "75"
             cell.totalAmount.text = "750"
             cell.discountAmount.text = "150"
             cell.netAmount.text = "150"
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
     
     @objc func deleteProduct(_ sender: UIButton) {
         
     }
 
     @objc func dropDownButton(_ sender: UIButton) {
            
     }

     @objc func removeButton(_ sender: UIButton) {
        
     }
     
     @objc func requestCancel(_ sender: UIButton) {
       
     }

     @objc func clickPayNaow(sender: UIButton!) {
 //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
 //        let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
 //        self.navigationController?.pushViewController(VC, animated: true)
     }
    
     }
       

