//  ProductDetailController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 18/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class ProductDetailController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        self.uiSetUpScrollView()
    }

    
     func uiSetUpScrollView() {
        scrollViewMain.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        scrollViewMain.bounces = true
        scrollViewMain.delegate = self
        scrollViewMain.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        view.addSubview(scrollViewMain)
        
        scrollViewPager = UIScrollView(frame: CGRect(x:0, y:0, width:self.view.frame.width,height: 220))
        pageControl = UIPageControl(frame: CGRect(x:0,y: 220, width:self.view.frame.width, height:50))
        configurePageControl()
        scrollViewPager.delegate = self
        scrollViewPager.isPagingEnabled = true
        scrollViewPager .showsHorizontalScrollIndicator = false
        scrollViewMain.addSubview(scrollViewPager)

        for index in 0..<colors.count {
            self.pageControl.numberOfPages = colors.count
            self.pageControl.currentPage = 0
            self.imgViewSplash = UIImageView()
            self.imgViewSplash.frame = CGRect(x: self.view.frame.size.width * CGFloat(index), y: 0, width: self.view.frame.size.width,height: 220)
            self.imgViewSplash.backgroundColor = .white //colors[index]
//          if let image = self.arrayData[index] as? String, let imageURL = URL(string: image) {
//             self.imgViewSplash.setImageWith(imageURL, placeholderImage: nil)
//          }
            self.imgViewSplash.isUserInteractionEnabled = true
            self.imgViewSplash.contentMode = .center
            self.imgViewSplash.clipsToBounds = true
            self.scrollViewPager.addSubview(self.imgViewSplash)
            
            let likeButton = UIButton()
            likeButton.frame = CGRect(x: self.imgViewSplash.frame.width-80, y: 18, width: 50, height: 50)
            likeButton.setImage(UIImage(named: "heartIcon"), for: .normal)
            likeButton.layer.shadowRadius = 18.0
            likeButton.clipsToBounds = true
            likeButton.backgroundColor = .white
            likeButton.layer.shadowColor = UIColor.black.cgColor
            likeButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            likeButton.layer.masksToBounds = false
            likeButton.layer.shadowRadius = 2.0
            likeButton.layer.shadowOpacity = 0.5
            likeButton.layer.cornerRadius = likeButton.frame.width / 2
//          likeButton.layer.borderColor = UIColor.black.cgColor
//          likeButton.layer.borderWidth = 2.0
            self.imgViewSplash.addSubview(likeButton)
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
         scrollViewMain.contentSize = CGSize(width: 0, height: viewBg.frame.maxY + 300)
           
        self.registerNib()
    }
    
    func registerNib() {
      self.callTableView()
      self.tableViewList.register(UINib(nibName: "ProductDetailCell", bundle: nil), forCellReuseIdentifier: "ProductDetailCell")
      
      self.tableViewList.register(UINib(nibName: "productColorCell", bundle: nil), forCellReuseIdentifier: "productColorCell")
      self.tableViewList.register(UINib(nibName: "productSizesHeader", bundle: nil), forCellReuseIdentifier: "productSizesHeader")
      let nib = UINib(nibName: "productSizesHeader", bundle: nil)
              
      self.tableViewList.register(nib, forHeaderFooterViewReuseIdentifier: "productSizesHeader")
      self.tableViewList.register(UINib(nibName: "NumberOfSizesCell", bundle: nil), forCellReuseIdentifier: "NumberOfSizesCell")
      tableViewList.register(UINib(nibName: "SupplierNameCell", bundle: nil), forCellReuseIdentifier: "SupplierNameCell")
      tableViewList.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        
      tableViewList.register(UINib(nibName: "ReminderCell", bundle: nil), forCellReuseIdentifier: "ReminderCell")
      tableViewList.delegate = self
      tableViewList.dataSource = self
      tableViewList.separatorStyle = .none
    }
    
    func callTableView() {
        self.tableViewList=UITableView()
        self.tableViewList.frame = CGRect(x: 0, y: self.scrollViewPager.frame.maxY , width: self.scrollViewPager.frame.width, height: scrollViewMain.frame.size.height - (self.scrollViewPager.frame.maxY))
        self.tableViewList.backgroundColor = UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
        self.scrollViewMain.addSubview(tableViewList)
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
         let x = CGFloat(pageControl.currentPage) * self.scrollViewMain.frame.size.width
         self.scrollViewMain.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
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
                    cell.productcolor.text = "Short black dress"
                    cell.productName.text = "Louis Prada"
                    cell.quantity.text = "*Min Order Quantity: 25"
                    cell.price.text = "\u{20B9}850"
                    cell.discountPrice.text = "\u{20B9}1150"
          
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "  \(String(describing: cell.discountPrice.text!))  " )
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 3, range: NSMakeRange(0, attributeString.length))
                    cell.discountPrice.attributedText = attributeString
                    return cell
                }
            } else if indexPath.section == TableSection.color {
               let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderCell
               cell.selectionStyle = .none
               cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
               cell.viewBg.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
               cell.viewBg.layer.masksToBounds = false
               cell.viewBg.layer.shadowRadius = 2.0
               cell.viewBg.layer.shadowColor = UIColor.black.cgColor
               cell.viewBg.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
               cell.viewBg.layer.shadowOpacity = 0.7
               collectionWidth = cell.viewBg.frame.size.width
               collectionHeight = cell.viewBg.frame.size.height
               
               let layout = UICollectionViewFlowLayout()
               cell.collectionView.register(UINib(nibName: "ReminderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ReminderCollectionCell")
               cell.collectionView.reloadData()
               if layout != nil {
                   cell.collectionView.collectionViewLayout = layout
                   layout.scrollDirection = .horizontal
               }
               cell.collectionView.dataSource = self
               cell.collectionView.delegate = self
               layout.minimumLineSpacing = 5
               cell.collectionView.backgroundColor = .white
               cell.collectionView.showsVerticalScrollIndicator = false
               cell.collectionView.keyboardDismissMode = .interactive
               return cell
                
            } else if indexPath.section == TableSection.sizes {
              if let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfSizesCell", for: indexPath) as? NumberOfSizesCell {
                 cell.selectionStyle = .none
                 cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                cell.productSize.text = "XS"
                cell.productPrice.text = "750"
                cell.productQuantity.text = "25"
                cell.productQuantity.layer.borderWidth = 1
                cell.productQuantity.layer.borderColor = UIColor.lightGray.cgColor
                cell.productQuantity.layer.cornerRadius = 4
                cell.removeButton.addTarget(self, action: #selector(self.removeButton), for: UIControl.Event.touchUpInside)
                cell.removeButton.setImage(UIImage(named: "plusIcon"), for: .normal)
                cell.removeButton.tag = indexPath.row
                
                return cell
               }
             } else if indexPath.section == TableSection.quantity {
             if let cell = tableView.dequeueReusableCell(withIdentifier: "SupplierNameCell", for: indexPath) as? SupplierNameCell {
                cell.selectionStyle = .none

                cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                
                cell.supplierName.text = "Fashionista"
                cell.name.text = "Supplier Name"
              
                return cell
               }
             } else if indexPath.section == TableSection.totalquantity {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionCell {
                     cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor(red:250.0 / 255.0, green:250.0 / 255.0, blue:250.0 / 255.0, alpha: 1.0)
                cell.viewBg.backgroundColor = UIColor(red:255.0 / 255.0, green:255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
                cell.descriptionText.text = "Afhajfhj aherqjwr hea rw how r you doing. I am doing fabulous adhajdf ajweqbwer ajheqn hye n ehge  e jq    en  benbenq beq  qjwehqjwbe4irt2or wjrwjrsnjrutn 23ur23r wjurwr wejrkAfhajfhj aherqjwr hea rw how r you doing. I am doing fabulous adhajdf ajweqbwer ajheqn hye n ehge  e jq    en  benbenq beq  qjwehqjwbe4irt2or wjrwjrsnjrutn 23ur23r wjurwr wejrkw"
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
    
    // MARK:- Collection View Metods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return colors.count
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
        cell.viewBg.layer.cornerRadius =  cell.viewBg.frame.size.width/2
        cell.viewBg.clipsToBounds = true
        cell.viewBg.layer.borderColor = UIColor(red: 4.0/255.0, green: 202.0/255.0, blue: 169.0/255.0, alpha: 1.0).cgColor
        cell.viewBg.backgroundColor = colors[indexPath.row]
        //cell.timeText.font = UIFont(name: "Verdana", size: 15)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 60, height: 60)
        //return CGSize(width: collectionWidth/3.2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
    
    
       @objc func removeButton(_ sender: UIButton) {
       
       }
    
}
