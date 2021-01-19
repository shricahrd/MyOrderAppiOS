//
//  CouponsModel.swift
//  MyOrder
//
//  Created by sourabh on 06/11/20.
//

import UIKit

class CouponsModel: NSObject {
    var fld_coupon_name: String = ""
    var fld_coupon_attr_name: String = ""
    var below_cart_amt: String = ""
    var above_cart_amt: String = ""
    var fld_coupon_validty_start_date: String = ""
    var fld_coupon_validty_end_date: String = ""
    var fld_coupon_cart_info: String = ""
    var fld_description: String = ""
    var fld_coupon_code: String = ""
    var fld_coupon_image: String = ""
    var expiry_date: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_coupon_name = dictionary["fld_coupon_name"] as? String {
            self.fld_coupon_name = fld_coupon_name
        }
        if let fld_coupon_attr_name = dictionary["fld_coupon_attr_name"] as? String {
            self.fld_coupon_attr_name = fld_coupon_attr_name
        }
        if let below_cart_amt = dictionary["below_cart_amt"] as? String {
            self.below_cart_amt = below_cart_amt
        }
        if let above_cart_amt = dictionary["above_cart_amt"] as? String {
            self.above_cart_amt = above_cart_amt
        }
        if let fld_coupon_validty_start_date = dictionary["fld_coupon_validty_start_date"] as? String {
            self.fld_coupon_validty_start_date = fld_coupon_validty_start_date
        }
        if let fld_coupon_validty_end_date = dictionary["fld_coupon_validty_end_date"] as? String {
            self.fld_coupon_validty_end_date = fld_coupon_validty_end_date
        }
        if let fld_coupon_cart_info = dictionary["fld_coupon_cart_info"] as? String {
            self.fld_coupon_cart_info = fld_coupon_cart_info
        }
        if let fld_description = dictionary["fld_description"] as? String {
            self.fld_description = fld_description
        }
        if let fld_coupon_code = dictionary["fld_coupon_code"] as? String {
            self.fld_coupon_code = fld_coupon_code
        }
        if let fld_coupon_image = dictionary["fld_coupon_image"] as? String {
            self.fld_coupon_image = fld_coupon_image
        }
        if let expiry_date = dictionary["expiry_date"] as? String {
            self.expiry_date = expiry_date
        }
    }
}
