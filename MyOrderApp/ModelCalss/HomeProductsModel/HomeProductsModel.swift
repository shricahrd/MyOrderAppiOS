//  HomeProductsModel.swift
//  MyOrderApp
//  Created by Apple on 8/27/20.
//  Copyright © 2020 rakesh. All rights reserved.


import Foundation

// MARK: - HomeResponce

struct HomeResponce: Codable {
    let status: Bool?
    let statusCode, fldTotalPage: Int?
    let message: String?
    let nextPage: Int?
    let homeProductListing: [HomeProductListing]?
    enum CodingKeys: String, CodingKey {
        case status, statusCode
        case fldTotalPage = "fld_total_page"
        case message
        case nextPage = "next_page"
        case homeProductListing = "Home_Product_Listing"
    }
}

// MARK: - HomeProductListing

struct HomeProductListing: Codable {
    let title: String?
    let nextPage: Int?
    let hotDealsData, newCollectionData: [Datum]?
    enum CodingKeys: String, CodingKey {
        case title
        case nextPage = "next_page"
        case hotDealsData = "hot_deals_data"
        case newCollectionData = "new_collection_data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id, catID, colorID, sizeID: Int?
    let extraPrice: Int?
    let name: String?
    let price, spclPrice: Int?
    let fldBrandName: String?
    let defaultImage: String?
    enum CodingKeys: String, CodingKey {
        case id
        case catID = "cat_id"
        case colorID = "color_id"
        case sizeID = "size_id"
        case extraPrice = "extra_price"
        case name, price
        case spclPrice = "spcl_price"
        case fldBrandName = "fld_brand_name"
        case defaultImage = "default_image"
    }
}
