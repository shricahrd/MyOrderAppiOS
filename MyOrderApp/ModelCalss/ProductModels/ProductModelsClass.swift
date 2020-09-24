//
//  ProductModelsClass.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 14/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation


// MARK: - ProductDetailesResponce
struct ProductDetailesResponce: Codable {
    let status: Bool?
    let statusCode, fldTotalPage, cartTotalCount: Int?
    let message: String?
    let gridListView, nextPage: Int?
    let productData: [ProductDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode
        case fldTotalPage = "fld_total_page"
        case cartTotalCount = "cart_total_count"
        case message
        case gridListView = "grid_list_view"
        case nextPage = "next_page"
        case productData = "product_data"
    }
}

// MARK: - ProductDatum
struct ProductDatum: Codable {
    let id, catID, colorID, sizeID: Int?
    let extraPrice: Int?
    let name: String?
    let fldBrandName: String?
    let price, spclPrice: Int?
    let defaultImage: String?
    let fldTotalRating, fldRatingCount, fldReviewCount: Int?
    let isInWishlist: Bool?
    

    enum CodingKeys: String, CodingKey {
        case id
        case catID = "cat_id"
        case colorID = "color_id"
        case sizeID = "size_id"
        case extraPrice = "extra_price"
        case fldBrandName = "fld_brand_name"
        case name, price
        case spclPrice = "spcl_price"
        case defaultImage = "default_image"
        case fldTotalRating = "fld_total_rating"
        case fldRatingCount = "fld_rating_count"
        case fldReviewCount = "fld_review_count"
        case isInWishlist 
    }
}

//{
//"status": true,
//"statusCode": 201,
//"fld_total_page": 0,
//"message": "Product Details",
//"next_page": 1,
//"product_detail_data": {
//"fld_product_id": 2,
//"fld_product_url": "https://aptechbangalore.com/myorder/p/test-rootcat1/sub-category-testu/config-test-product/Mn5+fjEsM35+fjEsMQ==",
//"fld_product_deleted": 0,
//"fld_product_name": "config test product",
//"isInWishlist": false,
//"isInCart": false,
//"fld_brand_name": "new test brand name",
//"alreadyInCart": false,
//"fld_product_price": 2033,
//"fld_product_spcl_price": 1033,
//"fld_product_sku": "2tessub",
//"fld_product_moq": 1,
//"size_chart": "https://aptechbangalore.com/myorder/uploads/category/size_chart/1592553670-680.jpg",
//"fld_product_short_description": "https://aptechbangalore.com/myorder/api/productDesc/0/2",
//"fld_product_long_description": "https://aptechbangalore.com/myorder/api/productDesc/1/2",
//"fld_product_qty": "10",
//"fld_product_image": "https://aptechbangalore.com/myorder/uploads/products/1592565846-288.jpg",
//"attributes": {
//"sizes": [
//{
//"fld_size_id": 1,
//"fld_size_name": "M",
//"fld_size_moq": 4,
//"fld_size_price": 1033
//},
//{
//"fld_size_id": 3,
//"fld_size_name": "Lu",
//"fld_size_moq": 7,
//"fld_size_price": 1022
//}
//],
//"colors": [
//{
//"fld_color_id": 1,
//"fld_color_name": "Black",
//"fld_color_code": "#000000",
//"fld_color_thumbnail": "https://aptechbangalore.com/myorder/uploads/products/240-180/1592565845-24.jpg"
//}
//]
//},
//"thumbnail": [
//{
//"image": "https://aptechbangalore.com/myorder/uploads/products/1592565846-288.jpg"
//},
//{
//"image": "https://aptechbangalore.com/myorder/uploads/products/1592565846-55.jpg"
//},
//{
//"image": "https://aptechbangalore.com/myorder/uploads/products/1592565845-24.jpg"
//}
//],
//"fld_total_rating": 0,
//"fld_rating_count": 0,
//"fld_review_count": 0,
//"fld_more_seller": false,
//"fld_seller_info": {
//"fld_seller_name": null,
//"fld_seller_rating": 3,
//"fld_return_policy_days": ""
//},
//"fld_delivery_days": "",
//"fld_shipping_charges": 0
//}
//}
//
//
