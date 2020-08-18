//
//  WishlistVC.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 14/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class WishlistVC: UIViewController {
@IBOutlet weak var wishListCollecationView: UICollectionView!
    
    
    var wishListData:[WishlistDatum] = []
    var WishListViewModel = WishListModelView()


    override func viewDidLoad() {
        super.viewDidLoad()
        WishListViewModel.controler = self

        
        wishListCollecationView.register(UINib(nibName: "WishlistCell", bundle: nil), forCellWithReuseIdentifier: "WishlistCell")
        
       


        wishList(userId: "1")
//        wishListCollecationView.dataSource = self
//        wishListCollecationView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func wishList(userId:String){
        
        ApiClient.loder(roughter: APIRouter.wishList(fldUserId: userId)) { (wishListResponce:WishListResponce) in
            
            
            if wishListResponce.status == true {
                
                self.WishListViewModel.wishList = wishListResponce.wishlistData ?? []
                self.wishListCollecationView.delegate = self.WishListViewModel
                self.wishListCollecationView.dataSource = self.WishListViewModel
                self.wishListCollecationView.reloadData()
            }else {
                Utility.showAlert(withMessage: wishListResponce.message ?? "", onController: self)

            }
            
            
        }
    }
    
    
}
