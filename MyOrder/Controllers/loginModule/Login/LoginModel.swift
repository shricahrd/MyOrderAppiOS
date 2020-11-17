//
//  LoginModel.swift
//  MyOrder
//
//  Created by gwl on 09/10/20.
//

import UIKit
class LoginModel: NSObject {
    var fld_user_id : Int = 0
    var fld_user_name : String = ""
    var fld_user_email : String = ""
    var fld_user_phone : String = ""
    var panel_type: Int = 0
    var isOtpVerified: Bool = false
    var bank_detail: Int = 0
    var company_detail: Int = 0
    var document_detail: Int = 0
    var gst_detail: Int = 0
    var referal_code : String = ""
    var token : String = ""
    
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["fld_user_id"] as? Int {
            self.fld_user_id = id
        }
        if let name = dictionary["fld_user_name"] as? String {
            self.fld_user_name = name
        }
        if let email = dictionary["fld_user_email"] as? String {
            self.fld_user_email = email
        }
        if let contact_number = dictionary["fld_user_phone"] as? String {
            self.fld_user_phone = contact_number
        }
        if let panel_type = dictionary["panel_type"] as? Int {
            self.panel_type = panel_type
        }
        if let isOtpVerified = dictionary["isOtpVerified"] as? Bool {
            self.isOtpVerified = isOtpVerified
        }
        if let bank_detail = dictionary["bank_detail"] as? Int {
            self.bank_detail = bank_detail
        }
        if let company_detail = dictionary["company_detail"] as? Int {
            self.company_detail = company_detail
        }
        if let document_detail = dictionary["document_detail"] as? Int {
            self.document_detail = document_detail
        }
        if let gst_detail = dictionary["gst_detail"] as? Int {
            self.gst_detail = gst_detail
        }
        if let referal_code = dictionary["referal_code"] as? String {
            self.referal_code = referal_code
        }
        if let token = dictionary["token"] as? String {
            self.token = token
        }
    }
}
