//
//  DashboardModel.swift
//  MyOrder
//
//  Created by sourabh on 10/10/20.
//

import UIKit

class DashboardModel: NSObject{
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    var aDashboardBanners: [DashboardBanner] = []
    var aDashboardHotDeals: DashboardHotDeals = DashboardHotDeals()
    var aDashboardNewCollection: DashboardNewCollection = DashboardNewCollection()
    override init(){
    }
    init(aDashboardBanner : [DashboardBanner],
         aDashboardHotDeals: DashboardHotDeals,
         aDashboardNewCollection: DashboardNewCollection,
         afld_total_page: Int,
         anextPage: Int) {
        self.aDashboardBanners = aDashboardBanner
        self.aDashboardHotDeals = aDashboardHotDeals
        self.aDashboardNewCollection = aDashboardNewCollection
        self.fld_total_page = afld_total_page
        self.nextPage = anextPage
    }
}

class DashboardBanner: NSObject{
    var fld_banner_url : String = ""
    var fld_cat_prd_id : Int = 0
    var fld_long_description : String = ""
    var fld_product_type : String = ""
    var fld_short_description : String = ""
    var fld_slider_id : Int = 0
    var fld_slider_image : String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_banner_url = dictionary["fld_banner_url"] as? String {
            self.fld_banner_url = fld_banner_url
        }
        if let fld_cat_prd_id = dictionary["fld_cat_prd_id"] as? Int {
            self.fld_cat_prd_id = fld_cat_prd_id
        }
        if let fld_long_description = dictionary["fld_long_description"] as? String {
            self.fld_long_description = fld_long_description
        }
        if let fld_product_type = dictionary["fld_product_type"] as? String {
            self.fld_product_type = fld_product_type
        }
        if let fld_short_description = dictionary["fld_short_description"] as? String {
            self.fld_short_description = fld_short_description
        }
        if let fld_slider_id = dictionary["fld_slider_id"] as? Int {
            self.fld_slider_id = fld_slider_id
        }
        if let fld_slider_image = dictionary["fld_slider_image"] as? String {
            self.fld_slider_image = fld_slider_image
        }
    }
}
class DashboardHotDeals: NSObject {
    var nextIndex: Int = 0
    var title: String = ""
    var aDashboardProduct: [DashboardProduct] = []
    override init(){
    }
    init(dashboardProduct: [DashboardProduct], atitle: String, index: Int) {
        self.aDashboardProduct = dashboardProduct
        self.title = atitle
        self.nextIndex = index
    }
}
class DashboardNewCollection: NSObject {
    var nextIndex: Int = 0
    var title: String = ""
    var aDashboardProduct: [DashboardProduct] = []
    override init(){
    }
    init(product: [DashboardProduct], atitle: String, index: Int) {
        self.aDashboardProduct = product
        self.title = atitle
        self.nextIndex = index
    }
}
class DashboardProduct: NSObject {
    var id : Int = 0
    var cat_id : Int = 0
    var color_id : Int = 0
    var size_id : Int = 0
    var extra_price : Int = 0
    var name : String = ""
    var price : Int = 0
    var spcl_price : Int = 0
    var fld_brand_name : String = ""
    var prd_discount : String = ""
    var default_image : String = ""
    var fld_manufacture_id : Int = 0
    var isInWishlist: Bool = false

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
        if let price = dictionary["price"] as? Int {
            self.price = price
        }
        if let spcl_price = dictionary["spcl_price"] as? Int {
            self.spcl_price = spcl_price
        }
        if let fld_brand_name = dictionary["fld_brand_name"] as? String {
            self.fld_brand_name = fld_brand_name
        }
        if let prd_discount = dictionary["prd_discount"] as? String {
            self.prd_discount = prd_discount
        }
        if let default_image = dictionary["default_image"] as? String {
            self.default_image = default_image
        }
        if let isInWishlist = dictionary["isInWishlist"] as? Bool {
            self.isInWishlist = isInWishlist
        }
    }
}
