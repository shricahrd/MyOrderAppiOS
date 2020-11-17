//
//  ProductListModel.swift
//  MyOrder
//
//  Created by gwl on 11/10/20.
//

import UIKit

class ProductListModel: NSObject {
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    var cart_total_count: Int = 0
    var grid_list_view: Int = 0
    var products: [Product] = []
    override init(){
    }
    init(aProducts : [Product],
         afld_total_page: Int,
         anextPage: Int,
         acartTotalCount: Int,
         aGridListView: Int) {
        self.products = aProducts
        self.fld_total_page = afld_total_page
        self.nextPage = anextPage
        self.cart_total_count = acartTotalCount
        self.grid_list_view = aGridListView
    }
}

class Product: NSObject {
    var id: Int = 1
    var cat_id: Int = 2
    var color_id: Int = 0
    var size_id: Int = 0
    var extra_price: Int = 0
    var name: String = ""
    var fld_brand_name: String = ""
    var prd_discount: String = ""
    var price: Int = 1000
    var spcl_price: Int = 900
    var default_image: String = ""
    var fld_total_rating: Int = 0
    var fld_rating_count: Int = 0
    var fld_review_count: Int = 0
    var isInWishlist: Bool = false
    var fld_manufacture_id: Int = 0

    
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let fld_manufacture_id = dictionary["fld_manufacture_id"] as? Int {
            self.fld_manufacture_id = fld_manufacture_id
        }
        if let cat_id = dictionary["cat_id"] as? Int {
            self.cat_id = cat_id
        }
        if let color_id = dictionary["color_id"] as? Int {
            self.color_id = color_id
        }
        if let size_id = dictionary["size_id"] as? Int {
            self.size_id = size_id
        }
        if let extra_price = dictionary["extra_price"] as? Int {
            self.extra_price = extra_price
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        if let fld_brand_name = dictionary["fld_brand_name"] as? String {
            self.fld_brand_name = fld_brand_name
        }
        if let prd_discount = dictionary["prd_discount"] as? String {
            self.prd_discount = prd_discount
        }
        if let price = dictionary["price"] as? Int {
            self.price = price
        }
        if let spcl_price = dictionary["spcl_price"] as? Int {
            self.spcl_price = spcl_price
        }
        if let default_image = dictionary["default_image"] as? String {
            self.default_image = default_image
        }
        if let fld_total_rating = dictionary["fld_total_rating"] as? Int {
            self.fld_total_rating = fld_total_rating
        }
        if let fld_rating_count = dictionary["fld_rating_count"] as? Int {
            self.fld_rating_count = fld_rating_count
        }
        if let fld_review_count = dictionary["fld_review_count"] as? Int {
            self.fld_review_count = fld_review_count
        }
        if let isInWishlist = dictionary["isInWishlist"] as? Bool {
            self.isInWishlist = isInWishlist
        }
    }
}

