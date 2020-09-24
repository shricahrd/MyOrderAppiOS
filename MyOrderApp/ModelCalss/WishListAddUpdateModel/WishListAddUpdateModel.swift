//  WishListAddUpdateModel.swift
//  MyOrderApp
//  Created by Apple on 8/20/20.
//  Copyright © 2020 rakesh. All rights reserved.

import Foundation
struct WishListAddUpdateResponce: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let wishlistAddUpdateData: Bool?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case wishlistAddUpdateData = "wishlist_add_update_data"
    }
}
