//
//  WishListModelView.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 15/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage


class WishListModelView: NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var wishList = [WishlistDatum]()
    var controler = UIViewController()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return wishList.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishlistCell", for: indexPath) as! WishlistCell
        
        let wishListArraya = wishList[indexPath.row]
        
        
        
        cell.productNameLabel.text = wishListArraya.fldProductName
        
        cell.priseLabel.text = "₹\(wishListArraya.fldProductPrice ?? 0)"
        cell.disCountLabel.text = "₹\(wishListArraya.fldSpclPrice ?? 0)"
        
        
      
        
        //  cell.productImageView.sd_setImage(with: URL(string: wishListArraya.defaultImage ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width/2 , height:320)
        
       // collectionView.frame.width/2
       }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           let padding: CGFloat =  50
//           let collectionViewSize = collectionView.frame.size.width - padding
//
//           return CGSize(width: collectionViewSize/2, height: 300)
//       }
    
    
    
    
    
       
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
       
       
    

}
