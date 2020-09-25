//  ProductDetailController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
import WebKit

class ProductDetailController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WKUIDelegate, UITextFieldDelegate {
    @IBOutlet var viewBg: UIView!
    var screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var scrollViewMain = UIScrollView()
    var scrollViewPager = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.orange, UIColor.red, UIColor.blue, UIColor.green, UIColor.orange]
    var pageControl : UIPageControl!
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var imgViewSplash = UIImageView()
    var arrayData = ["Invite Friends", "Fantasy Point System", "How to Play", "HelpDesk","About Us"]
    var tableViewList = UITableView()
    var layout: UICollectionViewFlowLayout!
    var collectionViewColor: UICollectionView!
    
    var dictData = NSDictionary()
    var arrayBannerImage = NSMutableArray()
    var arrayColor = NSMutableArray()
    var arraySizes = NSMutableArray()
    var str_fld_product_id = ""
    var strfldproductid = ""
    var srtfldcolorid = ""
    var couponText = ""
    enum TableSection {
       static let productDetail = 0
       static let color = 1
       static let sizes = 2
       static let quantity = 3
       static let totalquantity = 4
       static let count = 5
    }
    var collectionWidth: CGFloat = 0.0
    var collectionHeight: CGFloat = 0.0
    var thumbeNell:[Thumbnail] = []
    var viewBottomBg = UIView()
    var btnAddToCart = UIButton()
    var valueToPass : String?
    var strcartcount = 0
    var cartCountLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.setNavigationBarHidden(true,animated: false)
        self.navigationItem.hidesBackButton = true
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        self.uiSetUpScrollView()
    }
    
     func uiSetUpScrollView() {
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

        
        cartCountLabel = UILabel()
        cartCountLabel.frame = CGRect(x:screenWidth-46, y: 28, width:  24, height: 24);
        self.cartCountLabel.layer.cornerRadius = self.cartCountLabel.frame.width/2
        self.cartCountLabel.clipsToBounds = true
        self.cartCountLabel.layer.borderColor = UIColor.white.cgColor
        self.cartCountLabel.layer.borderWidth = 2
        self.cartCountLabel.textAlignment = .center
        self.cartCountLabel.textColor = .white
        self.cartCountLabel.backgroundColor = .red
        self.cartCountLabel.font = UIFont(name:"Arial",size:12.0)
        viewHeaderBg.addSubview(self.cartCountLabel)
        

        //self.strcartcount = 2
        if self.strcartcount > 0 {
           self.cartCountLabel.isHidden = false
           self.cartCountLabel.text = "\(self.strcartcount)"
        } else {
           self.cartCountLabel.isHidden = true
        }
        
        scrollViewMain.frame = CGRect(x: 0, y: 75, width: screenWidth, height: screenHeight-75);
        scrollViewMain.bounces = true
        scrollViewMain.delegate = self
        scrollViewMain.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        view.addSubview(scrollViewMain)
        
        scrollViewPager = UIScrollView(frame: CGRect(x:0, y:0, width:self.view.frame.width,height: 180))
        pageControl = UIPageControl(frame: CGRect(x:0,y: 280, width:self.view.frame.width, height:50))
        configurePageControl()
        scrollViewPager.delegate = self
        scrollViewPager.isPagingEnabled = true
        scrollViewPager .showsHorizontalScrollIndicator = false
        scrollViewMain.addSubview(scrollViewPager)
        self.callUISetUp();
        self.registerNib()
        self.apiDetail()
    }
    
    func callUISetUp() {
         for index in 0..<self.arrayBannerImage.count {
             self.pageControl.numberOfPages = self.arrayBannerImage.count
             self.pageControl.currentPage = 0
             self.imgViewSplash = UIImageView()
             self.imgViewSplash.frame = CGRect(x: self.view.frame.size.width * CGFloat(index), y: 0, width: self.view.frame.size.width,height: 220)
             self.imgViewSplash.backgroundColor = .white
             if let dict = self.arrayBannerImage[index] as? NSDictionary {
                if let imgString = dict.value(forKey: "image") as? String, let imageURL = URL(string: "\(imgString)") {
                   self.imgViewSplash.setImageWith(imageURL, placeholderImage: UIImage(named: "Banner"))
                }
              }
              self.imgViewSplash.isUserInteractionEnabled = true
              self.imgViewSplash.contentMode = .scaleToFill
              self.imgViewSplash.clipsToBounds = true
              self.scrollViewPager.addSubview(self.imgViewSplash)
          }
        self.pageControl.frame = CGRect(x: 100, y: self.scrollViewPager.frame.maxY - 30, width: self.scrollViewPager.frame.width - 200, height: 30)
        self.pageControl.isUserInteractionEnabled = true
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.currentPageIndicatorTintColor = .black
        self.pageControl.tintColor = UIColor(red: 4.0 / 255.0, green: 202.0 / 255.0, blue:169.0 / 255.0, alpha: 1.0)
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 4.0 / 255.0, green: 202.0 / 255.0, blue:169.0 / 255.0, alpha: 1.0)
        self.scrollViewMain.addSubview(self.pageControl)
        
        self.scrollViewPager.contentSize = CGSize(width: self.scrollViewPager.frame.size.width * CGFloat(colors.count), height: self.scrollViewPager.frame.size.height)
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        self.scrollViewMain.contentSize = CGSize(width: 0, height: viewBg.frame.maxY + 300)
        self.callUISetUpWishList();
       
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
        
        btnAddToCart = UIButton()
        btnAddToCart.frame = CGRect(x: 26, y: 28, width: (viewBottomBg.frame.size.width - 52), height: 50)
        btnAddToCart.backgroundColor = .clear
        btnAddToCart.setTitle(" Go To Cart ", for: .normal)
        btnAddToCart.setTitleColor(.white, for: .normal)
        btnAddToCart.layer.borderWidth = 0
        btnAddToCart.layer.cornerRadius = 24
        btnAddToCart.clipsToBounds = true
        btnAddToCart.backgroundColor = .blue
        btnAddToCart.addTarget(self,action:#selector(self.clickOnGoToCart(_:)),for: UIControl.Event.touchUpInside)
        btnAddToCart.isUserInteractionEnabled = true
        viewBottomBg.addSubview(btnAddToCart)
    }
    
    @objc func clickOnGoToCart(_ sender: AnyObject!) {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MyCartController") as? MyCartController {
//           let priductData =  ary_UserList?[indexPath.row]
//           var idvalue = ""
//           if let id = priductData?.id {
//                idvalue = "\(id)"
//            } else  {
//                idvalue = "\(String(describing: priductData?.id!))"
//         }
//         vc.str_fld_product_id = "\(idvalue)"
           self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        self.callAddToCartApi()
    }
    
    func callUISetUpWishList() {
        let likeButton = UIButton()
        likeButton.frame = CGRect(x: self.view.frame.width-70, y: 90, width: 40, height: 40)
        likeButton.setImage(UIImage(named: "heartIcon"), for: .normal)
        likeButton.layer.shadowRadius = 2.0
        likeButton.clipsToBounds = true
        likeButton.backgroundColor = .white
        likeButton.layer.shadowColor = UIColor.black.cgColor
        likeButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        likeButton.layer.masksToBounds = false
        likeButton.layer.shadowRadius = 1.0
        likeButton.layer.shadowOpacity = 0.5
        likeButton.addTarget(self, action: #selector(self.likeAction), for: UIControl.Event.touchUpInside)
        likeButton.tag = 1
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
        if self.dictData.count > 0 {
            if let iswishList = self.dictData.value(forKey: "isInWishlist") as? Bool,iswishList == true {
               likeButton.setImage(UIImage(named: "redheart"), for: .normal)
            } else {
               likeButton.setImage(UIImage(named: "grayheart"), for: .normal)
            }
        } else {
              likeButton.setImage(UIImage(named: "grayheart"), for: .normal)
        }
        self.view.addSubview(likeButton)
    }
    
    @objc func likeAction(_ sender: UIButton) {
        var id = ""
        var iswishlist = "0"
//        let alertController = UIAlertController(title: "", message: "Are you sure you want to add this product in cart?", preferredStyle:.alert)
//        alertController.addAction(UIAlertAction(title:"NO",style:UIAlertAction.Style.default, handler:{(action: UIAlertAction) in
//                    }));
//       alertController.addAction(UIAlertAction(title:"YES", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
//
//      }));
//      self.present(alertController, animated: true, completion: nil)
        if self.dictData.count > 0 {
           if let fld_product_id = self.dictData.value(forKey: "fld_product_id") as? Int{
                         id = "\(fld_product_id)"
                      }
        }
        if let isInWishlist = self.dictData.value(forKey: "isInWishlist") as? Bool, isInWishlist == false {
           iswishlist = "0"
        } else {
           iswishlist = "1"
        }
        self.wishlist_add_update(userId: "1", productId: id, actionType: iswishlist)
     }
    
    func wishlist_add_update(userId:String, productId:String, actionType:String) {
          ApiClient.loder(roughter: APIRouter.wishlistAddUpdate(userId: userId, productId: productId, actionType: actionType)) { (product:WishListAddUpdateResponce) in
             if product.status  == true {
                 self.apiDetail()
             } else {
                  Utility.showAlert(withMessage: product.message ?? "", onController: self)
             }
         }
    }
    
    @objc func clickOnCart(_ sender: AnyObject!) {
 
    }
    
    @objc func clickOnBack(_ sender: AnyObject!) {
        self.navigationController!.setNavigationBarHidden(false,animated: false)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerNib() {
         self.callTableView()
         self.tableViewList.register(UINib(nibName: "ProductDetailCell", bundle: nil), forCellReuseIdentifier: "ProductDetailCell")
         self.tableViewList.register(UINib(nibName: "productColorCell", bundle: nil), forCellReuseIdentifier: "productColorCell")
         self.tableViewList.register(UINib(nibName: "productSizesHeader", bundle: nil), forCellReuseIdentifier: "productSizesHeader")
         let nib = UINib(nibName: "productSizesHeader", bundle: nil)
         self.tableViewList.register(nib, forHeaderFooterViewReuseIdentifier: "productSizesHeader")
         self.tableViewList.register(UINib(nibName: "NumberOfSizesCell", bundle: nil), forCellReuseIdentifier: "NumberOfSizesCell")
         self.tableViewList.register(UINib(nibName: "SupplierNameCell", bundle: nil), forCellReuseIdentifier: "SupplierNameCell")
         self.tableViewList.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
         self.tableViewList.register(UINib(nibName: "ReminderCell", bundle: nil), forCellReuseIdentifier: "ReminderCell")
         self.tableViewList.delegate = self
         self.tableViewList.dataSource = self
         self.tableViewList.separatorStyle = .none
    }
    
    func callTableView() {
        self.tableViewList=UITableView()
        self.tableViewList.frame = CGRect(x: 0, y: self.scrollViewPager.frame.maxY , width: self.scrollViewPager.frame.width, height: scrollViewMain.frame.size.height - (self.scrollViewPager.frame.maxY))
        self.tableViewList.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        self.scrollViewMain.addSubview(tableViewList)
    }
    
    func configurePageControl() {
       self.pageControl.numberOfPages = self.arrayBannerImage.count
       self.pageControl.currentPage = 0
       self.pageControl.tintColor = UIColor.red
       self.pageControl.pageIndicatorTintColor = UIColor.black
       self.pageControl.currentPageIndicatorTintColor = UIColor.green
       self.view.addSubview(pageControl)
    }

    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
          let x = CGFloat(pageControl.currentPage) * self.scrollViewMain.frame.size.width
          self.scrollViewMain.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
         pageControl.currentPage = Int(pageNumber)
    }
    
// MARK: - TableView Delegate Methods
//  func afterClickingReturnInTextField(cell: NumberOfSizesCell) {
//       valueToPass = cell.qtyTextField.text
//       print("valueToPass: ", valueToPass)
//  }

    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == TableSection.productDetail {
            return 1
         } else if section == TableSection.color {
           if self.arrayColor.count > 0 {
            return 1
           } else {
              return 0
           }
        } else if section == TableSection.sizes {
           if self.arraySizes.count > 0 {
              return self.arraySizes.count
           } else {
              return 0
           }
         } else if section == TableSection.quantity {
            if self.dictData.count > 0 {
               if let fld_product_short_description = self.dictData.value(forKey: "fld_product_short_description") as? String {
                  return 1
               } else {
                  return 0
               }
            } else {
                 return 0
            }
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
                if arraySizes.count > 0 {
                     return 35
                }
                return 0
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
                       cell.remove.text = "Add"
                       return cell
                   default:
                       let view1 = UIView.init()
                       return view1
             }
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == TableSection.productDetail {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailCell", for: indexPath) as? ProductDetailCell {
                    cell.selectionStyle = .none
                    cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                    cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                    cell.viewBg.layer.cornerRadius = 0
                    cell.viewBg.clipsToBounds = true
                  
                    if self.dictData.count > 0 {
                        let fld_brand_name = self.dictData.value(forKey: "fld_brand_name") as? String ?? ""
                        let fld_product_name = self.dictData.value(forKey: "fld_product_name") as? String ?? ""
                        let fld_product_price = self.dictData.value(forKey: "fld_product_price") as? Int ?? 0
                        let fld_product_spcl_price = self.dictData.value(forKey: "fld_product_spcl_price") as? Int ?? 0
                        let fld_product_moq = self.dictData.value(forKey: "fld_product_moq") as? Int ?? 0
                        cell.productcolor.text = fld_brand_name.capitalized
                        cell.productName.text = fld_product_name.capitalized

                        cell.quantity.text = "*Min Order Quantity: \(fld_product_moq)"
                        let strspclprice = "\u{20B9}\(fld_product_spcl_price)"
                        cell.price.text = strspclprice//"\u{20B9}\(fld_product_spcl_price )"
                        let strprice = "\u{20B9}\(fld_product_price)"
                        cell.discountPrice.text = strprice
                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "  \(String(describing: cell.discountPrice.text!))  " )
                        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 3, range: NSMakeRange(0, attributeString.length))
                        cell.discountPrice.attributedText = attributeString
                    }
                    return cell
                }
            } else if indexPath.section == TableSection.color {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderCell
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                cell.viewBg.layer.masksToBounds = false
                cell.viewBg.layer.shadowRadius = 2.0
                cell.viewBg.layer.shadowColor = UIColor.black.cgColor
                cell.viewBg.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                cell.viewBg.layer.shadowOpacity = 0.7
                collectionWidth = cell.viewBg.frame.size.width
                collectionHeight = cell.viewBg.frame.size.height
                layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                cell.collectionView.reloadData()
                if layout != nil {
                   cell.collectionView.collectionViewLayout = layout
                   layout.scrollDirection = .horizontal
                }
                cell.collectionView.dataSource = self
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.isScrollEnabled = true
                cell.collectionView.isPagingEnabled = true
                cell.collectionView.bounces = true
                cell.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
                cell.collectionView.backgroundColor = UIColor.clear
                cell.collectionView.showsHorizontalScrollIndicator = false
                cell.collectionView.showsVerticalScrollIndicator = true
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 5
                return cell
            } else if indexPath.section == TableSection.sizes {
              if let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfSizesCell", for: indexPath) as? NumberOfSizesCell {
                 cell.selectionStyle = .none
                 cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                
                 if let dict = self.arraySizes[indexPath.row] as? NSDictionary {
                    print("dict:", dict)
                    var strfldsizeprice = ""
                    var fldsizemoq = ""
                    let fld_size_name = dict.value(forKey: "fld_size_name") as? String ?? ""
//                    let fld_size_moq = dict.value(forKey: "fld_size_moq") as? String ?? ""
                   
                    if let fld_size_price = dict.value(forKey: "fld_size_price") as? Int {
                        strfldsizeprice = "\(fld_size_price)"
                    }
                    if let fld_size_price = dict.value(forKey: "fld_size_price") as? String {
                         strfldsizeprice = "\(fld_size_price)"
                    }
                    
                    if let fld_size_moq = dict.value(forKey: "fld_size_moq") as? Int {
                       fldsizemoq = "\(fld_size_moq)"
                    }
                    if let fld_size_moq = dict.value(forKey: "fld_size_moq") as? String {
                       fldsizemoq = "\(fld_size_moq)"
                    }
                    cell.size.text = fld_size_name
                    cell.price.text = strfldsizeprice
//                  cell.qtyTextField.text = "\(fldsizemoq)"
                    cell.qtyTextField.textAlignment = .center
//                  cell.qtyTextField.placeholder = fldsizemoq
                 }
                cell.qtyTextField.layer.borderWidth = 1
                cell.qtyTextField.layer.borderColor = UIColor.lightGray.cgColor
                cell.qtyTextField.layer.cornerRadius = 4
                cell.qtyTextField.clipsToBounds = true
                 // add the following lines
                 cell.qtyTextField.delegate = self
                 cell.qtyTextField.tag = indexPath.row
                 cell.removeButton.addTarget(self, action: #selector(self.addProductButton), for: UIControl.Event.touchUpInside)
                 cell.removeButton.tag = indexPath.row;
                 cell.removeButton.setImage(UIImage(named: "plusIcon"), for: .normal)
                 return cell
               }
             } else if indexPath.section == TableSection.quantity {
             if let cell = tableView.dequeueReusableCell(withIdentifier: "SupplierNameCell", for: indexPath) as? SupplierNameCell {
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                if self.dictData.count > 0 {
                    if let dict = self.dictData.value(forKey: "fld_seller_info") as? NSDictionary {
                        if let fld_supplier_name = dict.value(forKey: "fld_supplier_name") as? String {
                            cell.supplierName.text = fld_supplier_name
                            cell.name.text = "Supplier Name"
                        }
                    }
                 }
                return cell
               }
             } else if indexPath.section == TableSection.totalquantity {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionCell {
                   cell.selectionStyle = .none
                   cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                   cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                   if self.dictData.count > 0 {
                       if let fld_product_short_description = self.dictData.value(forKey: "fld_product_short_description") as? String {
                          cell.webViewDescription.load(NSURLRequest(url: NSURL(string: "google.ca")! as URL) as URLRequest)
                          let request = URLRequest(url: URL(string: fld_product_short_description)!)
                          cell.webViewDescription?.load(request)
                       }
                   }
                   return cell
                }
             }
            return UITableViewCell()
        }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("text:", textField.text!)
        let index = textField.tag
        let indexSelected = NSNumber(value: index)
         guard let textValue = Int(textField.text!) else { return true }
          if let dict = self.arraySizes[index] as? NSDictionary {
             if let fld_size_moq = dict.value(forKey: "fld_size_moq") as? Int {
                 if (textValue >= fld_size_moq) {
                     print("textValue:", textValue)
                     textField.text = "";
                 } else {
                     let alertController = UIAlertController(title: "", message: "Quantity should be greater or equal to \(fld_size_moq)", preferredStyle:.alert)
                     alertController.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
                           textField.text = "";
                     }));
                     self.present(alertController, animated: true, completion: nil)
                 }
             }
          }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
  
    }
    
    // MARK: - UITextFieldDelegate
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
         print("textField:",textField.text)
        //if editAllergyTextField.text != "" {
        //           if textField.returnKeyType == .done {
        //               if textField == editAllergyTextField {
        //                    if editAllergyTextField.isEditing == true {
        //                        view.endEditing(true)
        //                        addAllergy(self)
        //                    }
        //                }
        //           }
        //        } else {
        //            self.showAlertButtonTapped()
        //}
        return true
    }
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          if textField.isEditing==true {
             let substring=(textField.text! as NSString).replacingCharacters(in: range, with: string)
                        print("substring: ", substring)
                        couponText = "\(substring)"
        //              let tagValue = textField.tag
                     }
        
          return true
     }
        
     func textFieldDidBeginEditing(_ textField: UITextField) {
        
       
//            if textField == editAllergyTextField {
//                var isFind:Bool! = false
//                for i in 0 ..< arrayAddAllergy.count {
//                    if let isOpenSaved = (arrayAddAllergy[i] as! NSDictionary)["isOpenSaved"] as? String,isOpenSaved == "true" {
//                        isFind = true
//                        break
//                    }
//                }
//                if isFind == true {
//                    showAlertButtonTapped(text: "Please save selected allergy first.".diLocalized(using: Constants.bundleName.localize))
//                }
//            }
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
    
    // MARK:- Collection View Metods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return arrayColor.count
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
        let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        for view: UIView in (cell?.contentView.subviews)! {
            view.removeFromSuperview()
        }
        let viewBG: UIView! = UIView()
        viewBG.frame = CGRect(x: 4, y: 4, width: (cell?.frame.size.width)!-8, height: (cell?.frame.size.height)!-8)
        viewBG.backgroundColor = .white
        viewBG.layer.cornerRadius = ((cell?.frame.size.width)!-8)/2
        viewBG.clipsToBounds = true
        viewBG.layer.borderWidth = 1
        viewBG.layer.borderColor = UIColor.blue.cgColor
        //cell?.contentView.addSubview(viewBG)
//      viewBG.backgroundColor = .white
            
        let img = UIImageView()
        img.frame = CGRect(x: 8, y: 8, width: (cell?.frame.size.width)!-16, height: (cell?.frame.size.height)!-16)
        img.layer.cornerRadius = ((cell?.frame.size.width)!-16)/2
        img.clipsToBounds = true
        img.backgroundColor = colors[indexPath.row]
        cell?.contentView.addSubview(img)
        if let dictData = self.arrayColor[indexPath.row] as? Dictionary<String, Any> {
           let fld_code = dictData["fld_color_code"] as? String ?? ""
           var colour = fld_code
           if colour == "" {
              colour = ""
           }
           img.backgroundColor = CommonMethods.sharedInstance.hexStringToUIColorOpacity(hex: colour)
        }
        return cell!
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
      
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dictData = self.arrayColor[indexPath.row] as? Dictionary<String, Any> {
            var fldcolorid = ""
            if let fld_color_id = dictData["fld_color_id"] as? String {
               fldcolorid = "\(fld_color_id)"
            }
            if let fld_color_id = dictData["fld_color_id"] as? Int {
               fldcolorid = "\(fld_color_id)"
            }
            self.srtfldcolorid = fldcolorid
            if let fld_color_id = self.dictData["fld_product_id"] as? String {
               self.strfldproductid = "\(fld_color_id)"
            }
            if let fld_color_id = self.dictData["fld_product_id"] as? Int {
               self.strfldproductid = "\(fld_color_id)"
            }
            self.apiGetDependendSize(color_id: fldcolorid, fld_product_id: self.strfldproductid)
        }
     
      
    }
      
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view!.endEditing(true)
      }

//    func textField(_ textField:UITextField,shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
//           if textField.isEditing==true {
//              let substring=(textField.text! as NSString).replacingCharacters(in: range, with: string)
//              print("substring: ", substring)
//              couponText = "\(substring)"
//           }
//           return true
//     }
//
//     func textFieldDidBeginEditing(_ textField: UITextField) {
//
//     }
//
//     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//           textField.resignFirstResponder()
//           return true;
//     }

    
    @objc func addProductButton(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.tableViewList)
        let indexPath: IndexPath? = self.tableViewList.indexPathForRow(at: buttonPosition)
        let cell = self.tableViewList.dequeueReusableCell(withIdentifier: "NumberOfSizesCell", for: indexPath ?? IndexPath()) as? NumberOfSizesCell
        cell?.qtyTextField.delegate = self;
        print("cell?.qtyTextField.text:", cell?.qtyTextField.text ??  "")
        if cell?.qtyTextField.text == "" {
            
        }
        var product_id = ""
        var srtfldfldsizeid = ""
        var srtfldproductqty = ""
        let index = sender.tag
//      let indexSelected = NSNumber(value: index)
        if let dict = self.arraySizes[index] as? NSDictionary {
            if let fld_color_id = dict["fld_size_id"] as? String {
               srtfldfldsizeid = "\(fld_color_id)"
            }
            if let fld_color_id = dict["fld_size_id"] as? Int {
               srtfldfldsizeid = "\(fld_color_id)"
            }
//            if let fld_size_moq = dict["fld_size_moq"] as? String {
//               srtfldproductqty = "\(fld_size_moq)"
//            }
//            if let fld_size_moq = dict["fld_size_moq"] as? Int {
//               srtfldproductqty = "\(fld_size_moq)"
//            }
        }
        DispatchQueue.main.async {
            if self.dictData.count > 0 {
              if let fld_product_id = self.dictData.value(forKey: "fld_product_id") as? Int {
                                   product_id = "\(fld_product_id)"
              }
            }
            self.cart_add_update(fldproductid: product_id, fldsizeid: srtfldfldsizeid, fldcolorid: self.srtfldcolorid, fldproductqty: self.couponText)
        }

//        let alertController = UIAlertController(title: "", message: "Are you sure you want to add this product in cart?", preferredStyle:.alert)
//              alertController.addAction(UIAlertAction(title:"NO",style:UIAlertAction.Style.default, handler:{(action: UIAlertAction) in
//                          }));
//              alertController.addAction(UIAlertAction(title:"YES", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
//
//              }));
//              self.present(alertController, animated: true, completion: nil)
      
    }
    
    func cart_add_update(fldproductid:String, fldsizeid: String, fldcolorid:String, fldproductqty: String)  {
        let dict =  [
            "fld_product_id":fldproductid,
            "fld_size_id": fldsizeid,
            "fld_color_id": fldcolorid,
            "fld_product_qty":fldproductqty
         ]
            let json = [
                    "fld_user_id":getUserID(),
                    "fld_action_type":0,
                    "data":[dict]] as [String : Any]
            print("Detail json: ", json)
//            DIProgressHud.show()
            postMyOrderAPIAction(WebService.cart_add_update, parameters: json, showGenricErrorPopup: false) { (response) in
                          print("response detail:", response ?? "")
                          DispatchQueue.main.async {
                             DIProgressHud.hide()
                          }
                          if let status = response?.object(forKey: "status") as? Bool, status == true {
                             DispatchQueue.main.async {
                               if let message = response?["message"] as? String {
                                  let alertController = UIAlertController(title: "", message: message, preferredStyle:.alert)
                                  alertController.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: {(action: UIAlertAction) in
                                    self.apiDetail()
                                  }));
                                  self.present(alertController, animated: true, completion: nil)
                               }
                           }
                        } else {
                            
                      }
             }
    }
    

    func productDetailes(productId:String,userIdString:String,colourId:String,sizeId:String) {
        ApiClient.loder(roughter: APIRouter.productdetailes(productID: productId, userId: userIdString, colourId: colourId, sizeId: sizeId)) { (productDetaies: ProductDetailesResponceData) in
            print("\(productDetaies)")
            if productDetaies.statusCode == 201{
                self.thumbeNell.append(contentsOf: productDetaies.productDetailData?.thumbnail ?? [])
            } else {
                Utility.showAlert(withMessage: productDetaies.message ?? "", onController: self)
            }
        }
    }
    
    func apiGetDependendSize(color_id: String, fld_product_id: String) {
                let json = [
                    "fld_product_id": fld_product_id,
                    "fld_user_id":getUserID(),
                    "fld_color_id":color_id,
                    "fld_size_id":""
                            ] as [String : Any]
                print("Detail json: ", json)
//              DIProgressHud.show()
                postMyOrderAPIAction(WebService.get_dependend_size, parameters: json, showGenricErrorPopup: false) { (response) in
                print("response detail:", response ?? "")
                DispatchQueue.main.async {
//                DIProgressHud.hide()
                }
                self.arraySizes.removeAllObjects()
                if let status = response?.object(forKey: "status") as? Bool, status == true {
                   DispatchQueue.main.async {
                     if let dataArray = response?["sizes_data"] as? NSArray, dataArray.count > 0 {
                        self.arraySizes = dataArray as! NSMutableArray
                     }
                         DispatchQueue.main.async {
                             self.tableViewList.reloadData()
                         }
                     }
                 }
            }
    }
    
    
    func apiDetail() {
        let json = [
                   "fld_product_id": str_fld_product_id,
                   "fld_user_id" : getUserID(),
                   "fld_color_id": "",
                   "fld_size_id" : "" ] as [String : Any]
        print("Detail json: ", json)
//        DIProgressHud.show()
        postMyOrderAPIAction(WebService.productdetail, parameters: json, showGenricErrorPopup: false) { (response) in
        print("response productdetail:", response ?? "")
                   DispatchQueue.main.async {
//                     DIProgressHud.hide()
                   }
                   if let status = response?.object(forKey: "status") as? Bool, status == true {
                      DispatchQueue.main.async {
                        if let dictData = response?["product_detail_data"] as? NSDictionary, dictData.count > 0 {
                            self.dictData = dictData
                            self.callUISetUpWishList()
                            self.arrayColor.removeAllObjects()
                            self.arrayBannerImage.removeAllObjects()
                            if let dataArray = dictData.object(forKey: "thumbnail") as? NSArray, dataArray.count > 0 {
                               self.arrayBannerImage = dataArray as! NSMutableArray
                            }
                            if let dict = dictData.value(forKey:"attributes") as? NSDictionary, dict.count > 0 {
                               if let dataArray = dict.object(forKey: "colors") as? NSArray, dataArray.count > 0 {
                                  self.arrayColor = dataArray as! NSMutableArray
                               }
//                               if let dataArray = dict.object(forKey: "sizes") as? NSArray, dataArray.count > 0 {
//                                  self.arraySizes = dataArray as! NSMutableArray
//                               }
                             }
                            if self.arrayBannerImage.count > 0 {
                               self.callUISetUp()
                            }
                        }
                        if let iscart = self.dictData.value(forKey: "isInCart") as? Int, iscart == 1 {
                           self.btnAddToCart.isHidden = false
                           self.viewBottomBg.isHidden = false
                           self.bottomviewBG();
                        } else {
                            self.btnAddToCart.isHidden = true
                            self.viewBottomBg.isHidden = true
                            self.bottomviewBG();
                        }
                        DispatchQueue.main.async {
                            self.tableViewList.reloadData()
                        }
                    }
                   } else {
                   }
            }
    }
    
    
    func callAddToCartApi()  {
        var product_id = ""
        if self.dictData.count > 0 {
            if let fld_product_id = self.dictData.value(forKey: "fld_product_id") as? Int {
               product_id = "\(fld_product_id)"
            }
        }
        let json = [
            "fld_user_id":getUserID(),
            "fld_action_type":2,
            "fld_product_id":product_id,
            "fld_size_id":0,
            "fld_color_id":0,
            "fld_product_qty":4
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
                                self.btnAddToCart.setTitle(" Go TO CART ", for: .normal)
                            });
                     }
                 }
               } else {
             }
        }
    }
}
