//
//  ProductSearchModel.swift
//  MyOrderApp
//
//  Created by Apple on 8/20/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation
// MARK: - ProductSearchResponce
struct ProductSearchResponce: Codable {
    let status: Bool?
    let statusCode, fldTotalPage: Int?
    let message: String?
    let gridListView, nextPage: Int?
    let productSearchData: [ProductSearchDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode
        case fldTotalPage = "fld_total_page"
        case message
        case gridListView = "grid_list_view"
        case nextPage = "next_page"
        case productSearchData = "product_search_data"
    }
}

// MARK: - ProductSearchDatum
struct ProductSearchDatum: Codable {
    let searchName: String?
    let categoryID: Int?
    let categoryName: String?
    let categoryCompare: Int?


    enum CodingKeys: String, CodingKey {
        case searchName = "search_name"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case categoryCompare = "category_compare"
    }
}
