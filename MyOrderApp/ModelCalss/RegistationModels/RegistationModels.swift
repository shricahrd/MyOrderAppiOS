//
//  RegistationModels.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 04/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation


// MARK: - RegistationResponce
struct RegistationResponce: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let registerData: RegisterData?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case registerData = "register_data"
    }
}

// MARK: - RegisterData
struct RegisterData: Codable {
    let id: Int?
    let email, contactNumber, name, registerType: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case contactNumber = "contact_number"
        case name
        case registerType = "register_type"
    }
}





