//
//  PinModel.swift
//  MyOrder
//
//  Created by gwl on 09/10/20.
//

import UIKit

class PinModel: NSObject {
    var fld_user_id : Int = 0
    var isOtpVerified : Int = 0
    var fld_user_name : String = ""
    var fld_user_email : String = ""
    var fld_user_phone : String = ""
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["fld_user_id"] as? Int {
            self.fld_user_id = id
        }
        if let verified = dictionary["isOtpVerified"] as? Int {
            self.isOtpVerified = verified
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
    }
}
