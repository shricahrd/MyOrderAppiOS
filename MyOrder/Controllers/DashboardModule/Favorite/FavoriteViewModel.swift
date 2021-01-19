//
//  FavoriteViewModel.swift
//  MyOrder
//
//  Created by sourabh on 12/10/20.
//

import UIKit
typealias FavoriteModelSuccess = (_ model: FavoriteModel) -> Void

class FavoriteViewModel: NSObject {
    func getWishList(aFavoriteModelSuccess:@escaping  FavoriteModelSuccess,
                     aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kWishlist, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["wishlist_data"] as? [[String: Any]] ?? []
                var aWishlistModel: [WishlistModel] = []
                for objectWishlists in object {
                    aWishlistModel.append(WishlistModel(fromDictionary: objectWishlists))
                }
                aFavoriteModelSuccess(FavoriteModel(aWishlistModel: aWishlistModel))
            }else {
                aFailed(error)
            }
        }
    }
}
