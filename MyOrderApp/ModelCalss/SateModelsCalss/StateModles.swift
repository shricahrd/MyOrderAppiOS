//
//  StateModles.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 17/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation
// MARK: - StateResponce
struct StateResponce: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let stateData: [StateDatum]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case stateData = "state_data"
    }
}

// MARK: - StateDatum
struct StateDatum: Codable {
    let id: Int?
    let name: String?
    let countryID, status, isdeleted: Int?
    let createdAt: CreatedAt?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryID = "country_id"
        case status, isdeleted
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum CreatedAt: String, Codable {
    case the20200629064952 = "2020-06-29 06:49:52"
    case the20200728004854 = "2020-07-28 00:48:54"
}

