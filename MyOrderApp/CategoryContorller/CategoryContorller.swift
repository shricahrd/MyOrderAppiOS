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
    
   // var rangeSlider1 = RangeSlider(frame: CGRect.zero)
 //   let rangeSlider2 = RangeSlider(frame: CGRect.zero)
    var leftRange = UILabel()
    var rightRange = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        arrayCategory = ["All", "Women", "Men","Boys","Girls"]
        arraySize = ["XS", "S", "M","L","XL","XXL"]
        
        
        self.view.backgroundColor = UIColor(red:215.0 / 255.0, green:215.0 / 255.0, blue:215.0 / 255.0, alpha: 1.0)
        self.uiSetUpScrollView()
    }
    
    func uiSetUpScrollView() {
         scrollViewMain.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
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
        
      //  rangeSlider1 = RangeSlider(frame: CGRect(x: 26, y: leftRange.frame.maxY+2, width: screenWidth/2-32, height: 30))
      //  viewRangeBg.addSubview(rangeSlider1)
        
//        rangeSlider1.addTarget(self, action: #selector(self.rangeSliderValueChanged(_:)),
//                                  for: .valueChanged)
        self.callcollectionCategory()
        self.callcollectionColor()
        self.callcollectionSize()
        self.bottomviewBG()
        self.scrollViewMain.contentSize = CGSize(width: 0, height: viewRangeBg.frame.maxY+300)
    }
    
//    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
//        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
//        print(Int(rangeSlider.lowerValue))
//        print(Int(rangeSlider.upperValue))
//        self.leftRange.text = "\u{20B9} \(Int(rangeSlider.lowerValue))"
//        self.rightRange.text = "\u{20B9} \(Int(rangeSlider.upperValue))"
//    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
      //  rangeSlider1.frame = CGRect(x: margin,y:margin+topLayoutGuide.length+30,
           //   width: width, height: 31.0)
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
          
    }
    
    @objc func clickOnClearAll(_ sender: AnyObject!) {
        
    }
    
    
    // MARK:- Collection View Metods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategory {
           return arrayCategory.count
        } else if collectionView == collectionViewColor {
           return colors.count
        } else if collectionView == collectionViewSize {
           return arraySize.count
        }
        return 0
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
        if collectionView == collectionViewCategory {
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
            viewBG.backgroundColor = .blue
            
            let title: UILabel! = UILabel()
            title.frame = CGRect(x: 0, y: 0, width: viewBG.frame.size.width, height: viewBG.frame.size.height)
            title.text = self.arrayCategory[indexPath.row]
            title.numberOfLines = 1
            title.backgroundColor = .clear
            title.textAlignment = .center
            title.textColor = .white
            title.font = UIFont.boldSystemFont(ofSize: 14)
            viewBG.addSubview(title)
            return cell!
        } else if collectionView == collectionViewColor {
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
            cell?.contentView.addSubview(viewBG)
            viewBG.backgroundColor = .white
            
            let img = UIImageView()
            img.frame = CGRect(x: 8, y: 8, width: (cell?.frame.size.width)!-16, height: (cell?.frame.size.height)!-16)
            img.layer.cornerRadius = ((cell?.frame.size.width)!-16)/2
            img.clipsToBounds = true
            img.backgroundColor = colors[indexPath.row]
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
            title.text = self.arraySize[indexPath.row]
            title.numberOfLines = 1
            title.backgroundColor = .clear
            title.textAlignment = .center
            title.textColor = .darkGray
            title.font = UIFont.boldSystemFont(ofSize: 14)
            viewBG.addSubview(title)
            
            return cell!
        }
        return UICollectionViewCell()
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewCategory {
          return CGSize(width: 100, height: 45)
        } else if collectionView == collectionViewColor {
          return CGSize(width: 55, height: 55)
        } else if collectionView == collectionViewSize {
          return CGSize(width: 60, height: 55)
        }
          return CGSize(width: 0, height: 0)
    }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       }
       
       func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       }
    
    
    @IBAction func applyAction(_ sender: Any) {
        
    }
    
    @IBAction func clearAllAction(_ sender: Any) {
        
    }
}

