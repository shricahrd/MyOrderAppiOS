//
//  BrandModel.swift
//  MyOrderApp
//
//  Created by Apple on 8/21/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation
// MARK: - BrandListResponce
struct BrandListResponce: Codable {
    let status: Bool?
    let statusCode, fldTotalPage: Int?
    let message: String?
    let nextPage: Int?
    let brandData: [BrandDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode
        case fldTotalPage = "fld_total_page"
        case message
        case nextPage = "next_page"
        case brandData = "brand_data"
    }
}

// MARK: - BrandDatum
struct BrandDatum: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let bannerImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, logo
        case bannerImage = "banner_image"
    }
}
