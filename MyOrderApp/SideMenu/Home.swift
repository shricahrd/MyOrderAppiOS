//  ViewController.swift
//  DemoSlider
//  Created by RAKESH KUSHWAHA on 09/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
import SideMenu
class Home: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    var menu: SideMenuNavigationController?
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var imageDetailBg: UIImageView!
    @IBOutlet var hostButton: UIButton!
    @IBOutlet var verticlehight: NSLayoutConstraint!
    @IBOutlet var viewButtonBG: UIView!
    @IBOutlet var hightconstraint: NSLayoutConstraint!
    @IBOutlet var quizButton: UIButton!
    @IBOutlet var imagequiz: UIImageView!
    @IBOutlet var joinButton: UIButton!
    @IBOutlet var imagejoin: UIImageView!
    @IBOutlet var titleName: UIBarButtonItem!
    
    var quizSelect = false
    var scrollView = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var pageControl : UIPageControl!
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var tableViewList = UITableView()
    var arraysection = [String]()
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var arraybanners:[BannerDatum]?
    var arrayHotDeals: [HotDealsDatum]?
    var arrayNewCollection: [NewCollectionDatum]?
    var arrayMain = NSMutableArray()
    var arrayFinal = NSMutableArray()
    var tagValue = 0
    var isHotDeals = true
    var textFieldSearch: UITextField!
    var tableViewDropDown = UITableView()
    var arrayAfterSearch: [ProductSearchDatum]? = []
    enum TableSection {
        static let hotDeal = 0
        static let newCollection = 1
        static let count = 2
    }

    override func viewDidLoad() {
       super.viewDidLoad()
       self.navigationController!.setNavigationBarHidden(false,animated: false)
       self.navigationItem.hidesBackButton = true
       self.screenWidth = screenSize.width
       self.screenHeight = screenSize.height
       arraysection = ["Hot Deal", "New Collection"]
       textFieldSearch = UITextField()
    
       let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
       print("topBarHeight:", topBarHeight)
        
       textFieldSearch.frame = CGRect(x: 16, y: topBarHeight+10, width: view.frame.size.width - 32 , height: 40)
       textFieldSearch.delegate = self
       self.view.addSubview(textFieldSearch)
        
       textFieldSearch.layer.borderColor = UIColor.gray.cgColor
       textFieldSearch.layer.borderWidth = 1
       textFieldSearch.layer.cornerRadius = 20
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
        textFieldSearch.layer.cornerRadius = 20.0
        textFieldSearch.isSecureTextEntry = false
        textFieldSearch.leftViewMode = .always
        textFieldSearch.rightViewMode = .always
        textFieldSearch.tag = 100
        textFieldSearch.returnKeyType = .next
        textFieldSearch.keyboardType = UIKeyboardType.asciiCapable

        let imagesearch = UIImageView()
        imagesearch.frame = CGRect(x:15, y: 10, width:  18, height: 18)
        imagesearch.image = UIImage(named: "search")
        imagesearch.backgroundColor = .clear
        imagesearch.contentMode = .scaleAspectFit
        textFieldSearch.addSubview(imagesearch)
    
        scrollView = UIScrollView(frame: CGRect(x:0, y: self.textFieldSearch.frame.maxY+10, width: self.view.frame.width, height: 140))
       pageControl = UIPageControl(frame: CGRect(x:0,y: 280, width: self.view.frame.width, height: 30))
       configurePageControl()
       scrollView.delegate = self
       scrollView.isPagingEnabled = true
       scrollView .showsHorizontalScrollIndicator = false
       self.view.addSubview(scrollView)
               
       registerNibs()
       banners()
       callTableViewDropDown()
//       hartDeales(productType: "hot_deals", pagnumber:0)
        self.callHomeProductApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(false, animated: true)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        addNavBarImage()
    }
    
    func callTableViewDropDown() {
        tableViewDropDown = UITableView()
        tableViewDropDown.frame = CGRect(x:0,y: textFieldSearch.frame.maxY + 10, width:self.view.frame.width, height:self.view.frame.height - (textFieldSearch.frame.maxY + 10))
        tableViewDropDown.register(UINib(nibName: "PredictCell", bundle: nil), forCellReuseIdentifier: "PredictCell")
        tableViewDropDown.delegate = self
        tableViewDropDown.dataSource = self
//      tableViewDropDown.separatorStyle = .none
        tableViewDropDown.keyboardDismissMode = .interactive
        tableViewDropDown.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
        self.view.addSubview(tableViewDropDown)
        self.tableViewDropDown.isHidden = true

    }
    
    
    func homeProducts(fldPageNo:String) {
        
//        ApiClient.loder(roughter: APIRouter.homeProducts(fldPageNo: fldPageNo)) { (productData:) in

//        }
    }
    
    
    func productsearch(userId:String, SearchTxt:String) {
        ApiClient.loder(roughter: APIRouter.productsearch(userId: userId, SearchTxt: SearchTxt)) { (productSearch: ProductSearchResponce) in
            print("productSearch:", productSearch)
            var _:ProductSearchResponce?
            if productSearch.status  == true {
             if productSearch is Dictionary<String, Any> {
              // searchDoctorObject = ProductDetailesResponce(from: dataDict as! Decoder)
              }
              self.arrayAfterSearch = productSearch.productSearchData ?? []
              print("self.arrayAfterSearch: ", self.arrayAfterSearch ?? [])
             
              if (self.arrayAfterSearch ?? []).count > 0 {
                  DispatchQueue.main.async {
                    self.tableViewDropDown.isHidden=false
                  }
              } else {
                 DispatchQueue.main.async {
                     self.tableViewDropDown.isHidden=true
//                   self.lbl_Msg.frame=CGRect(x: 10,y: 176,width: self.tableViewList.frame.size.width-20,height: 45);
//                   self.lbl_Msg.isHidden=false
                    }
                 }
                 DispatchQueue.main.async {
                    self.tableViewDropDown.reloadData();
                 }
               } else {
                  self.arrayAfterSearch?.removeAll()
                  self.tableViewDropDown.isHidden=true
                  Utility.showAlert(withMessage: productSearch.message ?? "", onController: self)
                   DispatchQueue.main.async {
                      self.tableViewDropDown.reloadData();
                   }
             }
        }
    }

    func callHomeProductApi() {
        let json = [
            "fld_page_no":"0"
            ]  as [String : Any]
        print("Detail json: ", json)
        postMyOrderAPIAction(WebService.homeProducts, parameters: json, showGenricErrorPopup: false) { (response) in
        print("response detail:", response ?? "")
        DispatchQueue.main.async {
//         DIProgressHud.hide()
        }
         if let status = response?.object(forKey: "status") as? Bool, status == true {
            DispatchQueue.main.async {
                if let dataArray = response?["Home_Product_Listing"] as? NSArray, dataArray.count > 0 {
                    self.arrayFinal = dataArray as! NSMutableArray
                    print("self.arrayFinal:", self.arrayFinal);
                }
              }
              DispatchQueue.main.async {
                 self.tableViewList.reloadData()
              }
            }
            print("self.arrayFinal:", self.arrayFinal);
       }
    }

    func hartDeales(productType:String,pagnumber:Int) {
           ApiClient.loder(roughter: APIRouter.hotDeals(productType: productType, pageNumber: pagnumber)) { (hartDeales: HartDeailesResponce) in
            if hartDeales.status == true {
             print(hartDeales)
              self.arrayHotDeals = hartDeales.hotDealsData ?? []
              print("self.arrayHotDeals: ", "\(String(describing: self.arrayHotDeals))")
              for dict in self.arrayHotDeals! {
                  let defaultImage = "\(String(describing: dict.defaultImage!))"
                  let name = "\(String(describing: dict.name!))"
                  let fldBrandName = "\(String(describing: dict.fldBrandName!))"
                  let spclPrice = "\(String(describing: dict.spclPrice!))"
                  let extraPrice = "\(String(describing: dict.extraPrice!))"
                                     
                  let dictData = [
                      "name": name,
                      "defaultImage": defaultImage,
                      "fldBrandName": fldBrandName,
                      "spclPrice": spclPrice,
                      "extraPrice": extraPrice
                  ]
                                     
             //                        let dictData1 = [
             //                            "name": name,
             //                            "defaultImage": defaultImage,
             //                            "fldBrandName": fldBrandName,
             //                            "spclPrice": spclPrice,
             //                            "extraPrice": extraPrice
             //                                        ]
                                     self.arrayMain.add(dictData)
             //                      self.arrayMain.add(dictData1)
                                        
             //                        var arra1 = NSMutableArray()
             //                      arra1.add(dictData);
                                     
                                     var dict = [
                                                 "title":"Hot Deals",
                                                 "data":self.arrayMain
                                                ] as [String : Any]
                                     self.arrayFinal.add(dict)
                                     print("self.arrayFinal:","\(self.arrayFinal)")

             //                        var dict1 = [
             //                                     "title":"New Collections",
             //                                     "data":arra1
             //                                    ] as [String : Any]
             //                        self.arrayFinal.add(dict1)
             //                        print("self.arrayFinal:","\(self.arrayFinal)")
                   }
//                   self.newCollection(productType: "new_collection", pageNumber: 0)
            } else {
                Utility.showAlert(withMessage: hartDeales.message ?? "", onController: self)
            }
           }
       }
    
    func newCollection(productType:String,pageNumber:Int) {
        ApiClient.loder(roughter: APIRouter.hotDeals(productType: productType, pageNumber: pageNumber)) { (newcollection: NewCollectionResponce) in
         if newcollection.status == true {
              print(newcollection)
              self.arrayNewCollection = newcollection.newCollectionData ?? []
              print("self.arrayNewCollection: ", "\(String(describing: self.arrayNewCollection))")
              let arrayData = NSMutableArray()
              for dict in self.arrayNewCollection! {
                  let defaultImage = "\(String(describing: dict.defaultImage!))"
                  let name = "\(String(describing: dict.name!))"
                  let fldBrandName = "\(String(describing: dict.fldBrandName!))"
                  let spclPrice = "\(String(describing: dict.spclPrice!))"
                  let extraPrice = "\(String(describing: dict.extraPrice!))"
                  let id = "\(String(describing: dict.id!))"
                  let catID = "\(String(describing: dict.catID!))"
//                let colorID = "\(String(describing: dict.colorID!))"
                  let dictData = [
                      "name": name,
                      "defaultImage": defaultImage,
                      "fldBrandName": fldBrandName,
                      "spclPrice": spclPrice,
                      "extraPrice": extraPrice,
                      "id": id,
                      "catID": catID
                  ]
                 arrayData.add(dictData)
                 let dict1 = [
                               "title":"New Collections",
                               "data":arrayData
                              ] as [String : Any]
                  self.arrayFinal.add(dict1)
                  print("self.arrayFinal:","\(self.arrayFinal)")
              }
              print("self.arrayMain:","\(self.arrayMain)")
              self.tableViewList.reloadData()
            } else {
                Utility.showAlert(withMessage: newcollection.message ?? "", onController: self)
            }
        }
    }
    
    
    func banners()  {
        ApiClient.loder(roughter: APIRouter.banners) { (banners:BannersResponce) in
            print("banners","\(banners)")
            if banners.status == true {
               self.arraybanners = banners.bannerData
                DispatchQueue.main.async {
                    if self.arraybanners!.count != nil {
                       self.callUiSetUp()
                    }
                }
            } else {
                Utility.showAlert(withMessage: banners.message ?? "", onController: self)
            }
        }
    }

    func callUiSetUp() {
        let dictData =  self.arraybanners
        var index = 0
        for dict in dictData! {
            print("dict:","\(dict)")
            index += 1
            self.pageControl.numberOfPages = dictData!.count
            self.pageControl.currentPage = 0
            let imgViewSplash = UIImageView()
            imgViewSplash.frame = CGRect(x: self.scrollView.frame.size.width * CGFloat(index-1), y: 0, width: self.view.frame.size.width,height: self.scrollView.frame.size.height)
            imgViewSplash.backgroundColor = UIColor.white
            imgViewSplash.sd_setImage(with: URL(string:"\("https://aptechbangalore.com/myorder/uploads/products/1592564800-435.jpg" )"), placeholderImage: UIImage(named: "Banner"))
            imgViewSplash.isUserInteractionEnabled = true
            imgViewSplash.contentMode = .scaleAspectFill
            imgViewSplash.clipsToBounds = true
            self.scrollView.addSubview(imgViewSplash)
         }
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }

    func registerNibs() {
        tableViewList = UITableView()
        tableViewList.frame = CGRect(x:0,y: pageControl.frame.maxY + 2, width:self.screenWidth, height:self.screenHeight - (pageControl.frame.maxY + 4))
        tableViewList.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.separatorStyle = .none
        tableViewList.keyboardDismissMode = .interactive
        tableViewList.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
        self.view.addSubview(tableViewList)
     }
    
     func configurePageControl() {
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        self.view.addSubview(pageControl)
     }

     // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
     @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
     }

     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
         pageControl.currentPage = Int(pageNumber)
     }
    
    func addNavBarImage() {
          let navController = navigationController!
          let image = UIImage(named: "logo")
          let imageView = UIImageView(image: image)
          let bannerWidth = navController.navigationBar.frame.size.width-20
          let bannerHeight = navController.navigationBar.frame.size.height-20
          let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
          let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
          imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
          imageView.contentMode = .scaleAspectFit
          navigationItem.titleView = imageView
    }

    @IBAction func quizAction(_ sender: Any) {
        if quizSelect == false {
           quizSelect = true
           quizButton.isHidden = true
           //imagequiz.isHidden = true
           UIView.animate(withDuration: 2, delay: 2, options: .curveEaseIn, animations: {
               self.viewButtonBG.isHidden = false
               self.hightconstraint.constant = 150
           }) { _ in
                print("complete animation")
           }
        } else {
            quizSelect = false
            UIView.animate(withDuration: 2, delay: 2, options: .curveEaseIn, animations: {
                self.viewButtonBG.isHidden = true
                self.hightconstraint.constant = 0
            }) { _ in
                print("complete animation")
            }
        }
    }
    
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
    @objc func viewAllAction(_ sender: UIButton) {
//          let index = sender.tag
//          let indexSelected = NSNumber(value: index)
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
              if let vc = storyboard.instantiateViewController(withIdentifier: "SearchProductController") as? SearchProductController { // SearchByBrandController
                 self.navigationController?.pushViewController(vc, animated: true)
           }
    }
    
    
    // MARK: - Tableview Method
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableViewDropDown {
           
            return 1
        } else {
            return self.arrayFinal.count
        }
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewDropDown {
           if arrayAfterSearch?.count ?? 0 > 0 {
              return arrayAfterSearch?.count ?? 0
           }
           return 0
        } else {
           return 1
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return 50
    }
      
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
      
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tableViewDropDown {
           return 0
        } else {
           return 45
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 45)
        sectionHeader.backgroundColor = .white
        let heading = UILabel()
        heading.frame = CGRect(x: 10, y: 0, width: tableView.frame.size.width-20, height: 45)
        if let dict = self.arrayFinal[section] as? Dictionary<String, Any> {
           heading.text = "  \(dict["title"] as? String ?? "")"
        }
        heading.font = UIFont(name: "calibrib", size: 22)
        
        heading.textColor = .black
        heading.backgroundColor = .white
        sectionHeader.addSubview(heading)
        
        let viewAll = UIButton()
        viewAll.frame = CGRect(x: tableView.frame.size.width-80, y: 0, width: 80, height: 45)
        viewAll.setTitle("View All", for: .normal)
        viewAll.setTitleColor(UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0,alpha:1.0), for: UIControl.State.normal)
        viewAll.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
//        viewAll.backgroundColor = UIColor(red:28.0 / 255.0, green:72.0 / 255.0, blue:156.0 / 255.0,alpha:1.0)
        sectionHeader.addSubview(viewAll)
        viewAll.addTarget(self, action: #selector(self.viewAllAction), for: UIControl.Event.touchUpInside)
        viewAll.tag = section;
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewDropDown {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PredictCell", for: indexPath) as? PredictCell {
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0,alpha:1.0)
                if self.arrayAfterSearch?.count ?? 0 > 0 {
                     let productData = self.arrayAfterSearch?[indexPath.row]
                     if let searchName = productData?.searchName {
                        cell.productname.text = "\(String(describing: searchName))"
                    }
                }
                return cell
            }
        } else {
               let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
               cell.selectionStyle = .none
               cell.contentView.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
               cell.viewBG.backgroundColor = UIColor(red:242.0 / 255.0, green:242.0 / 255.0, blue:242.0 / 255.0,alpha:1.0)
               layout = UICollectionViewFlowLayout()
               collectionView = UICollectionView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.screenWidth), height: CGFloat(cell.viewBG.frame.height)), collectionViewLayout: layout)
               layout.scrollDirection = .horizontal
               collectionView.dataSource = self
               collectionView.tag = indexPath.section
               collectionView.dataSource = self
               collectionView.delegate = self
               collectionView.isScrollEnabled = true
               collectionView.isPagingEnabled = true
               collectionView.bounces = true
               collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
               collectionView.backgroundColor = UIColor.white
               collectionView.showsHorizontalScrollIndicator = false
               collectionView.showsVerticalScrollIndicator = true
               layout.minimumInteritemSpacing = 0
               layout.minimumLineSpacing = 0
               cell.viewBG.addSubview(collectionView)
               return cell
        }
        
         return UITableViewCell()

      }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
        if tableView == tableViewDropDown {
            let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SearchProductController") as? SearchProductController { // SearchByBrandController
                    attachedPrescriptionListController.productName = "\(textFieldSearch.text!)"
                     self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
                 }
        } else {
        }
      }
    
      // MARK: - Collection View Data Source and Delegate Methods
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagValue = collectionView.tag  //"home_data": [
        if let dict = self.arrayFinal[tagValue] as? NSDictionary {
            if let arraymine = dict.value(forKey:  "home_data") as? NSMutableArray {
                return arraymine.count
            }
        }
        return 0
//      if ([[[ary_Data objectAtIndex:tagValue] valueForKey:@"SubSubCategory"] count]>0) {
//               return [[[ary_Data objectAtIndex:tagValue] valueForKey:@"SubSubCategory"] count];
//      }
//      if tagValue == 0 {
//         return arrayHotDeals?.count ?? 0
//      } else {
//         return 5
//      }
      }
      
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
          return CGSize(width: 0, height: 0)
      }
      

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
          for view: UIView in (cell?.contentView.subviews)! {
              view.removeFromSuperview()
          }
          let viewBG: UIView! = UIView()
          viewBG.frame = CGRect(x: 4, y: 5, width: (cell?.frame.size.width)!-8, height: (cell?.frame.size.height)!-8)
          viewBG.backgroundColor = .white
          viewBG.layer.cornerRadius = 8
          viewBG.clipsToBounds = true
          cell?.contentView.addSubview(viewBG)
          
          let imageProduct: UIImageView! = UIImageView()
          imageProduct.frame = CGRect(x: 0, y: 0, width: viewBG.frame.size.width, height: viewBG.frame.size.height - 100)
          
          imageProduct.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
          imageProduct.layer.cornerRadius = 6
      
          viewBG.addSubview(imageProduct)

        let nameProduct: UILabel! = UILabel()
          nameProduct.frame = CGRect(x: 2, y: imageProduct.frame.maxY+1, width: imageProduct.frame.size.width-4, height: 25)
          nameProduct.numberOfLines = 2
          nameProduct.backgroundColor = .clear
          nameProduct.textAlignment = .left
          nameProduct.textColor = UIColor(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0, alpha: 1)
          nameProduct.font = UIFont(name: nameProduct.font.fontName, size: 12)
          viewBG.addSubview(nameProduct)
        
        let productType: UILabel! = UILabel()
        productType.frame = CGRect(x: 2, y: nameProduct.frame.maxY+1, width: nameProduct.frame.size.width-4, height: 25)
        productType.numberOfLines = 2
        productType.backgroundColor = .clear
        productType.textAlignment = .left
        productType.textColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
        productType.font = UIFont(name: productType.font.fontName, size: 12)
        viewBG.addSubview(productType)
        
        let rupee: UILabel! = UILabel()
        rupee.frame = CGRect(x: 2, y: productType.frame.maxY, width: nameProduct.frame.size.width/2-8, height: 30)
        rupee.numberOfLines = 2
        rupee.backgroundColor = .clear
        rupee.textAlignment = .left
        rupee.textColor = .darkText
        rupee.font = UIFont(name: rupee.font.fontName, size: 12)
        viewBG.addSubview(rupee)
        
        let discount: UILabel! = UILabel()
        discount.frame = CGRect(x: rupee.frame.maxX, y: productType.frame.maxY, width: nameProduct.frame.size.width/2, height: 30)
        discount.numberOfLines = 1
        discount.backgroundColor = .clear
        discount.textAlignment = .left
        discount.textColor = .gray
        discount.font = UIFont(name: discount.font.fontName, size: 12)
        viewBG.addSubview(discount)
        
        let percentage: UILabel! = UILabel()
        percentage.frame = CGRect(x: 5, y: 5, width: 40, height: 25)
        percentage.numberOfLines = 2
        percentage.backgroundColor = .clear
        percentage.textAlignment = .center
        percentage.layer.cornerRadius = 10
        percentage.clipsToBounds = true
        percentage.backgroundColor = UIColor(red: 216.0/255.0, green: 38.0/255.0, blue: 35.0/255.0, alpha: 1)
        percentage.textColor = UIColor.white
        percentage.font = UIFont(name: productType.font.fontName, size: 12)
        imageProduct.addSubview(percentage)

        if let dict = self.arrayFinal[tagValue] as? NSDictionary {
             if let arraymine = dict.value(forKey: "home_data") as? NSMutableArray {
                if let dict = (arraymine[indexPath.row] as AnyObject) as? NSDictionary {
                    var priceValue = ""
                    var spclpriceValue = ""
                    var discountValue = ""
                    let name = dict["name"] as? String ?? ""
                    let fldBrandName = dict["fld_brand_name"] as? String ?? ""
                    
                   if let spclPrice = dict["spcl_price"] as? String {
                    spclpriceValue = "\(spclPrice)"
                    }
                    if let spclPrice = dict["spcl_price"] as? Int {
                         spclpriceValue = "\(spclPrice)"
                     }
                    if let pricePrice = dict["price"] as? String {
                      priceValue = "\(pricePrice)"
                    }
                    if let pricelPrice = dict["price"] as? Int {
                       priceValue = "\(pricelPrice)"
                    }
                    if let prd_discount = dict["prd_discount"] as? String {
                       discountValue = "\(prd_discount)"
                    }
                    
                    let defaultImage = dict["default_image"] as? String ?? ""
                    print("name:", name)
                    
//                  let discount = priceValue -
                    
                    imageProduct.sd_setImage(with: URL(string:"\(defaultImage )"), placeholderImage: UIImage(named: "productImageplaceholder"))
                    imageProduct.contentMode = .scaleAspectFill
                    imageProduct.clipsToBounds = true;
                    nameProduct.text = "\(String(describing: name))".capitalized
                    productType.text = "\(String(describing: fldBrandName))".capitalized
                    rupee.text = "\u{20B9}\(String(describing: spclpriceValue))"
                    discount.text = "\u{20B9}\(String(describing: priceValue))"
                    percentage.text = "\(discountValue)"
                 }
             }
          }
        
          let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "  \(discount.text!)  " )
          attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 3, range: NSMakeRange(0, attributeString.length))
          discount.attributedText = attributeString
          return cell!
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  CGFloat((self.view.frame.size.width) / 2.9), height: 280)
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 5
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 5
      }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 8, bottom: 7, right: 8)
      }
      
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController!.setNavigationBarHidden(true,animated: false)
        self.navigationItem.hidesBackButton = true
        if let dict = self.arrayFinal[tagValue] as? NSDictionary {
             if let arraymine = dict.value(forKey: "home_data") as? NSMutableArray {
                if let dict = (arraymine[indexPath.row] as AnyObject) as? NSDictionary {
                   var idvalue = ""
                   if let id = dict["id"] as? Int {
                      idvalue = "\(id)"
                   }
                   if let id = dict["id"] as? String {
                      idvalue = "\(id)"
                   }
                   print("id:", idvalue)
                   let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                   if let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailController") as? ProductDetailController {
                      vc.str_fld_product_id = "\(idvalue)"
                      self.navigationController?.pushViewController(vc, animated: true)
                   }
                }
             }
          }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view!.endEditing(true)
                self.resignKeyboard()
                UIView.animate(withDuration: Double(0.5),
                                                  delay: 0.0,
                                                  options: .beginFromCurrentState, animations: { () -> Void in
    //                                               self.customPopUp.isHidden = true
                 }, completion: { (Bool) -> Void in
                })
    }

   func textField(_ textField:UITextField,shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        if textFieldSearch.isEditing == true {
            let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if substring != ""{
//              self.tableViewDropDown.isHidden = false
               self.productsearch(userId:"1", SearchTxt: "\(substring)" )
            } else {
                self.arrayAfterSearch?.removeAll()
                self.tableViewDropDown.isHidden = true
                self.tableViewDropDown.reloadData()
            }
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
//                let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
//                if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SearchProductController") as? SearchProductController { // SearchByBrandController
//                   attachedPrescriptionListController.productName = "\(textFieldSearch.text!)"
//                    self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
//                }
      }
}


class MenuListController: UITableViewController {
    
    var items = ["", "Search by Category", "Men", "Women", "Kids", "My Orders", "Wishlist", "Cart", "Invoice", "Ledger", "Issues", "About", "Help & Support"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    func registerNibs() {
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MenuUserNameCell", bundle: nil), forCellReuseIdentifier: "MenuUserNameCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else {
            return 50
        }
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier:"MenuUserNameCell", for: indexPath as IndexPath) as! MenuUserNameCell
            cell.viewBG.backgroundColor = .white
            cell.contentView.backgroundColor = .white
            //cell.imagemenuBag.image = items[indexPath.row]
            cell.userName.text = "Hello, Rakesh Kumar"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:"CategoryCell", for: indexPath as IndexPath) as! CategoryCell
            cell.name.text = items[indexPath.row]
            cell.name.textColor = .darkText
            cell.contentView.backgroundColor = .white
            
            if indexPath.row == 1 {
                cell.contentView.backgroundColor = .lightGray
                cell.imageArrow.isHidden = true
            } else {
                
            }
            return cell
        }
        return UITableViewCell()
     }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "ChangeLanguageViewController") as? ChangeLanguageViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 3 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "SignOutViewController") as? SignOutViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        if indexPath.row == 4 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "FriendListViewController") as? FriendListViewController {
                self.navigationController?.pushViewController(apptDetailController, animated: true)
            }
        }
        
        if indexPath.row > 4 {
            if indexPath.row == 5 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "MyOrderStatusController") as? MyOrderStatusController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 6 {
               let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
               if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "InvitesViewController") as? InvitesViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 7 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "MywalletViewController") as? MywalletViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 8 {
               let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
               if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "MessageViewController") as? MessageViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
               }
            }
            if indexPath.row == 9 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizMarketViewController") as? QuizMarketViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 10 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizhistoryViewController") as? QuizhistoryViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 11 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizbattelViewController") as? QuizbattelViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 12 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizbattelViewController") as? QuizbattelViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }
            if indexPath.row == 13 {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let apptDetailController = storyboard.instantiateViewController(withIdentifier: "QuizLeagueViewController") as? QuizLeagueViewController {
                    self.navigationController?.pushViewController(apptDetailController, animated: true)
                }
            }

        }

    }
    
    
}
