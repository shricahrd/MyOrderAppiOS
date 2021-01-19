//
//  OrderCancelModel.swift
//  MyOrder
//
//  Created by sourabh on 07/11/20.
//

import Foundation

class CancelReason: NSObject {
    var fld_reason_id: Int = 0
    var fld_reason: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        self.fld_reason_id = dictionary["fld_reason_id"] as? Int ?? 0
        self.fld_reason = dictionary["fld_reason"] as? String ?? ""
    }
}
