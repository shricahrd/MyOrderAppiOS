//
//  ProductDetailsModel.swift
//  MyOrder
//
//  Created by sourabh on 12/10/20.
//

import UIKit


class ProductDetailModel: NSObject {
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    var productDetail: ProductDetail = ProductDetail()
    override init(){
    }
    init(aProductDetail: ProductDetail, afld_total_page: Int, anextPage: Int) {
        self.productDetail = aProductDetail
        self.fld_total_page = afld_total_page
        self.nextPage = anextPage
    }
}
class ProductDetail: NSObject {
    var fld_product_id: Int = 0
    var fld_product_deleted: Int = 0
    var fld_product_price: Int = 0
    var fld_product_spcl_price: Int = 0
    var fld_product_moq: Int = 0
    var fld_total_rating: Int = 0
    var fld_rating_count: Int = 0
    var fld_review_count: Int = 0
    var fld_shipping_charges: Int = 0
    var cart_total_count: Int = 0
    var fld_manufacture_id: Int = 0
    var fld_product_url: String = ""
    var fld_product_name: String = ""
    var fld_brand_name: String = ""
    var fld_product_sku: String = ""
    var size_chart: String = ""
    var fld_product_short_description: String = ""
    var fld_product_long_description: String = ""
    var fld_product_qty: String = ""
    var fld_product_image: String = ""
    var fld_delivery_days: String = ""
    var isInWishlist: Bool = false
    var isInCart: Bool = false
    var alreadyInCart: Bool = false
    var fld_more_seller: Bool = false
    var attribute: Attributes = Attributes()
    var thumbnail: [Thumbnail] = []
    var fld_seller_info: SellerInfo = SellerInfo()
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aAttribute: Attributes, aThumbnail: [Thumbnail], aFldSellerInfo: SellerInfo) {
        if let fld_product_id = dictionary["fld_product_id"] as? Int {
            self.fld_product_id = fld_product_id
        }
        if let fld_product_deleted = dictionary["fld_product_deleted"] as? Int {
            self.fld_product_deleted = fld_product_deleted
        }
        if let fld_manufacture_id = dictionary["fld_manufacture_id"] as? Int {
            self.fld_manufacture_id = fld_manufacture_id
        }
        if let fld_product_price = dictionary["fld_product_price"] as? Int {
            self.fld_product_price = fld_product_price
        }
        if let fld_product_spcl_price = dictionary["fld_product_spcl_price"] as? Int {
            self.fld_product_spcl_price = fld_product_spcl_price
        }
        if let fld_product_moq = dictionary["fld_product_moq"] as? Int {
            self.fld_product_moq = fld_product_moq
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
        if let fld_shipping_charges = dictionary["fld_shipping_charges"] as? Int {
            self.fld_shipping_charges = fld_shipping_charges
        }
        if let cart_total_count = dictionary["cart_total_count"] as? Int {
            self.cart_total_count = cart_total_count
        }
        if let fld_product_url = dictionary["fld_product_url"] as? String {
            self.fld_product_url = fld_product_url
        }
        if let fld_brand_name = dictionary["fld_brand_name"] as? String {
            self.fld_brand_name = fld_brand_name
        }
        if let fld_product_name = dictionary["fld_product_name"] as? String {
            self.fld_product_name = fld_product_name
        }
        if let fld_product_sku = dictionary["fld_product_sku"] as? String {
            self.fld_product_sku = fld_product_sku
        }
        if let size_chart = dictionary["size_chart"] as? String {
            self.size_chart = size_chart
        }
        if let fld_product_short_description = dictionary["fld_product_short_description"] as? String {
            self.fld_product_short_description = fld_product_short_description
        }
        if let fld_product_long_description = dictionary["fld_product_long_description"] as? String {
            self.fld_product_long_description = fld_product_long_description
        }
        if let fld_product_qty = dictionary["fld_product_qty"] as? String {
            self.fld_product_qty = fld_product_qty
        }
        if let fld_product_image = dictionary["fld_product_image"] as? String {
            self.fld_product_image = fld_product_image
        }
        if let fld_delivery_days = dictionary["fld_delivery_days"] as? String {
            self.fld_delivery_days = fld_delivery_days
        }
        if let isInWishlist = dictionary["isInWishlist"] as? Bool {
            self.isInWishlist = isInWishlist
        }
        if let isInCart = dictionary["isInCart"] as? Bool {
            self.isInCart = isInCart
        }
        if let alreadyInCart = dictionary["alreadyInCart"] as? Bool {
            self.alreadyInCart = alreadyInCart
        }
        if let fld_more_seller = dictionary["fld_more_seller"] as? Bool {
            self.fld_more_seller = fld_more_seller
        }
        self.attribute = aAttribute
        self.thumbnail = aThumbnail
        self.fld_seller_info = aFldSellerInfo
    }
}
class Attributes: NSObject {
    var aSizes: [Sizes] = []
    var aColors: [Colors] = []
    override init() {
    }
    init(aaSizes: [Sizes], aaColors: [Colors]) {
        self.aSizes = aaSizes
        self.aColors = aaColors
    }
}

class Sizes: NSObject {
    var fld_size_id : Int = 0
    var fld_size_name : String = ""
    var fld_size_moq : Int = 0
    var fld_size_price : Int = 0
    
    override init() {
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_size_id = dictionary["fld_size_id"] as? Int {
            self.fld_size_id = fld_size_id
        }
        if let fld_size_name = dictionary["fld_size_name"] as? String {
            self.fld_size_name = fld_size_name
        }
       
        if let fld_size_moq = dictionary["fld_size_moq"] as? Int {
            self.fld_size_moq = fld_size_moq
        }
        if let fld_size_price = dictionary["fld_size_price"] as? Int {
            self.fld_size_price = fld_size_price
        }
    }
}
class Colors: NSObject {
    var fld_color_id : Int = 0
    var fld_color_name : String = ""
    var fld_color_code : String = ""
    var fld_color_thumbnail : String = ""
    var fld_color_price : String = ""
    override init() {
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_color_id = dictionary["fld_color_id"] as? Int {
            self.fld_color_id = fld_color_id
        }
        if let fld_color_name = dictionary["fld_color_name"] as? String {
            self.fld_color_name = fld_color_name
        }
        if let fld_color_price = dictionary["fld_color_price"] as? Int {
            self.fld_color_price = fld_color_price.description
        }
        if let fld_color_code = dictionary["fld_color_code"] as? String {
            self.fld_color_code = fld_color_code
        }
        if let fld_color_thumbnail = dictionary["fld_color_thumbnail"] as? String {
            self.fld_color_thumbnail = fld_color_thumbnail
        }
    }
}
class Thumbnail: NSObject {
    var image : String = ""
    override init() {
    }
    init(aImageUrl: String) {
        self.image = aImageUrl
    }
}
class SellerInfo: NSObject {
    var fld_seller_name : String = ""
    var fld_seller_rating : Int = 0
    var fld_return_policy_days : String = ""
    override init() {
    }
    init(name: String, rating: Int, policy: String) {
        self.fld_seller_name = name
        self.fld_seller_rating = rating
        self.fld_return_policy_days = policy
    }
}
