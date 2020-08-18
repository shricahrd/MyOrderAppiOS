//
//  LoginModel.swift
//  MyOrderApp
//
//  Created by Ivica Technologies on 11/08/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import Foundation


// MARK: - LoginResponce
struct LoginResponce: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let isOtpVerified: Int?
    let loginData: LoginData?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message, isOtpVerified
        case loginData = "login_data"
    }
}

// MARK: - LoginData
struct LoginData: Codable {
    let fldUserID: Int?
    let fldUserName, fldUserEmail, fldUserPhone: String?
    let isOtpVerified: Int?

    enum CodingKeys: String, CodingKey {
        case fldUserID = "fld_user_id"
        case fldUserName = "fld_user_name"
        case fldUserEmail = "fld_user_email"
        case fldUserPhone = "fld_user_phone"
        case isOtpVerified
    }
}

