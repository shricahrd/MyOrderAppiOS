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
    var array_selecteditems = NSMutableArray()
    var arrayBrand:[BrandDatum]?
    var array_temp:NSMutableArray!
    var str_id:NSMutableString!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.setNavigationBarHidden(true,animated: false)
        self.navigationItem.hidesBackButton = true

        screenWidth = screenSize.width
        screenHeight = screenSize.height
        array_temp = NSMutableArray()
        array_selecteditems = NSMutableArray()

        arrayCategory = ["Adidas", "adidas Originals", "Blend","Boutique","Champion", "Diesel", "Jack & Jones", "Naf Naf", "Red Valentino", "s.Oliver","Adidas", "adidas Originals", "Blend","Boutique","Champion", "Diesel", "Jack & Jones", "Naf Naf", "Red Valentino", "s.Oliver"]
        self.view.backgroundColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        let paddingL: UIView = UIView()
        paddingL.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        callUISetUpHeader()
        
         let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
           (self.navigationController?.navigationBar.frame.height ?? 0.0)
         print("topBarHeight:",topBarHeight);
         textFieldSearch = UITextField()
         textFieldSearch.frame = CGRect(x: 16, y: topBarHeight+10, width: view.frame.size.width - 32 , height: 45)
         textFieldSearch.delegate = self
         self.view.addSubview(textFieldSearch)
        
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
         textFieldSearch.font = UIFont(name:"Arial",size:15.0)
         textFieldSearch.backgroundColor = UIColor.white
         textFieldSearch.layer.cornerRadius = 24.0
         textFieldSearch.isSecureTextEntry = false
         textFieldSearch.leftViewMode = .always
         textFieldSearch.rightViewMode = .always
        textFieldSearch.tag = 100
        textFieldSearch.returnKeyType = .next
        textFieldSearch.keyboardType = UIKeyboardType.asciiCapable
        
        let imagesearch = UIImageView()
        imagesearch.frame = CGRect(x:15, y: 14, width:  20, height: 20)
        imagesearch.image = UIImage(named: "search")
        imagesearch.backgroundColor = .clear
        textFieldSearch.addSubview(imagesearch)

        self.registerNibs()
        self.brand(fldPageNo:"0")
        
    }

    func brand(fldPageNo:String) {
        ApiClient.loder(roughter: APIRouter.brand(fldPageNo: fldPageNo)) { (brandList:BrandListResponce) in
            print("brandList:","\(brandList)")
            if brandList.status == true {
                self.arrayBrand = brandList.brandData ?? []
                self.arrayCategory.removeAll()
                for dict in  self.arrayBrand ?? [] {
                    // var dictValue = Dictionary<String,Any>()
                    if let id = dict.id {
                        self.arrayCategory.append("\(id)")
                    }
                }
          print("self.arrayCategory: ", "\(self.arrayCategory)")
                DispatchQueue.main.async {
                    self.tableViewList.reloadData()
                }
                
            }
            
        }
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
                  btnCart.addTarget(self,action:#selector(self.clickOnCart(_:)),for: UIControl.Event.touchUpInside)
                  btnCart.isUserInteractionEnabled = true
                  viewHeaderBg.addSubview(btnCart)
           
                  let viewUnLine = UIView()
                  viewUnLine.frame = CGRect(x: 0, y: 75.0, width: screenWidth, height: 1.5);
                  viewUnLine.backgroundColor = UIColor(red: 215.0 / 255.0, green: 215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
                  viewUnLine.layer.shadowColor = UIColor.black.cgColor
                  viewUnLine.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                  viewUnLine.layer.masksToBounds = false
                  viewUnLine.layer.shadowRadius = 1.0
                  viewUnLine.layer.shadowOpacity = 0.5
                  viewHeaderBg.addSubview(viewUnLine)
        
        
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController!.setNavigationBarHidden(true,animated: false)
        self.navigationItem.hidesBackButton = true
    }
    
     @objc func clickOnCart(_ sender: AnyObject!) {
         let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
         if let vc = storyboard.instantiateViewController(withIdentifier: "MyCartController") as? MyCartController {
            self.navigationController?.pushViewController(vc, animated: true)
         }
     }
     
     @objc func clickOnBack(_ sender: AnyObject!) {
         self.navigationController?.popViewController(animated: true)
     }
    
     func registerNibs() {
         self.tableViewList=UITableView()
         self.tableViewList.frame = CGRect(x: 0, y: self.textFieldSearch.frame.maxY , width: screenWidth, height:screenHeight-150)
         self.tableViewList.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
         self.tableViewList.dataSource=self;
         self.tableViewList.delegate=self;
         self.tableViewList.bounces=true
         self.tableViewList.backgroundColor = UIColor.clear
         self.tableViewList.separatorStyle = .none
         self.tableViewList.register(UINib(nibName: "searchcontrollerCell", bundle: nil), forCellReuseIdentifier: "searchcontrollerCell")
         self.view.addSubview(self.tableViewList)
         self.bottomviewBG()
     }
    
    func bottomviewBG() {
        viewBottomBg = UIView()
        viewBottomBg.frame = CGRect(x: CGFloat(0), y:view.frame.size.height - 100, width: CGFloat(screenWidth), height: 100)
        viewBottomBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
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
        if str_id != "" {
           self.callFilterProduct()
        } else {
            DispatchQueue.main.async {
                Utility.showAlert(withMessage: "Please select at least one brand.", onController: self)
            }
        }
    }
    
    @objc func clickOnClearAll(_ sender: AnyObject!) {
        self.str_id = ""
        self.array_selecteditems.removeAllObjects()
        self.tableViewList.reloadData()
    }
    
    // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
         
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayBrand?.count ?? 0
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "searchcontrollerCell", for: indexPath) as? searchcontrollerCell {
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                cell.btncheckuncheck.addTarget(self, action: #selector(self.selectedAction), for: .touchUpInside)
                cell.btncheckuncheck.tag = indexPath.row
                cell.btncheckuncheck.layer.cornerRadius = 3
                cell.btncheckuncheck.clipsToBounds = true
                cell.btncheckuncheck.backgroundColor = .clear
                cell.lblcell.font =  UIFont(name: cell.lblcell.font.fontName, size: 14)
                let brandData = self.arrayBrand?[indexPath.row]
                if let name = brandData?.name {
                   cell.lblcell.text = "\(name)".capitalized
                }
                if array_selecteditems.contains(self.arrayCategory[indexPath.row] ) {
                   cell.btncheckuncheck.layer.borderWidth = 1
                   cell.btncheckuncheck.layer.borderColor = UIColor.darkGray.cgColor
                   cell.btncheckuncheck.backgroundColor = .blue
                   cell.btncheckuncheck.setImage(UIImage(named: "selectedCheckboxTick"), for: .normal)
                   //cell.contentView.backgroundColor = UIColor(red:4 / 255.0, green:202.0 / 255.0, blue:169.0 / 255.0, alpha: 1.0)
                } else {
                    //cell.btncheckuncheck.setImage(UIImage(named: "UnSelected"), for: .normal)
                    cell.btncheckuncheck.backgroundColor = .clear
                    cell.btncheckuncheck.layer.borderWidth = 1
                    cell.btncheckuncheck.layer.borderColor = UIColor.darkGray.cgColor
                    //cell.contentView.backgroundColor = UIColor(red: 222.0 / 255.0, green:222.0 / 255.0, blue:222.0 / 255.0, alpha: 1.0)
                }
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
    
    @objc func selectedAction(_ sender: UIButton) {
        let tag = sender.tag
        if !array_selecteditems.contains(self.arrayCategory[tag]) {
           array_selecteditems.add(self.arrayCategory[tag])
        } else {
           array_selecteditems.remove(self.arrayCategory[tag])
        }
        array_temp = array_selecteditems
        print("array_temp:", array_temp ?? 0)
        str_id = NSMutableString()
        for i in 0 ..< array_temp.count {
           if (i == (array_temp.count)-1) {
              let aStr = String(format:"%@", (array_temp[i] as? String)!)
              str_id.append("\(aStr)")
           } else {
              let aStr=String(format:"%@,", (array_temp[i] as? String)!)
              str_id.append("\(aStr)")
           }
        }
        print("str_id:",str_id!)
            
        self.tableViewList.reloadData()
        //self.tableViewList.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
      func callFilterProduct()  {
        var str_brandid = NSMutableString()
        if str_id != "" {
            str_brandid = str_id
        }
        let parameters = [
               "fld_cat_id":"",
               "fld_brand_id":str_brandid,
               "fld_size_id":"",
               "fld_color_id":"",
               "fld_max_price":"",
               "fld_min_price":"",
               "fld_page_no":"",
               "fld_user_id":getUserID(),
               "fld_material_id":"",
               "fld_other_id":"",
               "fld_sort_by":"",
               "fld_search_txt":"",
               "fld_scat_id":""
               ] as [String: Any]
               print("params brand: ", parameters)
               FiltersNewVM.shared.filtersProduct(parameters: parameters) { (response) in
                    print("filter Product response: ", response ?? "")
                    if response?.status == true {
                         DispatchQueue.main.async {
                            Utility.showAlert(withMessage: response?.message ?? "", onController: self)
                        }
                    } else {
                        DispatchQueue.main.async {
                          Utility.showAlert(withMessage: response?.message ?? "", onController: self)
                        }
                  }
             }
        }
}

