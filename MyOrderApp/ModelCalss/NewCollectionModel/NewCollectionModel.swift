//  NewCollectionModel.swift
//  MyOrderApp
//  Created by Apple on 8/23/20.
//  Copyright © 2020 rakesh. All rights reserved.

import Foundation
// MARK: - NewCollectionResponce
struct NewCollectionResponce: Codable {
    let status: Bool?
    let statusCode, fldTotalPage: Int?
    let message: String?
    let nextPage: Int?
    let newCollectionData: [NewCollectionDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode
        case fldTotalPage = "fld_total_page"
        case message
        case nextPage = "next_page"
        case newCollectionData = "new_collection_data"
    }
}

// MARK: - NewCollectionDatum
struct NewCollectionDatum: Codable {
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
