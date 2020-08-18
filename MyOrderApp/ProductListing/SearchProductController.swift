//
//  SearchProductController.swift
//  MyOrderApp
//
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class SearchProductController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var textFieldSearch: UITextField!
    @IBOutlet var tableViewList: UITableView!
    @IBOutlet var searchbutton: UIButton!
    
    var arrayData = ["Brand", "Price: Low to High", "Price: High to Low"]
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    var customPopUp: UIView!
    var tableviewPopUp: UITableView!
    var arraySelecteditems = NSMutableArray()
    
    
    var productArraya:[ProductDatum] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true
        self.registerNib()
        
        textFieldSearch.layer.borderColor = UIColor.gray.cgColor
        textFieldSearch.layer.borderWidth = 1
        textFieldSearch.layer.cornerRadius = 25
        textFieldSearch.clipsToBounds = true
        
        popUp()
        
        profuct(fldBrandId: "", fldCatId: "2", fldUserId: "1", fldSearchTxt: "", fldPageNo: 0, fldSortBy: "1")
        
    }
    
    
    func profuct(fldBrandId:String,fldCatId:String,fldUserId:String,fldSearchTxt:String,fldPageNo:Int,fldSortBy:String){
        
        
        ApiClient.loder(roughter: APIRouter.produNmae(fldBrandId: fldBrandId, fldCatCid: fldCatId, fldUserId: fldUserId, fldSearchTxt: fldSearchTxt, fldPageNo: fldPageNo, fldSortBy: fldSortBy)) { (product:ProductDetailesResponce) in
            
            print("\(product)")
            
            if product.status  == true{
                
                self.productArraya.append(contentsOf: product.productData ?? [])
                
                self.tableViewList.reloadData()
                
            }else {
                
                Utility.showAlert(withMessage: product.message ?? "", onController: self)

            }
            
            
            
            
        }
    }
    
    
    
    
    
    @IBAction func cartAction(_ sender: Any) {
        callPopUp()
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
         // if tableviewPopUp == tableView {
            return productArraya.count
         // } else {
           //  return 15
         // }
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
                
                    
                
                let priductData = productArraya[indexPath.row]
                            
                          // cell.imageProduct.image = UIImage(named: "imagegrid")
                
                
                
                           cell.likeButton.addTarget(self, action: #selector(self.likeAction), for: UIControl.Event.touchUpInside)
                           cell.likeButton.tag = indexPath.row
                           cell.viewBG.layer.cornerRadius = 16
                           cell.viewBG.clipsToBounds = true
                            cell.productName.text = priductData.name
                           cell.productType.text = "Click Fashion"
                            cell.price.text = "\(priductData.spclPrice ?? 0)"   // "\u{20B9}850"
                           cell.discountPrice.text = "\(priductData.extraPrice ?? 0)" //"\u{20B9}1150"
                            cell.imageProduct.sd_setImage(with: URL(string:"\(priductData.defaultImage ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))
                
                
                           cell.likeButton.layer.shadowRadius = 12.0
                           cell.likeButton.layer.shadowColor = UIColor.black.cgColor
                           cell.likeButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                           cell.likeButton.layer.shadowOpacity = 0.7
                           cell.likeButton.layer.cornerRadius = 18
                           cell.likeButton.clipsToBounds = true
                                      
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
         }
        
        
   //        if indexPath.section == TableSection.viewAttachedPresc {
   //            let storyboard = UIStoryboard(name:"Assessments", bundle: Bundle.main)
   //            let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "attachedPrescriptionListController") as! AttachedPrescriptionListController
   //            attachedPrescriptionListController.orderId = orderId
   //            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
   //        }
       }
    
    @objc func likeAction(_ sender: UIButton) {
        
    }
    
    @IBAction func filterButton(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "CategoryContorller") as? CategoryContorller {
            self.navigationController?.pushViewController(vc, animated: true)
        }

        
        
        
        
    }
    
    @IBAction func shortButton(_ sender: Any) {
        
        
        
        
    }
    

}
