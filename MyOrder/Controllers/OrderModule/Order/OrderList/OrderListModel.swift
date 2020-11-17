//
//  OrderListModel.swift
//  MyOrder
//
//  Created by gwl on 29/10/20.
//

import Foundation

class OrderListModel: NSObject {
    var aMyOrders : [MyOrders] = []
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aMyOrders: [MyOrders] ) {
        self.aMyOrders = aMyOrders
        self.fld_total_page = dictionary["fld_total_page"] as? Int ?? 0
        self.nextPage = dictionary["next_page"] as? Int ?? 0
    }
}

class MyOrders: NSObject {
   
    var fld_coupon_amt: String = ""
    var fld_order_id: Int = 0
    var fld_order_qty: String = ""
    var fld_order_status: Int = 0
    var fld_order_total_amt: String = ""
    var fld_order_no: String = ""
    var fld_order_date: String = ""
    var fld_order_shipping_address: String = ""
    var fld_order_shipping_city: String = ""
    var fld_order_shipping_email: String = ""
    var fld_order_shipping_name: String = ""
    var fld_order_shipping_phone: String = ""
    var fld_order_shipping_state: String = ""
    var fld_order_shipping_zip: String = ""
    var fldorder_shipping_locality: String = ""
    var fld_order_shipping_area: String = ""
    var fld_order_shipping_area_name: String = ""
    var fld_order_shipping_city_name: String = ""
    var fld_order_shipping_state_name: String = ""
    var aCartLists : [CartList] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aCartLists: [CartList]) {
        self.aCartLists = aCartLists
        if let fld_order_shipping_area = dictionary["fld_order_shipping_area"] as? String {
            self.fld_order_shipping_area = fld_order_shipping_area
        }
        if let fld_order_shipping_area_name = dictionary["fld_order_shipping_area_name"] as? String {
            self.fld_order_shipping_area_name = fld_order_shipping_area_name
        }
        if let fld_order_shipping_city_name = dictionary["fld_order_shipping_city_name"] as? String {
            self.fld_order_shipping_city_name = fld_order_shipping_city_name
        }
        if let fld_order_shipping_state_name = dictionary["fld_order_shipping_state_name"] as? String {
            self.fld_order_shipping_state_name = fld_order_shipping_state_name
        }
        if let fld_coupon_amt = dictionary["fld_coupon_amt"] as? String {
            self.fld_coupon_amt = fld_coupon_amt
        }
        if let fld_order_id = dictionary["fld_order_id"] as? Int {
            self.fld_order_id = fld_order_id
        }
        if let fld_order_qty = dictionary["fld_order_qty"] as? String {
            self.fld_order_qty = fld_order_qty
        }
        if let fld_order_status = dictionary["fld_order_status"] as? Int {
            self.fld_order_status = fld_order_status
        }
        if let fld_order_total_amt = dictionary["fld_order_total_amt"] as? String {
            self.fld_order_total_amt = fld_order_total_amt
        }
        if let fld_order_no = dictionary["fld_order_no"] as? String {
            self.fld_order_no = fld_order_no
        }
        if let fld_order_date = dictionary["fld_order_date"] as? String {
            self.fld_order_date = fld_order_date
        }
        if let fld_order_shipping_address = dictionary["fld_order_shipping_address"] as? String {
            self.fld_order_shipping_address = fld_order_shipping_address
        }
        if let fld_order_shipping_city = dictionary["fld_order_shipping_city"] as? String {
            self.fld_order_shipping_city = fld_order_shipping_city
        }
        if let fld_order_shipping_email = dictionary["fld_order_shipping_email"] as? String {
            self.fld_order_shipping_email = fld_order_shipping_email
        }
        if let fld_order_shipping_name = dictionary["fld_order_shipping_name"] as? String {
            self.fld_order_shipping_name = fld_order_shipping_name
        }
        if let fld_order_shipping_phone = dictionary["fld_order_shipping_phone"] as? String {
            self.fld_order_shipping_phone = fld_order_shipping_phone
        }
        if let fld_order_shipping_state = dictionary["fld_order_shipping_state"] as? String {
            self.fld_order_shipping_state = fld_order_shipping_state
        }
        if let fld_order_shipping_zip = dictionary["fld_order_shipping_zip"] as? String {
            self.fld_order_shipping_zip = fld_order_shipping_zip
        }
        if let fldorder_shipping_locality = dictionary["fldorder_shipping_locality"] as? String {
            self.fldorder_shipping_locality = fldorder_shipping_locality
        }
    }
}
