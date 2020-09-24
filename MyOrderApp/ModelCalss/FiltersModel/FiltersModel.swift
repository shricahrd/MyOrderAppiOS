//  FiltersModel.swift
//  MyOrderApp
//  Created by Apple on 8/22/20.
//  Copyright © 2020 rakesh. All rights reserved.

import Foundation

struct FiltersResponse: Codable {
    var status:Bool?
    var message:String?
    var statusCode:Int?
    var fld_total_page:Int?
    var next_page:Int?
    var filter_type_listing:[FiltersListingData]?
}

struct FiltersListingData: Codable {
    var price_data: PricingData?
    var category_data: [CategoryData]?
    var color_data: [ColorData]?
    var size_data:[SizeData]?
    var brand_data:[BrandData]?
    let name: String?
    let id: Int?
}

struct PricingData:Codable {
    var min_price:Int?
    var max_price:Int?
    var fld_filter_type:String?
    
}

struct CategoryData:Codable {
    var fld_cat_id:Int?
    var fld_cat_name:String?

}

struct ColorData:Codable {
    var fld_id: Int?
    var fld_name: String?
    var fld_code: String?
    var fld_filter_type: String?
    
}

struct SizeData:Codable {
    var fld_id: Int?
    var fld_name: String?
    var fld_filter_type: String?
}

struct BrandData:Codable {
    var fld_id: Int?
    var fld_name: String?
    var fld_filter_type: String?
}


// MARK: - FilterProductResponce
struct FilterProductResponce: Codable {
    var status: Bool?
    var statusCode, fld_total_page: Int?
    var message: String?
    var next_page: Int?
    var product_data: [ProductData]?

}

struct ProductData:Codable {
    var id:Int?
    var cat_id:Int?
    var color_id:Int?
    var size_id:Int?
    var extra_price:Int?
    var name:String?
    var price:Int?
    var spcl_price:Int?
    var default_image:String?
    var fld_total_rating:Int?
    var fld_rating_count:Int?
    var fld_review_count:Int?
    var isInWishlist:Bool?
}
