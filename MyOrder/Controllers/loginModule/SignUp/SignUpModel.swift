//
//  SignUpModel.swift
//  MyOrder
//
//  Created by sourabh on 09/10/20.
//

import UIKit

class SignUpModel: NSObject {
    var contact_number : String = ""
    var email : String = ""
    var id : Int = 0
    var name : String = ""
    var panel_type : Int = 0
    var register_type : UserType = .unknown
    init(fromDictionary dictionary: [String: Any]) {
        if let contact_number = dictionary["contact_number"] as? String {
            self.contact_number = contact_number
        }
        if let email = dictionary["email"] as? String {
            self.email = email
        }
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        if let panel_type = dictionary["panel_type"] as? Int {
            self.panel_type = panel_type
        }
        if let register_type = dictionary["register_type"] as? String {
            switch register_type {
            case "manufacture":
                self.register_type = .manufacture
            case "stockist":
                self.register_type = .stockist
            case "distributor":
                self.register_type = .distributor
            case "retailer":
                self.register_type = .retailer
            case "agent":
                self.register_type = .agent
            default:
                self.register_type = .unknown
            }
        }
    }
}
