//  CategoryContorller.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 27/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
import QuartzCore


class CategoryContorller: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var tableViewList: UITableView!
    @IBOutlet var viewBG: UIView!
    @IBOutlet var clearAll: UIButton!
    @IBOutlet var applyButton: UIButton!
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var scrollViewMain = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.orange, UIColor.red, UIColor.blue, UIColor.green, UIColor.orange]
    var collectionViewCategory: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var viewCategoryBg = UIView()
    var collectionViewColor: UICollectionView!
    var viewColorBg = UIView()
    var viewsizeBg = UIView()
    var collectionViewSize: UICollectionView!
   
    var arrayCategory = [String]()
    var arraySize = [String]()
    var viewBottomBg = UIView()
    
    var rangeSlider1 = RangeSlider(frame: CGRect.zero)
    var leftRange = UILabel()
    var rightRange = UILabel()
    var ary_temp:NSMutableArray!
    var str_CAt_ids:NSMutableString!
    var array_selecteditems:NSMutableArray!
    var arrayCategoryDa = NSMutableArray()
    
    var ary_tempColor:NSMutableArray!
    var str_Colorid:NSMutableString!
    var array_ColorSelecteditems:NSMutableArray!
    var arrayColorDa = NSMutableArray()
    
    var ary_tempSize:NSMutableArray!
    var str_Sizeid:NSMutableString!
    var array_SizeSelecteditems:NSMutableArray!
    var arraySizeDa = NSMutableArray()
    
    var minPrice = 0
    var maxPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        arrayCategory = ["All", "Women", "Men","Boys","Girls"]
        arraySize = ["XS", "S", "M","L","XL","XXL"]
        
        ary_temp = NSMutableArray()
        array_selecteditems = NSMutableArray()
        ary_tempColor = NSMutableArray()
        array_ColorSelecteditems = NSMutableArray()
        ary_tempSize = NSMutableArray()
        array_SizeSelecteditems = NSMutableArray()
        
        self.view.backgroundColor = UIColor(red:215.0 / 255.0, green:215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
        callUISetUpHeader()
        self.uiSetUpScrollView()
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
    
    @objc func clickOnCart(_ sender: AnyObject!) {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MyCartController") as? MyCartController {
           self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func clickOnBack(_ sender: AnyObject!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func postLoginCall(fldbrandid: String,fldcatid: String,fldsearchtxt: String) {
        
        FiltersNewVM.shared.filtersnew(fldbrandid: fldbrandid, fldcatid: fldcatid, fldsearchtxt: fldsearchtxt) { (response) in
            print("getVendorDetails respone: ", response ?? "")
            if response?.status == true {
                if FiltersNewVM.shared.arrayListing.count > 0 {
                   DispatchQueue.main.async {
                    self.rangeSlider1.lowerValue = Double(FiltersNewVM.shared.dictPriceData.min_price ?? 0)
                    self.rangeSlider1.upperValue = Double(FiltersNewVM.shared.dictPriceData.max_price ?? 0)
                    print(Int(self.rangeSlider1.lowerValue))
                    print(Int(self.rangeSlider1.upperValue))
                    self.leftRange.text = "\u{20B9} \(Int(self.rangeSlider1.lowerValue))"
                    self.rightRange.text = "\u{20B9} \(Int(self.rangeSlider1.upperValue))"
                    
                    self.minPrice = Int(self.rangeSlider1.lowerValue)
                    self.maxPrice = Int(self.rangeSlider1.upperValue)
                        
                    self.arrayCategoryDa.removeAllObjects()
                    self.arrayColorDa.removeAllObjects()
                    self.arraySizeDa.removeAllObjects()
                    for items in FiltersNewVM.shared.arrayCategoryData {
                        let fld_cat_id = items.fld_cat_id
                        let fld_cat_name = items.fld_cat_name
                        let dict = [
                            "fld_cat_id":fld_cat_id ?? 0,
                            "fld_cat_name":fld_cat_name ?? 0
                            ] as [String : Any]
                        self.arrayCategoryDa.add(dict)
                         
                    }
                    
                    for items in FiltersNewVM.shared.arrayColorData {
                        let fld_id = items.fld_id
                        let fld_filter_type = items.fld_filter_type
                        let fld_code = items.fld_code
                        let fld_name = items.fld_name
                        let dict = [
                            "fld_id":fld_id ?? 0,
                            "fld_name":fld_name ?? 0,
                            "fld_code":fld_code ?? 0,
                            "fld_filter_type":fld_filter_type ?? 0
                            ] as [String : Any]
                        self.arrayColorDa.add(dict)
                         
                    }
                    
                    for items in FiltersNewVM.shared.arraySizeData {
                        let fld_id = items.fld_id
                        let fld_filter_type = items.fld_filter_type
                        let fld_name = items.fld_name
                        let dict = [
                           "fld_id":fld_id ?? 0,
                           "fld_name":fld_name ?? 0,
                           "fld_filter_type":fld_filter_type ?? 0
                        ] as [String : Any]
                        self.arraySizeDa.add(dict)
                     }
                    
                    
                    print("self.arrayCategoryDa:",self.arrayCategoryDa)
                    print("self.arrayColorDa:",self.arrayColorDa)
                    print("self.arraySizeDa:",self.arraySizeDa)
                    
                    self.collectionViewSize.reloadData()
                    self.collectionViewColor.reloadData()
                    self.collectionViewCategory.reloadData()
                   }
                }
            }
        }
    }

    
  func callFilterProduct()  {
    print("self.maxPrice: ", self.maxPrice )
    print("self.minPrice: ", self.minPrice)
    var strSizeId = NSMutableString()
    var strColorId = NSMutableString()
    var strCategoryId = NSMutableString()
    if str_CAt_ids != "" {
       strCategoryId = str_CAt_ids
    }
    if str_Colorid != "" {
       strColorId = str_Colorid
    }
    if str_Sizeid != "" {
       strSizeId = str_Sizeid
    }
    
    let parameters = [
        "fld_cat_id":strCategoryId,
           "fld_brand_id":"",
           "fld_size_id":strSizeId,
           "fld_color_id":strColorId,
           "fld_max_price":self.maxPrice,
           "fld_min_price":self.minPrice,
           "fld_page_no":"",
           "fld_user_id":getUserID(),
           "fld_material_id":"",
           "fld_other_id":"",
           "fld_sort_by":"",
           "fld_search_txt":"",
           "fld_scat_id":""
           ] as [String: Any]
           print("params orderPlaced: ", parameters)
           FiltersNewVM.shared.filtersProduct(parameters: parameters) { (response) in
                print("filter Product response: ", response ?? "")
                if response?.status == true {
                     DispatchQueue.main.async {
                        Utility.showAlert(withMessage: response?.message ?? "", onController: self)
                    }
                    
//                           if FiltersNewVM.shared.arrayFilterProduct.count > 0 {
//                              DispatchQueue.main.async {
//                                CommonAlert.shared.showActionAlertView(title: "", message: response?.message ?? "", actions: [], preferredStyle: .alert, viewController: AppDelegate.shared.window?.rootViewController)
//                              }
//                           }
              
                } else {
                    DispatchQueue.main.async {
                      Utility.showAlert(withMessage: response?.message ?? "", onController: self)
                    }
              }
         }
               
    }
           
    
    @objc func clickOnBrand(_ sender: UIButton) {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        if let searchController = storyboard.instantiateViewController(withIdentifier: "SearchController") as? SearchController {
           self.navigationController?.pushViewController(searchController, animated: true)
        }
    }
    
    
    func uiSetUpScrollView() {
         scrollViewMain.frame = CGRect(x: 0, y: 75, width: screenWidth, height: screenHeight-75);
         scrollViewMain.bounces = true
         scrollViewMain.delegate = self
         scrollViewMain.backgroundColor = UIColor(red:215.0 / 255.0, green:215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
         view.addSubview(scrollViewMain)
        
         let viewBrandBg = UIView()
         viewBrandBg.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 70);
         viewBrandBg.backgroundColor = UIColor(red:222.0 / 255.0, green:222.0 / 255.0, blue:222.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewBrandBg)
        
         let title = UILabel()
         title.frame = CGRect(x: 16, y: 0, width: screenWidth-10, height: 70);
         title.text = "Brand";
         title.font = UIFont.boldSystemFont(ofSize: 14)
         viewBrandBg.addSubview(title)
        
         let imageArrow = UIImageView()
         imageArrow.frame = CGRect(x: title.frame.maxX-40, y: (viewBrandBg.frame.size.height) - (viewBrandBg.frame.size.height/2+12), width: 12, height: 16);
         imageArrow.image = UIImage(named: "arrow_icon_mr")
         viewBrandBg.addSubview(imageArrow)
        
         let btnBrand = UIButton()
         btnBrand.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 70)
         btnBrand.backgroundColor = .clear
         btnBrand.addTarget(self, action: #selector(self.clickOnBrand), for: UIControl.Event.touchUpInside)
         btnBrand.isUserInteractionEnabled = true
         scrollViewMain.addSubview(btnBrand)
        
         viewCategoryBg = UIView()
         viewCategoryBg.frame = CGRect(x: 0, y: viewBrandBg.frame.maxY+2, width: screenWidth, height: 160);
         viewCategoryBg.backgroundColor = UIColor(red:222.0 / 255.0, green:222.0 / 255.0, blue:222.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewCategoryBg)
        
         let categoryTitle = UILabel()
         categoryTitle.frame = CGRect(x: 16, y: 0, width: screenWidth-50, height: 30);
         categoryTitle.text = "Category";
         categoryTitle.font = UIFont.boldSystemFont(ofSize: 14)
         viewCategoryBg.addSubview(categoryTitle)
        
         viewColorBg = UIView()
         viewColorBg.frame = CGRect(x: 0, y: viewCategoryBg.frame.maxY+2, width: screenWidth, height: 160);
         viewColorBg.backgroundColor = UIColor(red:222.0 / 255.0, green:222.0 / 255.0, blue:222.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewColorBg)
        
         let ColorTitle = UILabel()
         ColorTitle.frame = CGRect(x: 16, y: 0, width: screenWidth-50, height: 30);
         ColorTitle.text = "Color";
         ColorTitle.font = UIFont.boldSystemFont(ofSize: 14)
         viewColorBg.addSubview(ColorTitle)
        
         viewsizeBg = UIView()
         viewsizeBg.frame = CGRect(x: 0, y: viewColorBg.frame.maxY+2, width: screenWidth, height: 160);
         viewsizeBg.backgroundColor = UIColor(red:222.0 / 255.0, green:222.0 / 255.0, blue:222.0 / 255.0, alpha: 1.0)
         scrollViewMain.addSubview(viewsizeBg)
        
        let sizeTitle = UILabel()
        sizeTitle.frame = CGRect(x: 16, y: 0, width: screenWidth-50, height: 30);
        sizeTitle.text = "Size ";
        sizeTitle.font = UIFont.boldSystemFont(ofSize: 14)
        viewsizeBg.addSubview(sizeTitle)
        
        let viewRangeBg = UIView()
        viewRangeBg.frame = CGRect(x: 0, y: viewsizeBg.frame.maxY+2, width: screenWidth, height: 160);
        viewRangeBg.backgroundColor = UIColor(red:222.0 / 255.0, green:222.0 / 255.0, blue:222.0 / 255.0, alpha: 1.0)
        scrollViewMain.addSubview(viewRangeBg)
        
        let viewRangeBgTitle = UILabel()
        viewRangeBgTitle.frame = CGRect(x: 16, y: 0, width: screenWidth-50, height: 30);
        viewRangeBgTitle.text = "Range ";
        viewRangeBg.addSubview(viewRangeBgTitle)
        
        leftRange = UILabel()
        leftRange.frame = CGRect(x: 16, y: 35, width: screenWidth/2-32, height: 30)
        leftRange.text = "\u{20B9} 295"
        leftRange.textAlignment = .center
        leftRange.font = UIFont.boldSystemFont(ofSize: 12)
        viewRangeBg.addSubview(leftRange)
        
        rightRange = UILabel()
        rightRange.frame = CGRect(x: screenWidth/2+16, y: 35, width: screenWidth/2-32, height: 30)
        rightRange.text = "\u{20B9} 2065"
        rightRange.textAlignment = .center
        rightRange.font = UIFont.boldSystemFont(ofSize: 12)
        viewRangeBg.addSubview(rightRange)
        
        rangeSlider1 = RangeSlider(frame: CGRect(x: 26, y: leftRange.frame.maxY+2, width: screenWidth/2-32, height: 30))
        viewRangeBg.addSubview(rangeSlider1)
        
        rangeSlider1.addTarget(self, action: #selector(self.rangeSliderValueChanged(_:)),
                                  for: .valueChanged)
        self.callcollectionCategory()
        self.callcollectionColor()
        self.callcollectionSize()
        self.bottomviewBG()
        self.scrollViewMain.contentSize = CGSize(width: 0, height: viewRangeBg.frame.maxY+300)
        
        postLoginCall(fldbrandid: "",fldcatid: "2",fldsearchtxt: "")
        
//        filtersnew(fldbrandid: "", fldcatid: "2", fldsearchtxt: "")
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
        print(Int(rangeSlider.lowerValue))
        print(Int(rangeSlider.upperValue))
        self.leftRange.text = "\u{20B9} \(Int(rangeSlider.lowerValue))"
        self.rightRange.text = "\u{20B9} \(Int(rangeSlider.upperValue))"
       
        
        self.minPrice = Int(rangeSlider.lowerValue)
        self.maxPrice = Int(rangeSlider.upperValue)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
       rangeSlider1.frame = CGRect(x: margin,y:margin+topLayoutGuide.length+30,
              width: width, height: 31.0)
    }
    
    func callcollectionCategory() {
        layout = UICollectionViewFlowLayout()
        collectionViewCategory = UICollectionView(frame: CGRect(x: CGFloat(0), y:30, width: CGFloat(screenWidth), height: 120), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionViewCategory.dataSource = self
        collectionViewCategory.dataSource = self
        collectionViewCategory.delegate = self
        collectionViewCategory.isScrollEnabled = true
        collectionViewCategory.isPagingEnabled = true
        collectionViewCategory.bounces = true
        collectionViewCategory.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionViewCategory.backgroundColor = UIColor.clear
        collectionViewCategory.showsHorizontalScrollIndicator = false
        collectionViewCategory.showsVerticalScrollIndicator = true
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        viewCategoryBg.addSubview(collectionViewCategory)
    }
    
    func callcollectionColor() {
        layout = UICollectionViewFlowLayout()
        collectionViewColor = UICollectionView(frame: CGRect(x: CGFloat(0), y:30, width: CGFloat(screenWidth), height: 80), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionViewColor.dataSource = self
        collectionViewColor.dataSource = self
        collectionViewColor.delegate = self
        collectionViewColor.isScrollEnabled = true
        collectionViewColor.isPagingEnabled = true
        collectionViewColor.bounces = true
        collectionViewColor.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionViewColor.backgroundColor = UIColor.clear
        collectionViewColor.showsHorizontalScrollIndicator = false
        collectionViewColor.showsVerticalScrollIndicator = true
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        viewColorBg.addSubview(collectionViewColor)
    }
    
    func callcollectionSize() {
         layout = UICollectionViewFlowLayout()
         collectionViewSize = UICollectionView(frame: CGRect(x: CGFloat(0), y:30, width: CGFloat(screenWidth), height: 80), collectionViewLayout: layout)
         layout.scrollDirection = .horizontal
         collectionViewSize.dataSource = self
         collectionViewSize.dataSource = self
         collectionViewSize.delegate = self
         collectionViewSize.isScrollEnabled = true
         collectionViewSize.isPagingEnabled = true
         collectionViewSize.bounces = true
         collectionViewSize.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
         collectionViewSize.backgroundColor = UIColor.clear
         collectionViewSize.showsHorizontalScrollIndicator = false
         collectionViewSize.showsVerticalScrollIndicator = true
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 5
         viewsizeBg.addSubview(collectionViewSize)
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
        self.callFilterProduct()
    }
    
    @objc func clickOnClearAll(_ sender: AnyObject!) {
        str_CAt_ids = ""
        str_Colorid  = ""
        str_Sizeid = ""
      
        array_selecteditems.removeAllObjects()
        array_SizeSelecteditems.removeAllObjects()
        array_ColorSelecteditems.removeAllObjects()
        
        ary_tempSize.removeAllObjects()
        ary_tempColor.removeAllObjects()
        ary_temp.removeAllObjects()
        
        collectionViewSize.reloadData()
        collectionViewColor.reloadData()
        collectionViewCategory.reloadData()
        
        
    }
    
    
    // MARK:- Collection View Metods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategory {
            if self.arrayCategoryDa.count > 0 {
               return self.arrayCategoryDa.count
            }
        } else if collectionView == collectionViewColor {
            if self.arrayColorDa.count > 0 {
               return self.arrayColorDa.count
            }
        } else if collectionView == collectionViewSize {
            if FiltersNewVM.shared.arraySizeData.count > 0 {
               return FiltersNewVM.shared.arraySizeData.count
            }
        }
        return 0
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
       
    // Make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategory {
            let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
            for view: UIView in (cell?.contentView.subviews)! {
                view.removeFromSuperview()
            }
            let viewBG: UIView! = UIView()
            viewBG.frame = CGRect(x: 4, y: 5, width: (cell?.frame.size.width)!-8, height: (cell?.frame.size.height)!-8)
            viewBG.backgroundColor = .white
            viewBG.layer.cornerRadius = 8
            viewBG.layer.borderWidth = 1
            viewBG.layer.borderColor = UIColor.lightGray.cgColor
            viewBG.clipsToBounds = true
            cell?.contentView.addSubview(viewBG)
            viewBG.backgroundColor = .clear
            
            let title: UILabel! = UILabel()
            title.frame = CGRect(x: 0, y: 0, width: viewBG.frame.size.width, height: viewBG.frame.size.height)
            if let dictData = self.arrayCategoryDa[indexPath.row] as? Dictionary<String, Any> {
                let categoryname = dictData["fld_cat_name"] as? String ?? ""
                title.text = categoryname.capitalized
            }
            title.numberOfLines = 3
            title.backgroundColor = .clear
            title.textAlignment = .center
            title.textColor = .white
            title.font = UIFont.boldSystemFont(ofSize: 11)
            viewBG.addSubview(title)
            
            if array_selecteditems.contains(self.arrayCategoryDa[indexPath.row]) {
               viewBG.backgroundColor = .blue
                  title.textColor = .white
            } else {
                     viewBG.backgroundColor = .clear
                  title.textColor = .darkText
            }
            return cell!
        } else if collectionView == collectionViewColor {
            let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
            for view: UIView in (cell?.contentView.subviews)! {
                view.removeFromSuperview()
            }
            let viewBG: UIView! = UIView()
            viewBG.frame = CGRect(x: 4, y: 4, width: (cell?.frame.size.width)!-8, height: (cell?.frame.size.height)!-8)
            viewBG.backgroundColor = .clear
            viewBG.layer.cornerRadius = ((cell?.frame.size.width)!-8)/2
            viewBG.clipsToBounds = true
            viewBG.layer.borderWidth = 0
            viewBG.layer.borderColor = UIColor.clear.cgColor
            cell?.contentView.addSubview(viewBG)
            viewBG.backgroundColor = .clear
            
            let img = UIImageView()
            img.frame = CGRect(x: 8, y: 8, width: (cell?.frame.size.width)!-16, height: (cell?.frame.size.height)!-16)
            img.layer.cornerRadius = ((cell?.frame.size.width)!-16)/2
            img.clipsToBounds = true
            if let dictData = self.arrayColorDa[indexPath.row] as? Dictionary<String, Any> {
                    let fld_code = dictData["fld_code"] as? String ?? ""
                    var colour = fld_code
                    if colour == "" {
                       colour = "#524ea3"
                    }
                    img.backgroundColor = CommonMethods.sharedInstance.hexStringToUIColorOpacity(hex: colour)
            }
//          let dictData = FiltersNewVM.shared.arrayColorData[indexPath.row]
           
            cell?.contentView.addSubview(img)
            return cell!
            
        } else if collectionView == collectionViewSize {
            let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
            for view: UIView in (cell?.contentView.subviews)! {
                view.removeFromSuperview()
            }
            let viewBG: UIView! = UIView()
            viewBG.frame = CGRect(x: 4, y: 5, width: (cell?.frame.size.width)!-8, height: (cell?.frame.size.height)!-8)
            viewBG.backgroundColor = .white
            viewBG.layer.cornerRadius = ((cell?.frame.size.width)!-8)/2
            viewBG.clipsToBounds = true
            viewBG.layer.cornerRadius = 8
            viewBG.layer.borderWidth = 1
            viewBG.layer.borderColor = UIColor.lightGray.cgColor
            viewBG.clipsToBounds = true
            cell?.contentView.addSubview(viewBG)
            viewBG.backgroundColor = .clear
            
            let title: UILabel! = UILabel()
            title.frame = CGRect(x: 0, y: 0, width: viewBG.frame.size.width, height: viewBG.frame.size.height)
            let dictData = FiltersNewVM.shared.arraySizeData[indexPath.row]
            let sizeText = dictData.fld_name
            title.text = sizeText
            title.numberOfLines = 1
            title.backgroundColor = .clear
            title.textAlignment = .center
            title.textColor = .darkGray
            title.font = UIFont.boldSystemFont(ofSize: 14)
            viewBG.addSubview(title)
            
            if array_SizeSelecteditems.contains(self.arraySizeDa[indexPath.row]) {
               viewBG.backgroundColor = .blue
               title.textColor = .white
            } else {
               viewBG.backgroundColor = .clear
               title.textColor = .darkText
            }
            return cell!
        }
        return UICollectionViewCell()
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewCategory {
           return CGSize(width: 120, height: 45)
        } else if collectionView == collectionViewColor {
           return CGSize(width: 55, height: 55)
        } else if collectionView == collectionViewSize {
           return CGSize(width: 60, height: 55)
        }
           return CGSize(width: 0, height: 0)
    }
      
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategory {
            if !array_selecteditems.contains(self.arrayCategoryDa[indexPath.row]) {
                array_selecteditems.add(self.arrayCategoryDa[indexPath.row])
            } else {
                array_selecteditems.remove(self.arrayCategoryDa[indexPath.row])
            }
            ary_temp = array_selecteditems
            print("ary_temp:", ary_temp ?? 0)
            str_CAt_ids = NSMutableString()
               for i in 0 ..< ary_temp.count {
                if (i == (ary_temp.count)-1) {
                    if let dictData = ary_temp[i] as? Dictionary<String, Any> {
                        print("fld_cat_id:",dictData["fld_cat_id"] as? Int ?? 0)
                        if let idvalue = dictData["fld_cat_id"] as? Int {
                            let aStr = String(format:"%@", "\(idvalue)")
                            str_CAt_ids.append("\(aStr)")
                        }
                    }
                } else {
                    if let dictData = ary_temp[i] as? Dictionary<String, Any> {
                        print("fld_cat_id:",dictData["fld_cat_id"] as? Int ?? 0)
                        if let idvalue = dictData["fld_cat_id"] as? Int {
                            let aStr=String(format:"%@,", "\(idvalue)")
                            str_CAt_ids.append("\(aStr)")
                        }
                    }
                 }
            }
            print("str_CAt_ids:",str_CAt_ids!)
            collectionViewCategory.reloadData()
        } else if collectionView == collectionViewColor {
            if !array_ColorSelecteditems.contains(self.arrayColorDa[indexPath.row]) {
                array_ColorSelecteditems.add(self.arrayColorDa[indexPath.row])
             } else {
                array_ColorSelecteditems.remove(self.arrayColorDa[indexPath.row])
             }
                ary_tempColor = array_ColorSelecteditems
                print("ary_tempColor:", ary_tempColor ?? 0)
                str_Colorid = NSMutableString()
                for i in 0 ..< ary_tempColor.count {
                           if (i == (ary_tempColor.count)-1) {
                               if let dictData = ary_tempColor[i] as? Dictionary<String, Any> {
                                   print("fld_id:",dictData["fld_id"] as? Int ?? 0)
                                   if let idvalue = dictData["fld_id"] as? Int {
                                       let aStr = String(format:"%@", "\(idvalue)")
                                       str_Colorid.append("\(aStr)")
                                   }
                               }
                           } else {
                               if let dictData = ary_tempColor[i] as? Dictionary<String, Any> {
                                   print("fld_id:",dictData["fld_id"] as? Int ?? 0)
                                   if let idvalue = dictData["fld_id"] as? Int {
                                       let aStr=String(format:"%@,", "\(idvalue)")
                                       str_Colorid.append("\(aStr)")
                                   }
                               }
                            }
                       }
                       print("str_Colorid:",str_Colorid!)
        } else if collectionView == collectionViewSize {
            if !array_SizeSelecteditems.contains(self.arraySizeDa[indexPath.row]) {
                array_SizeSelecteditems.add(self.arraySizeDa[indexPath.row])
             } else {
                array_SizeSelecteditems.remove(self.arraySizeDa[indexPath.row])
             }
                ary_tempSize = array_SizeSelecteditems
                print("ary_tempSize:", ary_tempSize ?? 0)
                str_Sizeid = NSMutableString()
                for i in 0 ..< ary_tempSize.count {
                           if (i == (ary_tempSize.count)-1) {
                               if let dictData = ary_tempSize[i] as? Dictionary<String, Any> {
                                   print("fld_id:",dictData["fld_id"] as? Int ?? 0)
                                   if let idvalue = dictData["fld_id"] as? Int {
                                       let aStr = String(format:"%@", "\(idvalue)")
                                       str_Sizeid.append("\(aStr)")
                                   }
                               }
                           } else {
                               if let dictData = ary_tempSize[i] as? Dictionary<String, Any> {
                                   print("fld_id:",dictData["fld_id"] as? Int ?? 0)
                                   if let idvalue = dictData["fld_id"] as? Int {
                                       let aStr=String(format:"%@,", "\(idvalue)")
                                       str_Sizeid.append("\(aStr)")
                                   }
                               }
                            }
                       }
                       print("str_Sizeid:",str_Sizeid!)
            
            self.collectionViewSize.reloadData()
            
        }

    }
     
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      
    }
    

}

