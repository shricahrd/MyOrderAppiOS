//  HomeController.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 06/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit
import  SideMenu
import SDWebImage
class HomeController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout { //

    var menu : SideMenuNavigationController?
    
    
@IBOutlet weak var sliderCollectionView: UICollectionView!
 @IBOutlet weak var homeViewTableview: UITableView!
    
    var categories = ["Fatured CateGories", "Most Popular Items","Most Popular Items"]

    var hoteDealesArraya:[HotDealsDatum] = []
    
   var bannerAddData = ["Product","Product","Product","Product"]
    
    var timer = Timer()
    
    var counter = 0
    
    @IBOutlet weak var pageView: UIPageControl!



    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        
        
        homeViewTableview.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        
        sliderCollectionView.register(UINib(nibName: "BannerAdsCell", bundle: nil), forCellWithReuseIdentifier: "BannerAdsCell")
        
        homeViewTableview.register(UINib.init(nibName: "HomeHedderCell", bundle: nil), forCellReuseIdentifier: "HomeHedderCell")
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        // hotDealesCollecationView.register(UINib(nibName: "HotdealscollecationViewCell", bundle: nil), forCellWithReuseIdentifier: "HotdealscollecationViewCell")
        
        homeViewTableview.delegate = self
        homeViewTableview.dataSource = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
      //  addNavBarImage()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        
        
        //        hotDealesCollecationView.delegate = self
        //        hotDealesCollecationView.dataSource = self
    }
    
    
    @objc func changeImage() {
          
          if counter < bannerAddData.count {
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
          } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
              pageView.currentPage = counter
              counter = 1
          }
          
      }
    
    
    
    func addNavBarImage() {
        let navController = navigationController!
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .yellow
        navigationItem.titleView = imageView
    }
    
    @IBAction func didTapMenu(){
          present(menu!,animated: true)
      }

}

// MARK:- HartSaleApi
extension HomeController{
    
    func hartDeales(productType:String,pageNumber:String) {
        
        
    }
    
    
}



// MARK:- COLLECATION VIEW DELAGATE
//extension HomeController {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//          // return catagaryaArrayaData.count
//
//           return hoteDealesArraya.count
//       }
//
//
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotdealscollecationViewCell", for: indexPath) as! HotdealscollecationViewCell
//        let productListArraya = hoteDealesArraya[indexPath.row]
//        cell.provogesLabel.text = productListArraya.fldBrandName
//        cell.productImage.sd_setImage(with: URL(string:"\(productListArraya.defaultImage ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))
//        // "https://nodeserver.brainiuminfotech.com:2000/img/products/",
//        // cell.productImageView.image = catagaryaArrayaData[indexPath.row].1
//        return cell
//
//
//    }
//
//
//}

extension HomeController:UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return 2 //categories.count
       }
       
       
//       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//           return categories[section]
//       }
       
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return 2
        
        return categories.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
            cell.controller = self
            // cell.productList = mostPopularItems
            
            return cell
            
        }else if indexPath.row == 1{
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HomeHedderCell") as! HomeHedderCell

                headerCell.haderLabel.text = "New Collection"
            
            headerCell.viewMoreButton.addTarget(self, action: #selector(delateAdress(_:)), for: .touchUpInside)

//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewCollecationTableviewCell") as! NewCollecationTableviewCell
//
//            // mostPopularItems
            return headerCell
        }else {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
            
            return cell
            
        }
        
    }
    
    
    @objc func delateAdress(_ sender:UIButton){
        
        
        
        
      //  SearchProductController
        
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "SearchProductController") as? SearchProductController { // SearchByBrandController
            
            self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
        }
        
        
    }
       
    
    @objc func wishList(_ sender:UIButton){
           
           let storyboard = UIStoryboard(name:"Home", bundle: Bundle.main)
           if let attachedPrescriptionListController = storyboard.instantiateViewController(withIdentifier: "WishlistVC") as? WishlistVC {
               
               self.navigationController?.pushViewController(attachedPrescriptionListController, animated: true)
           }
           
           
       }
          
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           if section == 0 {
               let headerCell = tableView.dequeueReusableCell(withIdentifier: "HomeHedderCell") as! HomeHedderCell

               headerCell.haderLabel.text = "Hot Deals"
            
              headerCell.viewMoreButton.addTarget(self, action: #selector(wishList(_:)), for: .touchUpInside)
            return headerCell

           }else if section == 1 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HomeHedderCell") as! HomeHedderCell

               headerCell.haderLabel.text = "Hot Deals"
            return headerCell

           }else {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HomeHedderCell") as! HomeHedderCell

               headerCell.haderLabel.text = "s"
            return headerCell
               
           }
           
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        }else if indexPath.row == 1{
            return 50
            
        }else {
            return 250

            
        }
    }
    
}

extension HomeController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerAddData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerAdsCell", for: indexPath) as! BannerAdsCell
        let imageData = bannerAddData[indexPath.row]
        
        cell.bannerAdsImageView.image = UIImage(named:imageData)

        
        // cell.bannerAdsImageView.sd_setImage(with: URL(string: "https://nodeserver.brainiuminfotech.com:2000/img/vendor/\(imageData.image)"), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        return cell
        
    }
    
}
