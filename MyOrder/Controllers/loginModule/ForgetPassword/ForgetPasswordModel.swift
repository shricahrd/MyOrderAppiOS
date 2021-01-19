//
//  ForgetPasswordModel.swift
//  MyOrder
//
//  Created by sourabh on 09/10/20.
//

import UIKit

class ForgetPasswordModel: NSObject {
    var fld_user_id : Int = 0
    var message : String = ""
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["fld_user_id"] as? Int {
            self.fld_user_id = id
        }
        if let message = dictionary["message"] as? String {
            self.message = message
        }
    }
}
