//
//  CheckoutModel.swift
//  MyOrder
//
//  Created by sourabh on 29/10/20.
//

import UIKit

class CheckoutModel: NSObject {
    var total_qty: Int = 0
    var save_total: Int = 0
    var shipping_total: Int = 0
    var cart_total: Int = 0
    var aCouponModel = CouponModel()
    var aCartReviewList : [CartReviewList] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aCartReviewList: [CartReviewList]) {
        self.aCartReviewList = aCartReviewList
        if let total_qty = dictionary["total_qty"] as? Int {
            self.total_qty = total_qty
        }
        if let save_total = dictionary["save_total"] as? Int {
            self.save_total = save_total
        }
        if let shipping_total = dictionary["shipping_total"] as? Int {
            self.shipping_total = shipping_total
        }
        if let cart_total = dictionary["cart_total"] as? Int {
            self.cart_total = cart_total
        }
    }
}

class CartReviewList: NSObject {
    var fld_product_color: Int = 0
    var fld_product_id: String = ""
    var fld_product_name: String = ""
    var fld_product_price: Int = 0
    var fld_product_qty: Int = 0
    var fld_product_size: Int = 0
    var fld_shipping_charges: Int = 0
    var fld_product_points: Int = 0
    var fld_spcl_price: Int = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_product_color = dictionary["fld_product_color"] as? Int {
            self.fld_product_color = fld_product_color
        }
        if let fld_product_points = dictionary["fld_product_points"] as? Int {
            self.fld_product_points = fld_product_points
        }
        if let fld_product_id = dictionary["fld_product_id"] as? String {
            self.fld_product_id = fld_product_id
        }
        if let fld_product_name = dictionary["fld_product_name"] as? String {
            self.fld_product_name = fld_product_name
        }
        if let fld_product_price = dictionary["fld_product_price"] as? Int {
            self.fld_product_price = fld_product_price
        }
        if let fld_product_qty = dictionary["fld_product_qty"] as? Int {
            self.fld_product_qty = fld_product_qty
        }
        if let fld_product_qty = dictionary["fld_product_qty"] as? String {
            self.fld_product_qty = Int(fld_product_qty) ?? 0
        }
        if let fld_product_size = dictionary["fld_product_size"] as? Int {
            self.fld_product_size = fld_product_size
        }
        if let fld_shipping_charges = dictionary["fld_shipping_charges"] as? Int {
            self.fld_shipping_charges = fld_shipping_charges
        }
        if let fld_spcl_price = dictionary["fld_spcl_price"] as? Int {
            self.fld_spcl_price = fld_spcl_price
        }
    }
}
