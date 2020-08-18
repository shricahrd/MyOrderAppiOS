//
//  SearchController.swift
//  MyOrderApp
//
//  Created by Apple on 8/11/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    var tableViewList = UITableView()
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var arrayCategory = [String]()
    var viewBottomBg = UIView()
    var textFieldSearch: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        arrayCategory = ["Adidas", "adidas Originals", "Blend","Boutique","Champion", "Diesel", "Jack & Jones", "Naf Naf", "Red Valentino", "s.Oliver","Adidas", "adidas Originals", "Blend","Boutique","Champion", "Diesel", "Jack & Jones", "Naf Naf", "Red Valentino", "s.Oliver"]
        self.view.backgroundColor = UIColor(red:215.0 / 255.0, green:215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)

        let paddingL: UIView = UIView()
        paddingL.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        
        textFieldSearch = UITextField()
        textFieldSearch.frame = CGRect(x: 16, y: 80, width: view.frame.size.width - 32 , height: 45)
        textFieldSearch.delegate = self
        textFieldSearch.layer.borderColor =  UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor
        textFieldSearch.textColor = UIColor.black
        textFieldSearch.leftView = paddingL
        textFieldSearch.rightView = paddingL
        textFieldSearch.placeholder = "Search"
        textFieldSearch.tintColor = UIColor.black;
        textFieldSearch.font = UIFont(name: "Arial",size: 15)
        textFieldSearch.backgroundColor = UIColor.white
        textFieldSearch.layer.cornerRadius = 20
        textFieldSearch.leftViewMode = .always
        textFieldSearch.rightViewMode = .always
        textFieldSearch.layer.borderWidth = 2
        textFieldSearch.layer.borderColor = UIColor.darkGray.cgColor
        
        
        self.view.addSubview(textFieldSearch)
        
       
        self.registerNibs()

    }
    func registerNibs() {
           self.tableViewList=UITableView()
              self.tableViewList.frame = CGRect(x: 0, y: self.textFieldSearch.frame.maxY , width: screenWidth, height:screenHeight-150)
              self.tableViewList.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
           tableViewList.dataSource=self;
           tableViewList.delegate=self;
           tableViewList.bounces=true
           tableViewList.backgroundColor = UIColor.clear
           tableViewList.separatorStyle = .none
           tableViewList.register(UINib(nibName: "searchcontrollerCell", bundle: nil), forCellReuseIdentifier: "searchcontrollerCell")
           self.view.addSubview(tableViewList)
          self.bottomviewBG()
       }
    func bottomviewBG() {
        
        viewBottomBg = UIView()
        viewBottomBg.frame = CGRect(x: CGFloat(0), y:view.frame.size.height - 100, width: CGFloat(screenWidth), height: 100)
        viewBottomBg.backgroundColor = UIColor(red:215.0 / 255.0, green:215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
        viewBottomBg.layer.shadowColor = UIColor.black.cgColor
        viewBottomBg.layer.shadowOffset = CGSize(width: 0.0, height: 12.0)
        viewBottomBg.layer.masksToBounds = false
        viewBottomBg.layer.shadowRadius = 12.0
        viewBottomBg.layer.shadowOpacity = 0.5
        view.addSubview(viewBottomBg)
        
        let btnClearAll = UIButton()
        btnClearAll.frame = CGRect(x: 16, y: 28, width: (viewBottomBg.frame.size.width/2 - 32), height: 40)
        btnClearAll.backgroundColor = .clear
        btnClearAll.setTitle("Clear All", for: .normal)
        btnClearAll.layer.borderColor = UIColor.darkGray.cgColor
        btnClearAll.layer.borderWidth = 1
        btnClearAll.layer.cornerRadius = 18
        btnClearAll.clipsToBounds = true
        btnClearAll.setTitleColor(.darkGray, for: .normal)
        btnClearAll.addTarget(self,action:#selector(self.clickOnClearAll(_:)),for: UIControl.Event.touchUpInside)
        btnClearAll.isUserInteractionEnabled = true
        viewBottomBg.addSubview(btnClearAll)
        
        let btnApply = UIButton()
        btnApply.frame = CGRect(x: viewBottomBg.frame.size.width/2 + 16, y: 28, width: (viewBottomBg.frame.size.width/2 - 32), height: 40)
        btnApply.backgroundColor = .clear
        btnApply.setTitle("Apply", for: .normal)
        btnApply.setTitleColor(.white, for: .normal)
        btnApply.layer.borderWidth = 0
        btnApply.layer.cornerRadius = 18
        btnApply.clipsToBounds = true
        btnApply.backgroundColor = .blue
        btnApply.addTarget(self,action:#selector(self.clickonApply(_:)),for: UIControl.Event.touchUpInside)
        btnApply.isUserInteractionEnabled = true
        viewBottomBg.addSubview(btnApply)
    }
    
    @objc func clickonApply(_ sender: AnyObject!) {
          
    }
    
    @objc func clickOnClearAll(_ sender: AnyObject!) {
        
    }
    
    // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
         
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCategory.count
    }
            
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
         
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
         
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
         
//  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//              switch section {
//                    case 0 :
//                         return UIView()
//                    case 1 :
//                         return UIView()
//                    case 2 :
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "productSizesHeader") as! productSizesHeader
//                        cell.remove.text = "Add"
//                        return cell
//                    default:
//                        let view1 = UIView.init()
//                        return view1
//                    }
//         }

         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
            if let cell = tableView.dequeueReusableCell(withIdentifier: "searchcontrollerCell", for: indexPath) as? searchcontrollerCell {
                     
                     
                     cell.selectionStyle = .none
                     cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
           
                cell.lblcell.text = "ghjjhg"

                     
                     return cell
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
}

