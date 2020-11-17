//
//  FavoriteModel.swift
//  MyOrder
//
//  Created by gwl on 12/10/20.
//

import UIKit

class FavoriteModel: NSObject {
    var aWishlistModels: [WishlistModel] = []
    override init(){
    }
    init(aWishlistModel: [WishlistModel]) {
        self.aWishlistModels = aWishlistModel
    }
}
class WishlistModel: NSObject {
    var fld_product_id: Int = 0
    var fld_product_name: String = ""
    var fld_color_id: Int = 0
    var fld_size_id: Int = 0
    var fld_product_price: Int = 0
    var fld_spcl_price: Int = 0
    var default_image: String = ""
    var fld_rating_count: Int = 0
    var fld_review_count: Int = 0
    var price: Int = 0
    var spcl_price: Int = 0
    var fld_total_rating: Int = 0
//    "color_list": [],
//    "size_list": [],
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_product_id = dictionary["fld_product_id"] as? Int {
            self.fld_product_id = fld_product_id
        }
        if let fld_product_name = dictionary["fld_product_name"] as? String {
            self.fld_product_name = fld_product_name
        }
        if let fld_color_id = dictionary["fld_color_id"] as? Int {
            self.fld_color_id = fld_color_id
        }
        if let fld_size_id = dictionary["fld_size_id"] as? Int {
            self.fld_size_id = fld_size_id
        }
        if let fld_product_price = dictionary["fld_product_price"] as? Int {
            self.fld_product_price = fld_product_price
        }
        if let fld_spcl_price = dictionary["fld_spcl_price"] as? Int {
            self.fld_spcl_price = fld_spcl_price
        }
        if let default_image = dictionary["default_image"] as? String {
            self.default_image = default_image
        }
        if let fld_rating_count = dictionary["fld_rating_count"] as? Int {
            self.fld_rating_count = fld_rating_count
        }
        if let fld_review_count = dictionary["fld_review_count"] as? Int {
            self.fld_review_count = fld_review_count
        }
        if let price = dictionary["price"] as? Int {
            self.price = price
        }
        if let spcl_price = dictionary["spcl_price"] as? Int {
            self.spcl_price = spcl_price
        }
        if let fld_total_rating = dictionary["fld_total_rating"] as? Int {
            self.fld_total_rating = fld_total_rating
        }
    }
}
