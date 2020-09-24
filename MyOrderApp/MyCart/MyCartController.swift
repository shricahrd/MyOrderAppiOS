//
//  MyCartController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 15/07/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit
typealias CompletionBlock = (_ success: Bool) -> Void
class MyCartController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, UITextFieldDelegate {
var arrayData = ["Invite Friends", "Fantasy Point System", "How to Play", "HelpDesk","About Us"]
var screenSize:CGRect = UIScreen.main.bounds
var screenWidth:CGFloat = 0.0
var screenHeight:CGFloat = 0.0
@IBOutlet var tableViewList: UITableView!
@IBOutlet var checkoutButton: UIButton!
var arrayAddressList = NSMutableArray()
var selectedSection = 0
var tableHeight: CGFloat = 0.0
var collectionWidth: CGFloat = 0.0
var collectionHeight: CGFloat = 0.0
var couponText = ""
enum TableSection {
    static let productDetail = 0
    static let color = 1
    static let sizes = 2
    static let quantity = 3
    static let totalquantity = 4
    static let count = 5
 }
  var arrayList = NSMutableArray()
  var arrayColorSizeList = NSMutableArray()
  var scrollViewMain = UIScrollView()
  override func viewDidLoad() {
      super.viewDidLoad()
      self.screenWidth = screenSize.width
      self.screenHeight = screenSize.height
      self.navigationController?.isNavigationBarHidden = true
       selectedSection = -1
      self.registerNib()
  }
    
  func registerNib() {
    
    scrollViewMain.frame = CGRect(x: 0, y: 75, width: screenWidth, height: screenHeight-75);
    scrollViewMain.bounces = true
    scrollViewMain.delegate = self
    scrollViewMain.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
   //view.addSubview(scrollViewMain)
    tableViewList.register(UINib(nibName: "AmountCell", bundle: nil), forCellReuseIdentifier: "AmountCell");
    tableViewList.register(UINib(nibName: "NumberOfSizesCell", bundle: nil), forCellReuseIdentifier: "NumberOfSizesCell");
    tableViewList.register(UINib(nibName: "productSizesHeader", bundle: nil), forCellReuseIdentifier: "productSizesHeader");
    tableViewList.register(UINib(nibName: "CartColorCell", bundle: nil), forCellReuseIdentifier: "CartColorCell");
      
    let nib = UINib(nibName: "CartListCell", bundle: nil)
    tableViewList.register(nib, forHeaderFooterViewReuseIdentifier: "CartListCell")
    tableViewList.register(UINib(nibName: "AmountCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "AmountCell")
    tableViewList.register(UINib(nibName: "NetAmountCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "NetAmountCell")

    tableViewList.delegate = self
    tableViewList.dataSource = self
    tableViewList.separatorStyle = .none
    checkoutButton.layer.cornerRadius = 24
    checkoutButton.clipsToBounds = true
//  self.scrollViewMain.contentSize = CGSize(width: 0, height: tableViewList.frame.maxY + 200)
    self.apiCartList()
    self.callUISetUpHeader()
    
    
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
//                btnCart.addTarget(self,action:#selector(self.clickOnCart(_:)),for: UIControl.Event.touchUpInside)
                btnCart.isUserInteractionEnabled = true
//                viewHeaderBg.addSubview(btnCart)
         
                let viewUnLine = UIView()
                viewUnLine.frame = CGRect(x: 0, y: 75.0, width: screenWidth, height: 1.0);
                viewUnLine.backgroundColor = UIColor(red: 215.0 / 255.0, green: 215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
                viewUnLine.layer.shadowColor = UIColor.black.cgColor
                viewUnLine.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                viewUnLine.layer.masksToBounds = false
                viewUnLine.layer.shadowRadius = 1.0
                viewUnLine.layer.shadowOpacity = 0.5
                viewHeaderBg.addSubview(viewUnLine)
    }
    
    @objc func clickOnContinue(_ sender: AnyObject!) {
        for i in 0 ..< self.navigationController!.viewControllers.count {
            if(self.navigationController?.viewControllers[i].isKind(of: Home.self) == true){
               self.navigationController!.setNavigationBarHidden(false,animated: false)
               self.navigationItem.hidesBackButton = true
               self.navigationController?.popToViewController(self.navigationController!.viewControllers[i] as! Home, animated: true)
               break;
            }
         }
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func clickOnBack(_ sender: AnyObject!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkoutButton(_ sender: Any) {
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
                self.calladdresslistApi(array: self.arrayAddressList)
              }
           }
         } else {
            DispatchQueue.main.async {
              Utility.showAlert(withMessage: message, onController: self)
            }
          }
       }
    }
    
    func calladdresslistApi(array:NSMutableArray) {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddressVC") as? ShippingAddressVC {
           vc.arrayAddressList = array
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MyCartController:UITableViewDelegate, UITableViewDataSource {
    
    @objc func applyCoupon(_ sender: UIButton) {
//      let index = sender.tag
//      let indexSelected = NSNumber(value: index)
        if couponText.isEmpty || couponText == "" ||  couponText == " "{
            let alertController = UIAlertController(title: "", message: "Please enter your coupon.", preferredStyle:.alert)
            alertController.addAction(UIAlertAction(title:"Ok", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
            }));
           self.present(alertController, animated: true, completion: nil)
        } else {
            self.callApplyCoupon(strCoupon: couponText)
        }
    }
    
    @objc func deletePoduct(_ sender: UIButton) {
          let index = sender.tag
          let indexSelected = NSNumber(value: index)
          var product_id = ""
          if let dict = self.arrayList[Int(truncating: indexSelected)] as? NSDictionary {
             if let fld_product_id = dict.value(forKey: "fld_product_id") as? Int {
                product_id = "\(fld_product_id)"
             }
             if let fld_product_id = dict.value(forKey: "fld_product_id") as? String {
                product_id = "\(fld_product_id)"
             }
             let alertController = UIAlertController(title: "", message: "Are you sure you want to delete product?", preferredStyle:.alert)
             alertController.addAction(UIAlertAction(title:"No", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
             }));
             alertController.addAction(UIAlertAction(title:"Yes", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
                 self.callCartDeleteApi(fld_product_id: product_id)
             }));
            self.present(alertController, animated: true, completion: nil)
         }
     }
    
      @objc func removeProductButton(_ sender: UIButton) {
           let index = sender.tag
           let indexSelected = NSNumber(value: index)
           var product_id = ""
           var colorIdValue = ""
           if let dict = self.arrayList[Int(truncating: NSNumber(value: selectedSection))] as? NSDictionary {
            print("colorIdValue:", colorIdValue)
            if let arrayColorSizeList = dict["color_size_list"] as? NSArray {
               if let dict1 = arrayColorSizeList[0] as? NSDictionary {
                  if let colorid = dict1.value(forKey: "color_id") as? Int {
                     colorIdValue = "\(colorid)"
                  }
                }
            }
           if let fld_product_id = dict.value(forKey: "fld_product_id") as? Int {
              product_id = "\(fld_product_id)"
           }
           if let fld_product_id = dict.value(forKey: "fld_product_id") as? String {
              product_id = "\(fld_product_id)"
           }
            var price = ""
            var qty = ""
            var sizename = ""
            var sizeidValue = ""
            if let dict1 = self.arrayColorSizeList[Int(truncating: indexSelected)] as? NSDictionary {
             if let pricev = dict1.value(forKey: "price") as? Int {
                price = "\(pricev)"
             }
             if let pricev = dict1.value(forKey: "price") as? String {
                price = "\(pricev)"
             }
               if let qtyv = dict1.value(forKey: "qty") as? Int {
                  qty = "\(qtyv)"
               }
               if let qtyv = dict.value(forKey: "qty") as? String {
                  qty = "\(qtyv)"
               }
               if let size_id = dict1.value(forKey: "size_id") as? Int {
                  sizeidValue = "\(size_id)"
               }
               if let size_id = dict.value(forKey: "size_id") as? String {
                  sizeidValue = "\(size_id)"
               }
               if let size_namev = dict1.value(forKey: "size_name") as? String {
                 sizename = "\(size_namev)"
               }
                print("price",price)
                print("qty",qty)
                print("sizename",sizename)
           }
            self.callCartRemoveApi(fld_product_id: product_id, fld_size_id: "\(sizeidValue)", fld_color_id:colorIdValue)
          }
    }
    @objc func selectIndex(_ sender: UIButton) {
        let index = sender.tag
        let indexSelected = NSNumber(value: index)
        if sender.tag == selectedSection {
            collapseCells(atSection: index, withCallback: { success in
            })
        } else {
            if selectedSection >= 0 {
                collapseCells(atSection: selectedSection, withCallback: { success in
                    if success {
                        self.perform(#selector(self.expandCells(atSection:)), with: index, afterDelay: 0.0)
                    }
                })
            } else {
                expandCells(atSection:indexSelected)
            }
        }
    }
    
    func collapseCells(atSection section: Int, withCallback callback: CompletionBlock) {
        selectedSection = -1
//        self.arrayColorSizeList.removeAllObjects()
//        if let dict = arrayList[Int(truncating: NSNumber(value: section))] as? NSDictionary {
//                  print("dict:", dict)
//                  if let arrayColorSizeList = dict["color_size_list"] as? NSArray {
//                      if let dict1 = arrayColorSizeList[0] as? NSDictionary {
//                           if let arraySizeList = dict1["size_list"] as? NSArray {
//                              self.arrayColorSizeList.addObjects(from: arraySizeList as [AnyObject])
//                           }
//                      }
//                  }
//       }
//        print("self.arrayColorSizeList:", self.arrayColorSizeList)
        //tableHeight = CGFloat(3 * 50)
        tableViewList.beginUpdates()
//        tableViewList.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
        tableViewList.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        tableViewList.endUpdates()
        callback(true)
    }
    
    @objc func expandCells(atSection section: NSNumber) {
        self.arrayColorSizeList.removeAllObjects()
        if let dict = arrayList[Int(truncating: section)] as? NSDictionary {
            print("dict:", dict)
            if let arrayColorSizeList = dict["color_size_list"] as? NSArray {
                if let dict1 = arrayColorSizeList[0] as? NSDictionary {
                     if let arraySizeList = dict1["size_list"] as? NSArray {
                        let dict = [
                                  "title":""
                              ]
                        self.arrayColorSizeList.add(dict)
                        self.arrayColorSizeList.add(dict)
                        self.arrayColorSizeList.addObjects(from: arraySizeList as [AnyObject])
                     }
                }
            }
        }
        print("self.arrayColorSizeList:", self.arrayColorSizeList)
        selectedSection = Int(CInt(truncating: section))
        tableViewList.beginUpdates()
        tableViewList.reloadSections(NSIndexSet(index: Int(truncating: section)) as IndexSet, with: .automatic)
        tableViewList.endUpdates()
    }

      // MARK: - Tableview Method
       func numberOfSections(in tableView: UITableView) -> Int {
               return self.arrayList.count
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
           if (section == selectedSection) {
            return self.arrayColorSizeList.count
           }
           return 0
       }

       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 40
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          var height: Int = 50
          if arrayColorSizeList.count > 0 {
               if indexPath.row == 0 {
                   return 100
               }
               if indexPath.row == 1 {
                   return 50
               }
          }
           return CGFloat(height)
       }

       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           if section == self.arrayList.count - 1 {
              return 150
           } else if section == self.arrayList.count - 2 {
              return 150
           } else {
              return 200
           }
       }

       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.arrayList.count-2 == section {
                let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AmountCell") as! AmountCell
                cell.textFieldCoupon.delegate = self;
                cell.textFieldCoupon.layer.cornerRadius = 8
                cell.textFieldCoupon.layer.borderWidth = 1
                cell.textFieldCoupon.layer.borderColor = UIColor.lightGray.cgColor
                cell.textFieldCoupon.clipsToBounds = true;
          
                let paddingView_CurrentPwd:UIView=UIView()
                paddingView_CurrentPwd.frame=CGRect(x: 0,y: 0,width: 25,height: 20)
                let paddingRightView_CurrentPwd:UIView=UIView()
                paddingRightView_CurrentPwd.frame=CGRect(x: 0,y: 0,width: 70,height: 20)
                cell.textFieldCoupon.delegate = self
                cell.textFieldCoupon.textColor = UIColor.black
                cell.textFieldCoupon.leftView = paddingView_CurrentPwd
                cell.textFieldCoupon.rightView = paddingRightView_CurrentPwd
                cell.textFieldCoupon.placeholder = "Enter Coupon Code"
                cell.textFieldCoupon.tintColor = UIColor.black;
                cell.textFieldCoupon.font = UIFont(name:"Arial",size:15.0)
                cell.textFieldCoupon.backgroundColor = UIColor.white
                cell.textFieldCoupon.layer.cornerRadius = 24.0
                cell.textFieldCoupon.isSecureTextEntry = false
                cell.textFieldCoupon.leftViewMode = .always
                cell.textFieldCoupon.rightViewMode = .always
                cell.textFieldCoupon.tag = 100
                cell.textFieldCoupon.returnKeyType = .next
                cell.textFieldCoupon.keyboardType = UIKeyboardType.asciiCapable
                cell.applyButton.addTarget(self, action: #selector(self.applyCoupon), for: .touchUpInside)
                cell.applyButton.tag = section;
                return cell
            } else if self.arrayList.count-1 == section {
                        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NetAmountCell") as! NetAmountCell
                        return cell
            } else {
                 let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CartListCell") as! CartListCell
                 header.viewBg.backgroundColor = .white
                 header.viewBg.layer.masksToBounds = false
                 header.viewBg.layer.shadowRadius = 2.0
                 header.viewBg.layer.shadowColor = UIColor.clear.cgColor
                 header.viewBg.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                 header.viewBg.layer.shadowOpacity = 0.7
                 header.contentView.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
                 header.deleteButton.addTarget(self, action: #selector(self.deletePoduct), for: .touchUpInside);
                 header.deleteButton.tag = section;
                 if selectedSection == section {
                    header.dropDown.setImage(UIImage(named: "dropdowncart"), for: .normal)
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                      }, completion: nil)
                    } else {
                                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                                                  }, completion: nil)
                                                  header.dropDown.setImage(UIImage(named: "reminderRightArrow"), for: .normal)
                                         }
                                              header.dropDown.isUserInteractionEnabled = true
                                              header.dropDown.addTarget(self, action: #selector(self.selectIndex), for: .touchUpInside)
                                              header.dropDown.tag = section;
                                              if let dict = self.arrayList[section] as? NSDictionary {
                                                    if let imgString = dict.value(forKey: "default_image") as? String, let imageURL = URL(string: "\(imgString)") {
                                                       header.productimage.setImageWith(imageURL, placeholderImage:UIImage(named: "Banner"))
                                                    }
                                                    let fld_product_name = dict.value(forKey: "fld_product_name") as? String ?? ""
                                                    let fld_product_sku = dict.value(forKey: "fld_product_sku") as? String ?? ""
                                                    //let fld_product_qty = dict.value(forKey: "fld_product_qty") as? String ?? ""
                                                    header.productname.text = fld_product_name.capitalized;
                                                    header.brandname.text = fld_product_sku.uppercased()
                                                    
                                                
                                                    if let arrayColorSizeList = dict["color_size_list"] as? NSArray {
                                                       if let dict1 = arrayColorSizeList[0] as? NSDictionary {
                                                        var colorSizeQty = ""
                                                        let color_name = dict1.value(forKey: "color_name") as? String ?? ""
                                                        
                                                         if let color_size_qty = dict1.value(forKey: "color_size_qty") as? Int {
                                                            colorSizeQty = "\(color_size_qty)"
                                                         }
                                                         if let color_size_qty = dict1.value(forKey: "color_size_qty") as? String {
                                                             colorSizeQty = "\(color_size_qty)"
                                                         }
                                                        header.quantityValue.text = colorSizeQty
                                                        header.colorText.text = color_name
//
                                                        if let colorid = dict1.value(forKey: "color_id") as? Int {
//                                                             colorIdValue = "\(colorid)"
                                                          }
                                                       }
                                                  }
                            }
                          return header;
                    }
            return UIView();
      }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.arrayList.count > 0 {
            if (indexPath.section == selectedSection)  {
               if indexPath.row == 0 {
                  if let cell = tableView.dequeueReusableCell(withIdentifier: "CartColorCell") as? CartColorCell {
                                   return cell
                                }
                  }
                  if indexPath.row == 1 {
                               let cell = tableView.dequeueReusableCell(withIdentifier: "productSizesHeader") as! productSizesHeader
                               cell.remove.text = "Remove"
                               return cell
                  } else {
                                   if let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfSizesCell", for: indexPath) as? NumberOfSizesCell {
                                      cell.selectionStyle = .none
                                      cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                                    
                   //                   collectionWidth = cell.contentView.frame.size.width
                   //                   collectionHeight = cell.contentView.frame.size.height
                   //
                   //                   let layout = UICollectionViewFlowLayout()
                   //                   cell.collectionView.register(UINib(nibName: "ReminderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ReminderCollectionCell")
                   //                   cell.collectionView.reloadData()
                   //                   if layout != nil {
                   //                      cell.collectionView.collectionViewLayout = layout
                   //                      layout.scrollDirection = .vertical
                   //                   }
                   //                   cell.collectionView.dataSource = self
                   //                   cell.collectionView.delegate = self
                   //                   layout.minimumLineSpacing = 5
                   //                   cell.collectionView.showsVerticalScrollIndicator = false
                   //                   cell.collectionView.keyboardDismissMode = .interactive
                                       
                                       if let dict = self.arrayColorSizeList[indexPath.row] as? NSDictionary {
                                          let size_name = dict.value(forKey: "size_name") as? String ?? ""
                                          let qty = dict.value(forKey: "qty") as? String ?? ""
                                          let price = dict.value(forKey: "price") as? Int ?? 0
                                          cell.size.text = size_name
                                          cell.price.text = "\(price)"
                                          cell.qtyTextField.text = "\(qty)"
                                          cell.qtyTextField.textAlignment = .center
                                          cell.qtyTextField.delegate = self
                                      }
                                      cell.qtyTextField.layer.borderWidth = 1
                                      cell.qtyTextField.tag = indexPath.row;
                                      cell.qtyTextField.layer.borderColor = UIColor.lightGray.cgColor
                                      cell.qtyTextField.layer.cornerRadius = 4
                                      cell.removeButton.addTarget(self, action: #selector(self.removeProductButton), for: UIControl.Event.touchUpInside)
                                      cell.removeButton.tag = indexPath.row;
                                      return cell
                                }
                        }
                }
          }
          return UITableViewCell()
     }
        
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
     }
    
     // MARK:- Collection View Metods
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.arrayColorSizeList.count
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 1
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 1
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     }
     
     // Make a cell for each cell index path
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCollectionCell", for: indexPath) as! ReminderCollectionCell
         cell.viewBg.layer.borderWidth = 1
         cell.viewBg.layer.cornerRadius = 4
         cell.viewBg.layer.borderColor = UIColor(red: 4.0/255.0, green: 202.0/255.0, blue: 169.0/255.0, alpha: 1.0).cgColor
         let dateAsString = self.arrayColorSizeList[indexPath.row] as? String ?? ""
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "HH:mm"
         let date = dateFormatter.date(from: dateAsString)
         dateFormatter.dateFormat = "h:mm a"
         if date != nil {
             let date12 = dateFormatter.string(from: date!)
             print("12 hour formatted Date: ", date12)
             if date12 != "" {
                 cell.timeText.text = date12
             }
         }
         cell.timeText.font = UIFont(name: "Verdana", size: 15)
         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionWidth/3.2, height: 50)
     }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     }
     
     func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
     }

     @objc func dropDownButton(_ sender: UIButton) {
            
     }

     @objc func removeButton(_ sender: UIButton) {
        
     }
     
     @objc func requestCancel(_ sender: UIButton) {
       
     }

     @objc func clickPayNaow(sender: UIButton!) {
 //       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
 //       let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
 //       self.navigationController?.pushViewController(VC, animated: true)
     }
    
    func apiCartList() {
        let json = [
            "fld_user_id": getUserID(),
            ] as [String : Any]
        print("Detail json: ", json)
//        DIProgressHud.show()
        postMyOrderAPIAction(WebService.cart, parameters: json, showGenricErrorPopup: false) { (response) in
            print("response detail:", response ?? "")
            DispatchQueue.main.async {
//               DIProgressHud.hide()
            }
            self.arrayList.removeAllObjects()
            if let status = response?.object(forKey: "status") as? Bool, status == true {
                if let dataArray = response?["cart_data"] as? NSArray, dataArray.count > 0 {
                   self.arrayList = dataArray as! NSMutableArray
                    let dict =
                        [
                         "title":""
                        ]
                    self.arrayList.add(dict)
                    self.arrayList.add(dict)
                }
            }
            
            if self.arrayList.count == 0 {
                DispatchQueue.main.async {
                  self.checkoutButton.isHidden = true
                  self.createOrDisplayPlaceholder()
                  self.tableViewList.reloadData()
               }
            } else {
              self.checkoutButton.isHidden = false
                DispatchQueue.main.async {
                  self.hidePlaceholder()
                  self.tableViewList.reloadData()
                }
            }
          
        }
    }
    // MARK: - UI Create Place Holder
    func createOrDisplayPlaceholder() {
        if let placeHolder = view.viewWithTag(100) as? UILabel {
            placeHolder.isHidden = false
        } else {
            let placeHolder = UILabel()
            placeHolder.frame = CGRect(x: 10, y: 140, width: UIScreen.main.bounds.width-20,height: 200)
            let placeHolderText = "No Product in Cart."
            placeHolder.text = placeHolderText
            placeHolder.textColor = UIColor.darkText
            placeHolder.tag = 100
            placeHolder.numberOfLines = 0
            placeHolder.font = UIFont()
            placeHolder.font = UIFont.boldSystemFont(ofSize: 15)
            placeHolder.textAlignment = .center
            view.addSubview(placeHolder)
            
            let btnContinue = UIButton()
            btnContinue.frame = CGRect(x:36, y: screenHeight-100, width:  screenWidth-72, height: 45)
            btnContinue.backgroundColor = .clear
            btnContinue.setTitle("Continue Shopping", for: .normal)
            btnContinue.layer.cornerRadius = 22
            btnContinue.clipsToBounds = true
            btnContinue.backgroundColor = UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0, alpha: 1.0)
            btnContinue.addTarget(self,action:#selector(self.clickOnContinue(_:)),for: UIControl.Event.touchUpInside)
            btnContinue.isUserInteractionEnabled = true
            view.addSubview(btnContinue)
        }
    }
    
    // MARK: - UI Hide Place Holder
    
    func hidePlaceholder() {
        if let placeHolder = view.viewWithTag(100) as? UILabel {
            placeHolder.isHidden = true
        }
    }
    func callCallCartUpdate(fldproductid:String, fldsizeid: String, fldcolorid:String, fldproductqty: String) {
        let json = [
            "fld_user_id": getUserID(),
            "fld_action_type":2,
             "fld_product_id":fldproductid,
             "fld_size_id":fldsizeid,
            "fld_color_id":fldcolorid,
            "fld_product_qty":fldproductqty] as [String : Any]
        print("Detail json: ", json)
        postMyOrderAPIAction(WebService.cart_add_update, parameters: json, showGenricErrorPopup: false) { (response) in
                      print("response detail:", response ?? "")
                      DispatchQueue.main.async {
                         DIProgressHud.hide()
                      }
                      if let status = response?.object(forKey: "status") as? Bool, status == true {
                         DispatchQueue.main.async {
                            let message = response?["message"] as? String
                            let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
                            self.present(alert,animated:true, completion:nil)
                            let delay = 2.0 * Double(NSEC_PER_SEC)
                                    let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                                    DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                                        self.dismiss(animated: true, completion: {
                                        self.apiCartList()
                                        self.tableViewList.reloadData()
                                    });
                             }
                         }
                    } else {
                  }
         }
    }
   
    func callCartRemoveApi(fld_product_id:String,fld_size_id: String,fld_color_id:String )  {
         let json = [
             "fld_user_id":getUserID(),
             "fld_action_type":1,
             "fld_product_id":fld_product_id,
             "fld_size_id":fld_size_id,
             "fld_color_id":fld_color_id
             ] as [String : Any]
         print("Detail json: ", json)
//         DIProgressHud.show()
         postMyOrderAPIAction(WebService.cart_add_update, parameters: json, showGenricErrorPopup: false) { (response) in
             print("response detail:", response ?? "")
             DispatchQueue.main.async {
//                 DIProgressHud.hide()
             }
             if let status = response?.object(forKey: "status") as? Bool, status == true {
                DispatchQueue.main.async {
                     let message = response?["message"] as? String
                     let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
                             self.present(alert,animated:true, completion:nil)
                             let delay = 2.0 * Double(NSEC_PER_SEC)
                             let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                             DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                                 self.dismiss(animated: true, completion: {
                                 self.apiCartList()
                             });
                      }
                  }
                } else {
              }
         }
     }
    
    func callCartDeleteApi(fld_product_id:String)  {
        let json = [
            "fld_user_id":getUserID(),
            "fld_action_type":4,
            "fld_product_id": fld_product_id,
            ] as [String : Any]
        print("Detail json: ", json)
//        DIProgressHud.show()
        postMyOrderAPIAction(WebService.cart_add_update, parameters: json, showGenricErrorPopup: false) { (response) in
            print("response detail:", response ?? "")
            DispatchQueue.main.async {
//                DIProgressHud.hide()
            }
            if let status = response?.object(forKey: "status") as? Bool, status == true {
               DispatchQueue.main.async {
                    let message = response?["message"] as? String
                    let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
                            self.present(alert,animated:true, completion:nil)
                            let delay = 2.0 * Double(NSEC_PER_SEC)
                            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                            DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                                self.dismiss(animated: true, completion: {
                                self.apiCartList()
                            });
                     }
                 }
               } else {
             }
        }
    }
    
    func callApplyCoupon(strCoupon:String) {

        let json = [
                    "coupon_code":strCoupon,
                         "fld_user_id":getUserID()
                   ] as [String : Any]
               print("Detail json: ", json)
//               DIProgressHud.show()
               postMyOrderAPIAction(WebService.applyCoupon, parameters: json, showGenricErrorPopup: false) { (response) in
                   print("response detail:", response ?? "")
//                 DispatchQueue.main.async {
//                       DIProgressHud.hide()
//                 }"Error": 1,
               
//                "Msg": "Coupon code invalid",
                   if let status = response?.object(forKey: "Error") as? Bool, status == true {
                      DispatchQueue.main.async {
                           let message = response?["Msg"] as? String ?? ""
                           let alert = UIAlertController(title: "", message: message, preferredStyle:.alert)
                                   self.present(alert,animated:true, completion:nil)
                                   let delay = 2.0 * Double(NSEC_PER_SEC)
                                   let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                                   DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
                                       self.dismiss(animated: true, completion: {
//                                       self.apiCartList()
                                   });
                            }
                        }
                      } else {
                    }
               }
    }
    
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view!.endEditing(true)
        }

      func textField(_ textField:UITextField,shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
             if textField.isEditing==true {
                let substring=(textField.text! as NSString).replacingCharacters(in: range, with: string)
                print("substring: ", substring)
                couponText = "\(substring)"
//              let tagValue = textField.tag
             }
             return true
       }
        
       func textFieldDidBeginEditing(_ textField: UITextField) {
             
       }
         
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             textField.resignFirstResponder()
             return true;
       }

       func textFieldDidEndEditing(_ textField: UITextField) {
        
            let index = textField.tag
                        let indexSelected = NSNumber(value: index)
        //              print("tagValue:",tagValue)
                        var product_id = ""
                        var colorIdValue = ""
                        if let dict = self.arrayList[Int(truncating: NSNumber(value: selectedSection))] as? NSDictionary {
                            print("dict:", dict)
                        print("colorIdValue:", colorIdValue)
                                if let arrayColorSizeList = dict["color_size_list"] as? NSArray {
                                    if let dict1 = arrayColorSizeList[0] as? NSDictionary {
                                        if let colorid = dict1.value(forKey: "color_id") as? Int {
                                           colorIdValue = "\(colorid)"
                                        }
                                    }
                         }
                         if let fld_product_id = dict.value(forKey: "fld_product_id") as? Int {
                            product_id = "\(fld_product_id)"
                         }
                         if let fld_product_id = dict.value(forKey: "fld_product_id") as? String {
                            product_id = "\(fld_product_id)"
                         }

                            var sizeid = ""
                          if let dict1 = self.arrayColorSizeList[Int(truncating: indexSelected)] as? NSDictionary {
                            
                            print("dict1:", dict1)

                            if let size_id = dict1.value(forKey: "size_id") as? Int {
                                                   sizeid = "\(size_id)"
                           }
                            if let size_id = dict.value(forKey: "size_id") as? String {
                                 sizeid = "\(size_id)"
                              }
                         }
                            self.callCallCartUpdate(fldproductid: product_id, fldsizeid: "\(sizeid)", fldcolorid: "\(colorIdValue)", fldproductqty: "\(couponText)")
             }
            
       }
}
       

