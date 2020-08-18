//
//  HomeCell.swift
//  Trolleey
//
//  Created by Ivica Technologies on 21/05/20.
//  Copyright © 2020 Brainiuminfotech. All rights reserved.
//

import UIKit
var sectionVal = Int()

class HomeCell: UITableViewCell, UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {  //,
    @IBOutlet weak var featuredCategaryCollecationView: UICollectionView!
    
   // var catagaryaArrayaData = ["Fuathers & Vigatables","Beverages","Dairy"]
    
    let catagaryaArrayaData : [(String,UIImage)] = [("Fuathers & Vigatables",#imageLiteral(resourceName: "logo")),("Beverages",#imageLiteral(resourceName: "cart")),("Dairy Post",#imageLiteral(resourceName: "home")),("Dairy Post",#imageLiteral(resourceName: "home")),("Dairy Post",#imageLiteral(resourceName: "home")),("Dairy Post",#imageLiteral(resourceName: "home"))]
    let heder = "CollectionViewHedder"

    
//    var mostPopularItems:[mostPopularItems]()
    
    
   // var productList = [ProductList]()
   // var productList :[ProductList]?
  //  var productList = [CategoryDatum]()
    
    var hoteDealesArraya:[HotDealsDatum] = []

    
    
    

    
    var controller=UIViewController()
 var section = Int()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        hartDeales(productType: "hot_deals", pagnumber: 0)
        
                  
//        userDashboardApi(customerId: customerId, latitude: "22.599331", longitude: "88.444899")
//
//        // Initialization code
//        featuredCategaryCollecationView.register(UINib(nibName: "CollectionViewHedder", bundle: nil), forCellWithReuseIdentifier: "CollectionViewHedder")
        featuredCategaryCollecationView.register(UINib(nibName: "HotdealscollecationViewCell", bundle: nil), forCellWithReuseIdentifier: "HotdealscollecationViewCell")
        
        let headerNib = UINib.init(nibName: "CollectionViewHedder", bundle: nil)
               featuredCategaryCollecationView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHedder")
        
        
          let footerNib = UINib.init(nibName: "CollectionViewHedder", bundle: nil)
              featuredCategaryCollecationView.register(footerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionViewHedder")
//
//        featuredCategaryCollecationView.reloadData()
        featuredCategaryCollecationView.dataSource = self
        featuredCategaryCollecationView.delegate = self
        
    }
    
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 45)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 0)
//    }

    
    
    
    
    
    func hartDeales(productType:String,pagnumber:Int){

        ApiClient.loder(roughter: APIRouter.hotDeals(productType: productType, pageNumber: pagnumber)) { (hartDeales:HartDeailesResponce) in
            
            
            if hartDeales.status == true {
                
                self.hoteDealesArraya.append(contentsOf: hartDeales.hotDealsData ?? [])
                
                self.featuredCategaryCollecationView.reloadData()

            }else {
                
                
            }
            
            
        }
    }
    
    
    
    
    
    func loadData(_ section:Int){
           debugPrint("Index: ",section)
           if sectionVal == 0{
               self.section = section
               featuredCategaryCollecationView.reloadData()
           }
       }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              // return catagaryaArrayaData.count
    
               return hoteDealesArraya.count
           }
    
    
    
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotdealscollecationViewCell", for: indexPath) as! HotdealscollecationViewCell
            let productListArraya = hoteDealesArraya[indexPath.row]
            cell.provogesLabel.text = productListArraya.fldBrandName
           // cell.productImage.sd_setImage(with: URL(string:"\(productListArraya.defaultImage ?? "")"), placeholderImage: UIImage(named: "placeholder.png"))
            // "https://nodeserver.brainiuminfotech.com:2000/img/products/",
            // cell.productImageView.image = catagaryaArrayaData[indexPath.row].1
            return cell
    
    
        }
    
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       // return catagaryaArrayaData.count
//
//        return productList.count
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCategoriesCell", for: indexPath) as! FeaturedCategoriesCell
//
//        let productListArraya = productList[indexPath.row]
//
//        cell.productName.text = productListArraya.categoryName
//
//
//         cell.productImageView.sd_setImage(with: URL(string: "https://nodeserver.brainiuminfotech.com:2000/img/products/\(productListArraya.image)"), placeholderImage: UIImage(named: "placeholder.png"))
//
//
//       // "https://nodeserver.brainiuminfotech.com:2000/img/products/",
//       // cell.productImageView.image = catagaryaArrayaData[indexPath.row].1
//        return cell
//    }
    
    
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // Give cell width and height
        return CGSize(width: 150, height: 230)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        // splace between two cell horizonatally
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        // splace between two cell vertically
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        // give space top left bottom and right for cells
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if(section==0) {
//            return CGSize.zero
//        } else if (section==1) {
//            return CGSize(width:collectionView.frame.size.width, height:133)
//        } else {
//            return CGSize(width:collectionView.frame.size.width, height:200)
//        }
//
//    }
     
    
    
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        var reusableview = UICollectionReusableView()
//        if (kind == UICollectionView.elementKindSectionHeader) {
//            let section = indexPath.section
//            switch (section) {
//            case 1:
//                let  firstheader: CollectionViewHedder = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OfferHeaderCell", for: indexPath) as! CollectionViewHedder
//                reusableview = firstheader
//            case 2:
//                let  secondHeader: CollectionViewHedder = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OfferHeaderCell", for: indexPath) as! CollectionViewHedder
//                reusableview = secondHeader
//            default:
//                return reusableview
//
//            }
//        }
//        return reusableview
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//           switch kind {
//           case UICollectionView.elementKindSectionHeader:
//               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHedder", for: indexPath) as! CollectionViewHedder
//               return headerView
//           case UICollectionView.elementKindSectionFooter:
//               let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHedder", for: indexPath) as! CollectionViewHedder
//               return footerView
//           default:
//               return UICollectionReusableView()
//           }
//       }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//           return CGSize(width: collectionView.frame.width, height: 45)
//       }
//
//       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//           return CGSize(width: collectionView.frame.width, height: 45)
//       }


    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
