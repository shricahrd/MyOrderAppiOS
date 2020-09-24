//
//  BannersModel.swift
//  MyOrderApp
//
//  Created by Apple on 8/22/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation

// MARK: - BannersResponce
struct BannersResponce: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let bannerData: [BannerDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case bannerData = "banner_data"
    }
}

// MARK: - BannerDatum
struct BannerDatum: Codable {
    let fldSliderID: Int?
    let fldShortDescription: String?
    let fldLongDescription: String?
    let fldBannerURL: String?
    let fldProductType: String?
    let fldCatPrdID: Int?
    let fldSliderImage: String?

    enum CodingKeys: String, CodingKey {
        case fldSliderID = "fld_slider_id"
        case fldShortDescription = "fld_short_description"
        case fldLongDescription = "fld_long_description"
        case fldBannerURL = "fld_banner_url"
        case fldProductType = "fld_product_type"
        case fldCatPrdID = "fld_cat_prd_id"
        case fldSliderImage = "fld_slider_image"
    }
}
