//
//  SearchProductController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class SearchProductController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet var textFieldSearch: UITextField!
    @IBOutlet var tableViewList: UITableView!
    @IBOutlet var searchbutton: UIButton!
    @IBOutlet weak var cartCountLabel: UILabel!
    var arrayData = ["Brand", "Price: Low to High", "Price: High to Low"]
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var customPopUp: UIView!
    var tableviewPopUp: UITableView!
    var arraySelecteditems = NSMutableArray()
    var productName = ""
    var productArraya:[ProductDatum] = []
    var ary_UserList : [ProductDatum]?
    var ary_Search : [ProductDatum]?
    var arrayAfterSearch: [ProductSearchDatum]?
    var lbl_Msg:UILabel!
    var isSearch:Bool = false
    var strcartTotalCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true
        self.registerNib()
        
        let btnBack = UIButton()
        print("screenHeight:",screenHeight)
        if screenHeight == 896.0 || screenHeight == 812.0{
           btnBack.frame = CGRect(x:16, y: 45, width: 20, height: 20)
        } else {
           btnBack.frame = CGRect(x:16, y: 30, width: 20, height: 20)
        }
        btnBack.backgroundColor = .clear
        btnBack.setImage(UIImage(named: "backArrow"), for: .normal)
        btnBack.addTarget(self,action:#selector(self.clickOnBack(_:)),for: UIControl.Event.touchUpInside)
        btnBack.isUserInteractionEnabled = true
        self.view.addSubview(btnBack)
        
        
        textFieldSearch.layer.borderColor = UIColor.gray.cgColor
        textFieldSearch.layer.borderWidth = 1
        textFieldSearch.layer.cornerRadius = 25
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
        textFieldSearch.layer.cornerRadius = 22.0
        textFieldSearch.isSecureTextEntry = false
        textFieldSearch.leftViewMode = .always
        textFieldSearch.rightViewMode = .always
        textFieldSearch.tag = 100
        textFieldSearch.returnKeyType = .next
        textFieldSearch.keyboardType = UIKeyboardType.asciiCapable

        self.lbl_Msg = UILabel()
        self.lbl_Msg.frame = CGRect(x: 10,y: 176,width: self.tableViewList.frame.size.width-20,height: 45);
        self.lbl_Msg.text = " Product is not Available."
        self.lbl_Msg.textAlignment = NSTextAlignment.center
        self.lbl_Msg.textColor = UIColor.lightGray
        self.view.addSubview(self.lbl_Msg)
        
        self.cartCountLabel.layer.cornerRadius = self.cartCountLabel.frame.width/2
        self.cartCountLabel.clipsToBounds = true
        self.cartCountLabel.layer.borderColor = UIColor.white.cgColor
        self.cartCountLabel.layer.borderWidth = 2
        self.cartCountLabel.isHidden = true
        self.cartCountLabel.text = ""
        self.lbl_Msg.isHidden = true

        popUp()
        print("productName: ",  "\(productName)")
        profuct(fldBrandId: "", fldCatId: "2", fldUserId: "1", fldSearchTxt: "\(productName)", fldPageNo: 0, fldSortBy: "1")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController!.setNavigationBarHidden(true,animated: false)
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func clickOnBack(_ sender: AnyObject!) {
        self.navigationController!.setNavigationBarHidden(true,animated: false)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    func profuct(fldBrandId:String,fldCatId:String,fldUserId:String,fldSearchTxt:String,fldPageNo:Int,fldSortBy:String){
        ApiClient.loder(roughter: APIRouter.produNmae(fldBrandId: fldBrandId, fldCatCid: fldCatId, fldUserId: fldUserId, fldSearchTxt: fldSearchTxt, fldPageNo: fldPageNo, fldSortBy: fldSortBy)) { (product:ProductDetailesResponce) in
            print("\(product)")
//          var searchDoctorObject:ProductDetailesResponce?
            if product.status  == true {
                
                self.strcartTotalCount  =  product.cartTotalCount ?? 0
               //  self.strcartTotalCount = 2
                if self.strcartTotalCount > 0 {
                   self.cartCountLabel.isHidden = false
                   self.cartCountLabel.text = "\(self.strcartTotalCount)"
                } else {
                     self.cartCountLabel.isHidden = true
                }
                
                if product is Dictionary<String, Any> {
//                 searchDoctorObject = ProductDetailesResponce(from: dataDict as! Decoder)
                }
                self.ary_UserList = product.productData ?? []
                self.ary_Search = product.productData ?? []
//              self.productArraya.append(contentsOf: product.productData ?? [])
//              self.tableViewList.reloadData()
                if (self.ary_UserList ?? []).count > 0 {
                    DispatchQueue.main.async {
                       self.tableViewList.isHidden=false
                       self.lbl_Msg.isHidden=true
                    }
                     // self.setupSearchableContent()
                   } else {
                      DispatchQueue.main.async {
                        self.tableViewList.isHidden=true
                        self.lbl_Msg.frame=CGRect(x: 10,y: 176,width: self.tableViewList.frame.size.width-20,height: 45);
                        self.lbl_Msg.isHidden=false
                      }
                    }
                  DispatchQueue.main.async {
                    self.tableViewList .reloadData();
                  }
            }else {
                if (self.ary_UserList ?? []).count > 0 {
                                   DispatchQueue.main.async {
                                      self.tableViewList.isHidden=false
                                      self.lbl_Msg.isHidden=true
                                   }
                                   // self.setupSearchableContent()
                                  } else {
                                     DispatchQueue.main.async {
                                       self.tableViewList.isHidden=true
                                       self.lbl_Msg.frame=CGRect(x: 10,y: 176,width: self.tableViewList.frame.size.width-20,height: 45);
                                       self.lbl_Msg.isHidden=false
                                     }
                                   }
                                 DispatchQueue.main.async {
                                   self.tableViewList .reloadData();
                  }
//                Utility.showAlert(withMessage: product.message ?? "", onController: self)
            }
        }
    }
    
    
    func searchproduct(userId:String, SearchTxt:String) {
        ApiClient.loder(roughter: APIRouter.productsearch(userId: userId, SearchTxt: SearchTxt)) { (productSearch: ProductSearchResponce) in
            print("productSearch:", productSearch)
            var searchDoctorObject:ProductSearchResponce?
            if productSearch.status  == true {
              if let dataDict = productSearch as? Dictionary<String, Any> {
            //   searchDoctorObject = ProductDetailesResponce(from: dataDict as! Decoder)
              }
              self.arrayAfterSearch = productSearch.productSearchData ?? []
              print("self.arrayAfterSearch: ", self.arrayAfterSearch)
              self.isSearch = true
              if (self.arrayAfterSearch ?? []).count > 0 {
                  DispatchQueue.main.async {
                                   self.tableViewList.isHidden=false
                                   self.lbl_Msg.isHidden=true
                                }
                                // self.setupSearchableContent()
                               } else {
                                  DispatchQueue.main.async {
                                    self.tableViewList.isHidden=true
                                    self.lbl_Msg.frame=CGRect(x: 10,y: 176,width: self.tableViewList.frame.size.width-20,height: 45);
                                    self.lbl_Msg.isHidden=false
                                  }
                                }
                              DispatchQueue.main.async {
                                self.tableViewList .reloadData();
                              }
                        } else {
                            Utility.showAlert(withMessage: productSearch.message ?? "", onController: self)
                        }
        }
    }
    
    func wishlist_add_update(userId:String, productId:String, actionType:String) {
        ApiClient.loder(roughter: APIRouter.wishlistAddUpdate(userId: userId, productId: productId, actionType: actionType)) { (product:WishListAddUpdateResponce) in
            if product.status  == true {
                self.profuct(fldBrandId:"", fldCatId: "2", fldUserId: "1", fldSearchTxt: "", fldPageNo: 0, fldSortBy: "1")
            } else {
                 Utility.showAlert(withMessage: product.message ?? "", onController: self)
            }
        }
    }
    
    @IBAction func cartAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MyCartController") as? MyCartController {
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func registerNib() {
        tableViewList.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.separatorStyle = .none
    }
    
    func popUp()  {
        customPopUp = UIView()
        customPopUp.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        customPopUp.backgroundColor =  UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
        self.view.addSubview(customPopUp)
        customPopUp.isHidden = true
      
        let viewBg = UIView()
        viewBg.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
        viewBg.backgroundColor = UIColor.white
        viewBg.layer.cornerRadius = 35
        viewBg.clipsToBounds = true
        customPopUp.addSubview(viewBg)
        
        let title: UILabel! = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: viewBg.frame.size.width, height: 50)
        title.text = "Sort by"
        title.numberOfLines = 1
        title.backgroundColor = .clear
        title.textAlignment = .center
        title.textColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 16)
        viewBg.addSubview(title)
        
        tableviewPopUp = UITableView()
        tableviewPopUp.frame = CGRect(x: 0, y: title.frame.maxY, width: viewBg.frame.size.width, height: viewBg.frame.height - (title.frame.maxY))
        tableviewPopUp.backgroundColor = .clear
        tableviewPopUp.delegate = self
        tableviewPopUp.dataSource = self
        tableviewPopUp.separatorStyle = .none
        tableviewPopUp.register(UINib(nibName: "popCell", bundle: nil), forCellReuseIdentifier: "popCell")
        viewBg.addSubview(tableviewPopUp)
        
        
    }
    
    func callPopUp() {
         UIView.animate(withDuration: Double(0.5),
                                  delay: 0.0,
                                  options: .beginFromCurrentState, animations: { () -> Void in
            self.customPopUp.isHidden = false
         }, completion: { (Bool) -> Void in
                 
         })
    }
    
    
    
    @IBAction func searchAction(_ sender: Any) {
        
    }
    
      // MARK: - TableView Delegate Methods
       func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableviewPopUp == tableView {
           return arrayData.count
        } else {
            var resultRow = 0
            if self.isSearch == false {
                resultRow = ary_UserList?.count ?? 0
                return resultRow
            } else {
                resultRow = arrayAfterSearch?.count ?? 0
                 return resultRow
            }
         
         }
       }
    
       func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableViewList == tableView {
            return 35
        } else {
            return 70
        }
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableViewList == tableView {
             if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell {
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                cell.viewBG.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                cell.viewBG.layer.masksToBounds = false
                cell.viewBG.layer.shadowRadius = 8.0
                cell.viewBG.layer.shadowColor = UIColor.white.cgColor
                cell.viewBG.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
                cell.viewBG.layer.shadowOpacity = 0.6
                cell.likeButton.addTarget(self, action: #selector(self.likeAction), for: UIControl.Event.touchUpInside)
                cell.likeButton.tag = indexPath.row
                cell.viewBG.layer.cornerRadius = 16
                cell.viewBG.clipsToBounds = true

                cell.likeButton.layer.shadowRadius = 12.0
                cell.likeButton.layer.shadowColor = UIColor.black.cgColor
                cell.likeButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                cell.likeButton.layer.shadowOpacity = 0.7
                cell.likeButton.layer.cornerRadius = 18
                cell.likeButton.clipsToBounds = true
                //likeButton.frame = CGRect(x: self.imgViewSplash.frame.width-80, y: 18, width: 50, height: 50)
                               
                cell.likeButton.layer.shadowRadius = 18.0
                cell.likeButton.clipsToBounds = true
                cell.likeButton.backgroundColor = .white
                cell.likeButton.layer.shadowColor = UIColor.black.cgColor
                cell.likeButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                cell.likeButton.layer.masksToBounds = false
                cell.likeButton.layer.shadowRadius = 1.5
                cell.likeButton.layer.shadowOpacity = 0.5
                cell.likeButton.layer.cornerRadius = cell.likeButton.frame.width / 2
                
                cell.imageProduct.cornerRadius = 4
                cell.imageProduct.clipsToBounds = true
                if self.isSearch == false {
                   let priductData =  ary_UserList?[indexPath.row]
//                 let fldBrandName = dict["fld_brand_name"] as? String ?? ""
//                 let fldBrandName = priductData?.fldBrandName
//                 print("fldBrandName:", fldBrandName)
                   cell.productName.text = priductData?.name?.capitalized
                   cell.productType.text = priductData?.fldBrandName?.capitalized
                   cell.productName.textColor = .black
                   cell.productType.textColor = .gray
                   cell.price.text = "\u{20B9}\(priductData?.spclPrice ?? 0)"   // "\u{20B9}850"
                   cell.discountPrice.text = "\u{20B9}\(priductData?.price ?? 0)" //"\u{20B9}1150"
                   cell.productName.font = UIFont(name:"Arial",size:14.0)
                   cell.productType.font = UIFont(name:"Arial",size:14.0)
                   cell.price.font = UIFont(name:"Arial",size:12.0)
                   cell.discountPrice.font = UIFont(name:"Arial",size:12.0)
                    
                   cell.imageProduct.sd_setImage(with: URL(string:"\(priductData?.defaultImage ?? "")"), placeholderImage: UIImage(named: "productImageplaceholder"))
                   if priductData?.isInWishlist == false {
                       cell.likeButton.setImage(UIImage(named: "grayheart"), for: .normal)
                   } else {
                       cell.likeButton.setImage(UIImage(named: "redheart"), for: .normal)
                   }
                } else {
                   let priductData =  arrayAfterSearch?[indexPath.row]
                   cell.productName.text = priductData?.searchName
                   cell.productType.text = priductData?.categoryName
//                 cell.price.text = "\(priductData?.spclPrice ?? 0)"   // "\u{20B9}850"
//                    cell.discountPrice.text = "\(priductData?.extraPrice ?? 0)" //"\u{20B9}1150"
//                    cell.imageProduct.sd_setImage(with: URL(string:"\(priductData?.defaultImage ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))
//                    if priductData?.isInWishlist == false {
//                       cell.likeButton.setImage(UIImage(named: "heartIcon"), for: .normal)
//                    } else {
//                      cell.likeButton.setImage(UIImage(named: "redheart"), for: .normal)
//                    }
                }
                
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "  \(String(describing: cell.discountPrice.text!))  " )
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 3, range: NSMakeRange(0, attributeString.length))
                cell.discountPrice.attributedText = attributeString
                return cell
           }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "popCell", for: indexPath) as? popCell {
               cell.selectionStyle = .none
               //cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
               cell.title.text = "   \(arrayData[indexPath.row])"
               cell.backgroundColor = UIColor(red:255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                //cell.layer.borderColor = UIColor(red:89.0/255.0, green: 89.0/255.0, blue: 89.0/255.0, alpha: 1.0).cgColor
               cell.title.textColor = UIColor(red:0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
               if arraySelecteditems.contains(arrayData[indexPath.row]) {
                    cell.title.backgroundColor = .blue
//                  cell.layer.borderColor = UIColor(red:4.0/255.0, green: 202.0/255.0, blue: 169.0/255.0, alpha: 1.0).cgColor
                    cell.title.textColor = .white
                } else {
                    cell.title.backgroundColor = .white
                    cell.backgroundColor = UIColor(red:255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                    //cell.layer.borderColor = UIColor(red:89.0/255.0, green: 89.0/255.0, blue: 89.0/255.0, alpha: 1.0).cgColor
                    cell.title.textColor = UIColor(red:0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
               }
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

        if tableviewPopUp == tableView {
           arraySelecteditems.removeAllObjects()
            if !arraySelecteditems.contains(arrayData[indexPath.row]) {
                 arraySelecteditems.add(arrayData[indexPath.row])
              }
            tableviewPopUp.reloadData()
            var textfldValue = ""
            if textFieldSearch.text!.isEmpty {
                textfldValue = ""
            } else {
                textfldValue = "\(textFieldSearch.text!)"
            }
            UIView.animate(withDuration: Double(0.5),
                                             delay: 0.0,
                                             options: .beginFromCurrentState, animations: { () -> Void in
                                              self.customPopUp.isHidden = true
                                                let index = indexPath.row
                                                switch index {
                                                           case 0:
                                                               self.profuct(fldBrandId:"", fldCatId: "", fldUserId: "1", fldSearchTxt: "\(textfldValue)", fldPageNo: 0, fldSortBy: "1")
                                                           case 1:
                                                                 self.profuct(fldBrandId:"", fldCatId: "", fldUserId: "1", fldSearchTxt: "\(textfldValue)", fldPageNo: 0, fldSortBy: "2")
                                                           case 2:
                                                               self.profuct(fldBrandId:"", fldCatId: "", fldUserId: "1", fldSearchTxt: "\(textfldValue)", fldPageNo: 0, fldSortBy: "3")
                                                           default:
                                                               return
                                                           }
                                                
                    }, completion: { (Bool) -> Void in
                              })
           
            
        } else {
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailController") as? ProductDetailController {
               let priductData =  ary_UserList?[indexPath.row]
                
               var idvalue = ""
               if let id = priductData?.id {
                    idvalue = "\(id)"
                } else  {
                    idvalue = "\(String(describing: priductData?.id!))"
                }
               vc.str_fld_product_id = "\(idvalue)"
                vc.strcartcount = self.strcartTotalCount
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }
   //    if indexPath.section == TableSection.viewAttachedPresc {
   //       let storyboard = UIStoryboard(name:"Assessments", bundle: Bundle.main)
   //       let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "attachedPrescriptionListController") as! AttachedPrescriptionListController
   //       attachedPrescriptionListController.orderId = orderId
   //       self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
   //     }
     }
    
    @objc func likeAction(_ sender: UIButton) {
         let tag = sender.tag
         var id = ""
         var iswishlist = "0"
        let priductData =  ary_UserList?[tag]
        if let idvalue = priductData?.id {
            id = "\(idvalue)"
        }
        if priductData?.isInWishlist == false {
            iswishlist = "0"
        } else {
            iswishlist = "1"
        }
        
//         if self.isSearch == false {
//            let priductData =  ary_UserList?[tag]
//
//            if let idvalue = priductData?.catID {
//                 id = "\(idvalue))"
//            }
//            if priductData?.isInWishlist == false {
//                iswishlist = "0"
//            } else {
//                iswishlist = "1"
//            }
//         } else {
//            let priductData =  arrayAfterSearch?[tag]
//            id = "\(String(describing: priductData?.categoryID))"
//         }
         wishlist_add_update(userId: "1", productId: id, actionType: iswishlist)
    }
 
    
    @IBAction func filterButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CategoryContorller") as? CategoryContorller {
          self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func shortButton(_ sender: Any) {
       callPopUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view!.endEditing(true)
        self.resignKeyboard()
        UIView.animate(withDuration: Double(0.5),
                                          delay: 0.0,
                                          options: .beginFromCurrentState, animations: { () -> Void in
                                           self.customPopUp.isHidden = true
         }, completion: { (Bool) -> Void in
        })
    }

       func textField(_ textField:UITextField,shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
         if textFieldSearch.isEditing==true {
             if (self.ary_UserList != nil) {
                 self.ary_UserList?.removeAll()
             }
             for resultItem in (ary_Search ?? []) {
                 var productNamestring = ""
                 var productSpecialPrice = ""
                 var productExtraPrice = ""
                 var expstringappend = ""
                
                 if let docName = resultItem.name {
                     productNamestring = "\(docName)"
                 }
                 if let specialPrice = resultItem.spclPrice {
                     productSpecialPrice = "\(specialPrice)"
                 }
                 if let extraPrice = resultItem.extraPrice {
                     productExtraPrice = "\(extraPrice)"
                 }
                 expstringappend = "\(productNamestring)\(productSpecialPrice)\(productExtraPrice)"
//                 let search=expstringappend as NSString
                 let substring=(textField.text! as NSString).replacingCharacters(in: range, with: string)
                 self.profuct(fldBrandId:"", fldCatId: "0", fldUserId: "1", fldSearchTxt: "\(substring)", fldPageNo: 0, fldSortBy: "1")
//                 let r: NSRange=search.range(of: substring,options: .caseInsensitive)
//                 if r.location != NSNotFound || substring == "" {
//                     if r.length > 0 || substring == ""  {
////                      self.ary_UserList?.append(resultItem)
////                      self.lbl_Msg.isHidden=true
//                        //searchproduct(userId: "1", SearchTxt: "\(substring)")
//
//
//                     }
//                 }
             }
            
//             if (self.ary_UserList ?? []).count == 0 {
//                 self.lbl_Msg.text=" No Product found"
//                 self.lbl_Msg.isHidden=false
//             }
//             self.tableViewList.reloadData()
         }
         return true
     }
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
         
     }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true;
     }

    
    func resignKeyboard() {
       textFieldSearch.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
//    func callProductList() {
//
//            let json = [
//                "fld_user_id"         : "1",
//                "fld_search_txt"     : "simple"
//            ] as [String : Any]
//
//            print("json: ", json)
//            DIProgressHud.show()
//            print("WebService.searchByDoctor json", json)
//            postAPIAction(WebService.productsearch, parameters: json, showGenricErrorPopup: false) { (response) in
//                DispatchQueue.main.async {
//                   DIProgressHud.hide()
//                }
//                print("searchByDoctor response: ", response ?? "")
//                if let status = response?["status"] as? Int, status == 1 {
////                    if let dataDict = response as? Dictionary<String, Any> {
////                        self.searchDoctorObject = DoctorSearchListing(fromDictionary: dataDict)
////                        self.ary_UserList = self.searchDoctorObject?.doctorData ?? []
////                        self.ary_Search = self.searchDoctorObject?.doctorData ?? []
////                        if (self.ary_UserList ?? []).count > 0 {
////                            DispatchQueue.main.async {
////                                self.tableView_List.isHidden=false
////                                self.lbl_Msg.isHidden=true
////                            }
////                            self.setupSearchableContent()
////                        } else {
////                            DispatchQueue.main.async {
////                                self.tableView_List.isHidden=true
////                                self.lbl_Msg.frame=CGRect(x: 10,y: 176,width: self.tableView_List.frame.size.width-20,height: 45);
////                                self.lbl_Msg.isHidden=false
////                            }
////                        }
////                        DispatchQueue.main.async {
////                            self.tableView_List .reloadData();
////                        }
////                    }
//                }
//            }
//    }
}
