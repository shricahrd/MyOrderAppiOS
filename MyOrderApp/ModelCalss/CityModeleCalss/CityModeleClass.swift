//
//  CityModeleClass.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 17/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation

// MARK: - CityCodeResponce
struct CityCodeResponce: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let cityData: [CityCodeResponces]?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case cityData = "city_data"
    }
}

// MARK: - CityDatum
struct CityCodeResponces: Codable {
    let id: Int?
    let name: String?
    let stateID, status, isdeleted: Int?
    let createdAt: String?
    let updatedAt: CityCodeResponceJSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name
        case stateID = "state_id"
        case status, isdeleted
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Encode/decode helpers

class CityCodeResponceJSONNull: Codable, Hashable {

    public static func == (lhs: CityCodeResponceJSONNull, rhs: CityCodeResponceJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
