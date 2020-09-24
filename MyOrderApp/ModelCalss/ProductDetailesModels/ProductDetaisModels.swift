//
//  ProductDetaisModels.swift
//  MyOrderApp
//
//  Created by Apple on 8/20/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation

// MARK: - ProductDetailesResponce
struct ProductDetailesResponceData: Codable {
    let status: Bool?
    let statusCode, fldTotalPage: Int?
    let message: String?
    let nextPage: Int?
    let productDetailData: ProductDetailData?

    enum CodingKeys: String, CodingKey {
        case status, statusCode
        case fldTotalPage = "fld_total_page"
        case message
        case nextPage = "next_page"
        case productDetailData = "product_detail_data"
    }
}

// MARK: - ProductDetailData
struct ProductDetailData: Codable {
    let fldProductID: Int?
    let fldProductURL: String?
    let fldProductDeleted: Int?
    let fldProductName: String?
    let isInWishlist, isInCart, alreadyInCart: Bool?
    let fldProductPrice, fldProductSpclPrice: Int?
    let fldProductSku: String?
    let fldProductMoq: Int?
    let fldBrandName: String?
    let sizeChart: String?
    let fldProductShortDescription, fldProductLongDescription: String?
    let fldProductQty: String?
    let fldProductImage: String?
    let attributes: AttributesData?
    let thumbnail: [Thumbnail]?
    let fldTotalRating, fldRatingCount, fldReviewCount: Int?
    let fldMoreSeller: Bool?
    let fldSellerInfo: FldSellerInfo?
    let fldDeliveryDays, fldShippingCharges: Int?

    enum CodingKeys: String, CodingKey {
        case fldProductID = "fld_product_id"
        case fldProductURL = "fld_product_url"
        case fldProductDeleted = "fld_product_deleted"
        case fldProductName = "fld_product_name"
        case isInWishlist, isInCart, alreadyInCart
        case fldProductPrice = "fld_product_price"
        case fldProductSpclPrice = "fld_product_spcl_price"
        case fldProductSku = "fld_product_sku"
        case fldProductMoq = "fld_product_moq"
        case fldBrandName = "fld_brand_name"
        case sizeChart = "size_chart"
        case fldProductShortDescription = "fld_product_short_description"
        case fldProductLongDescription = "fld_product_long_description"
        case fldProductQty = "fld_product_qty"
        case fldProductImage = "fld_product_image"
        case attributes, thumbnail
        case fldTotalRating = "fld_total_rating"
        case fldRatingCount = "fld_rating_count"
        case fldReviewCount = "fld_review_count"
        case fldMoreSeller = "fld_more_seller"
        case fldSellerInfo = "fld_seller_info"
        case fldDeliveryDays = "fld_delivery_days"
        case fldShippingCharges = "fld_shipping_charges"
    }
}

// MARK: - Attributes
struct AttributesData: Codable {
    let sizes, colors: [JSONAny]
}

// MARK: - FldSellerInfo
struct FldSellerInfo: Codable {
    let fldSellerName: JSONNull?
    let fldSellerRating: Int
    let fldReturnPolicyDays: String

    enum CodingKeys: String, CodingKey {
        case fldSellerName = "fld_seller_name"
        case fldSellerRating = "fld_seller_rating"
        case fldReturnPolicyDays = "fld_return_policy_days"
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let image: String
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

//class JSONCodingKey: CodingKey {
//    let key: String
//
//    required init?(intValue: Int) {
//        return nil
//    }
//
//    required init?(stringValue: String) {
//        key = stringValue
//    }
//
//    var intValue: Int? {
//        return nil
//    }
//
//    var stringValue: String {
//        return key
//    }
//}

//class JSONAny: Codable {
//
//    let value: Any
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
////    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
////        if let value = try? container.decode(Bool.self) {
////            return value
////        }
////        if let value = try? container.decode(Int64.self) {
////            return value
////        }
////        if let value = try? container.decode(Double.self) {
////            return value
////        }
////        if let value = try? container.decode(String.self) {
////            return value
////        }
////        if let value = try? container.decodeNil() {
////            if value {
////                return JSONNull()
////            }
////        }
////        if var container = try? container.nestedUnkeyedContainer() {
////            return try decodeArray(from: &container)
////        }
////        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
////            return try decodeDictionary(from: &container)
////        }
////        throw decodingError(forCodingPath: container.codingPath)
////    }
//
////    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
////        if let value = try? container.decode(Bool.self, forKey: key) {
////            return value
////        }
////        if let value = try? container.decode(Int64.self, forKey: key) {
////            return value
////        }
////        if let value = try? container.decode(Double.self, forKey: key) {
////            return value
////        }
////        if let value = try? container.decode(String.self, forKey: key) {
////            return value
////        }
////        if let value = try? container.decodeNil(forKey: key) {
////            if value {
////                return JSONNull()
////            }
////        }
////        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
////            return try decodeArray(from: &container)
////        }
////        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
////            return try decodeDictionary(from: &container)
////        }
////        throw decodingError(forCodingPath: container.codingPath)
////    }
//
////    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
////        var arr: [Any] = []
////        while !container.isAtEnd {
////            let value = try decode(from: &container)
////            arr.append(value)
////        }
////        return arr
////    }
//
////    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
////        var dict = [String: Any]()
////        for key in container.allKeys {
////            let value = try decode(from: &container, forKey: key)
////            dict[key.stringValue] = value
////        }
////        return dict
////    }
//
////    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
////        for value in array {
////            if let value = value as? Bool {
////                try container.encode(value)
////            } else if let value = value as? Int64 {
////                try container.encode(value)
////            } else if let value = value as? Double {
////                try container.encode(value)
////            } else if let value = value as? String {
////                try container.encode(value)
////            } else if value is JSONNull {
////                try container.encodeNil()
////            } else if let value = value as? [Any] {
////                var container = container.nestedUnkeyedContainer()
////                try encode(to: &container, array: value)
////            } else if let value = value as? [String: Any] {
////                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
////                try encode(to: &container, dictionary: value)
////            } else {
////                throw encodingError(forValue: value, codingPath: container.codingPath)
////            }
////        }
////    }
//
////    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
////        for (key, value) in dictionary {
////            let key = JSONCodingKey(stringValue: key)!
////            if let value = value as? Bool {
////                try container.encode(value, forKey: key)
////            } else if let value = value as? Int64 {
////                try container.encode(value, forKey: key)
////            } else if let value = value as? Double {
////                try container.encode(value, forKey: key)
////            } else if let value = value as? String {
////                try container.encode(value, forKey: key)
////            } else if value is JSONNull {
////                try container.encodeNil(forKey: key)
////            } else if let value = value as? [Any] {
////                var container = container.nestedUnkeyedContainer(forKey: key)
////                try encode(to: &container, array: value)
////            } else if let value = value as? [String: Any] {
////                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
////                try encode(to: &container, dictionary: value)
////            } else {
////                throw encodingError(forValue: value, codingPath: container.codingPath)
////            }
////        }
////    }
//
////    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
////        if let value = value as? Bool {
////            try container.encode(value)
////        } else if let value = value as? Int64 {
////            try container.encode(value)
////        } else if let value = value as? Double {
////            try container.encode(value)
////        } else if let value = value as? String {
////            try container.encode(value)
////        } else if value is JSONNull {
////            try container.encodeNil()
////        } else {
////            throw encodingError(forValue: value, codingPath: container.codingPath)
////        }
////    }
//
//    public required init(from decoder: Decoder) throws {
//        if var arrayContainer = try? decoder.unkeyedContainer() {
//            self.value = try JSONAny.decodeArray(from: &arrayContainer)
//        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//            self.value = try JSONAny.decodeDictionary(from: &container)
//        } else {
//            let container = try decoder.singleValueContainer()
//            self.value = try JSONAny.decode(from: container)
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        if let arr = self.value as? [Any] {
//            var container = encoder.unkeyedContainer()
//            try JSONAny.encode(to: &container, array: arr)
//        } else if let dict = self.value as? [String: Any] {
//            var container = encoder.container(keyedBy: JSONCodingKey.self)
//            try JSONAny.encode(to: &container, dictionary: dict)
//        } else {
//            var container = encoder.singleValueContainer()
//            try JSONAny.encode(to: &container, value: self.value)
//        }
//    }
//}

