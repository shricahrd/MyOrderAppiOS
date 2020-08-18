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
    let statusCode, fldTotalPage: Int?
    let message: String?
    let gridListView, nextPage: Int?
    let productData: [ProductDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode
        case fldTotalPage = "fld_total_page"
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
        case name, price
        case spclPrice = "spcl_price"
        case defaultImage = "default_image"
        case fldTotalRating = "fld_total_rating"
        case fldRatingCount = "fld_rating_count"
        case fldReviewCount = "fld_review_count"
        case isInWishlist
    }
}

