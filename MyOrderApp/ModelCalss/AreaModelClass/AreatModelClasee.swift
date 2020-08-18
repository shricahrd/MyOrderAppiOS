//
//  AreatModelClasee.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 17/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation

// MARK: - AreaResponce
struct AreaResponce: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let areaData: [AreaDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case areaData = "area_data"
    }
}

// MARK: - AreaDatum
struct AreaDatum: Codable {
    let id, stateID, cityID: Int?
    let name: String?
    let status, isdeleted: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case stateID = "state_id"
        case cityID = "city_id"
        case name, status, isdeleted
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
