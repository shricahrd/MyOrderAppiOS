//
//  RedeemOrderModel.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//



import UIKit

class RedeemOrderModel: NSObject {
    var next_page: Int = 0
    var fld_total_page: Int = 0
    var aRedeemOrders : [RedeemOrders] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aRedeemOrders: [RedeemOrders]) {
        self.aRedeemOrders = aRedeemOrders
        if let next_page = dictionary["next_page"] as? Int {
            self.next_page = next_page
        }
        if let fld_total_page = dictionary["fld_total_page"] as? Int {
            self.fld_total_page = fld_total_page
        }
    }
}
class RedeemOrders: NSObject {
    var fld_coupon_amt: Int = 0
    var fld_order_id: Int = 0
    var fld_order_qty: Int = 0
    var fld_order_shipping_area: Int = 0
    var fld_order_shipping_city: Int = 0
    var fld_order_status: Int = 0
    var fld_order_total_amt: Int = 0
    var fld_order_shipping_state: Int = 0
    var fld_order_shipping_state_name: String = ""
    var fld_order_shipping_zip: String = ""
    var fld_order_shipping_city_name: String = ""
    var fld_order_shipping_email: String = ""
    var fld_order_shipping_name: String = ""
    var fld_order_shipping_phone: String = ""
    var fld_order_shipping_area_name: String = ""
    var fld_order_shipping_address: String = ""
    var fld_order_no: String = ""
    var fld_order_date: String = ""
    var fldorder_shipping_locality: String = ""
    var aRedeemOrderProducts: [RedeemOrderProducts] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aRedeemOrderProducts: [RedeemOrderProducts]) {
        self.aRedeemOrderProducts = aRedeemOrderProducts
        
        if let fld_order_shipping_state_name = dictionary["fld_order_shipping_state_name"] as? String {
            self.fld_order_shipping_state_name = fld_order_shipping_state_name
        }
        if let fld_order_shipping_zip = dictionary["fld_order_shipping_zip"] as? String {
            self.fld_order_shipping_zip = fld_order_shipping_zip
        }
        if let fld_order_shipping_city_name = dictionary["fld_order_shipping_city_name"] as? String {
            self.fld_order_shipping_city_name = fld_order_shipping_city_name
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
        if let fld_order_shipping_area_name = dictionary["fld_order_shipping_area_name"] as? String {
            self.fld_order_shipping_area_name = fld_order_shipping_area_name
        }
        if let fld_order_shipping_address = dictionary["fld_order_shipping_address"] as? String {
            self.fld_order_shipping_address = fld_order_shipping_address
        }
        if let fld_order_no = dictionary["fld_order_no"] as? String {
            self.fld_order_no = fld_order_no
        }
        if let fld_order_date = dictionary["fld_order_date"] as? String {
            self.fld_order_date = fld_order_date
        }
        if let fldorder_shipping_locality = dictionary["fldorder_shipping_locality"] as? String {
            self.fldorder_shipping_locality = fldorder_shipping_locality
        }
        if let fld_coupon_amt = dictionary["fld_coupon_amt"] as? Int {
            self.fld_coupon_amt = fld_coupon_amt
        }
        if let fld_order_id = dictionary["fld_order_id"] as? Int {
            self.fld_order_id = fld_order_id
        }
        if let fld_order_qty = dictionary["fld_order_qty"] as? String {
            self.fld_order_qty = Int(fld_order_qty) ?? 0
        }
        if let fld_order_shipping_area = dictionary["fld_order_shipping_area"] as? Int {
            self.fld_order_shipping_area = fld_order_shipping_area
        }
        if let fld_order_shipping_city = dictionary["fld_order_shipping_city"] as? Int {
            self.fld_order_shipping_city = fld_order_shipping_city
        }
        if let fld_order_status = dictionary["fld_order_status"] as? Int {
            self.fld_order_status = fld_order_status
        }
        if let fld_order_total_amt = dictionary["fld_order_total_amt"] as? String {
            self.fld_order_total_amt = Int(fld_order_total_amt) ?? 0
        }
        if let fld_order_shipping_state = dictionary["fld_order_shipping_state"] as? Int {
            self.fld_order_shipping_state = fld_order_shipping_state
        }
    }
}
class RedeemOrderProducts: NSObject {
    var fld_order_qty: Int = 0
    var fld_product_id: Int = 0
    var fld_product_points: Int = 0
    var fld_qty: Int = 0
    var order_detail_status: Int = 0
    var fld_product_name: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_order_qty = dictionary["fld_order_qty"] as? String {
            self.fld_order_qty = Int(fld_order_qty) ?? 0
        }
        if let fld_product_id = dictionary["fld_product_id"] as? Int {
            self.fld_product_id = fld_product_id
        }
        if let fld_product_points = dictionary["fld_product_points"] as? Int {
            self.fld_product_points = fld_product_points
        }
        if let fld_qty = dictionary["fld_qty"] as? String {
            self.fld_qty = Int(fld_qty) ?? 0
        }
        if let order_detail_status = dictionary["order_detail_status"] as? Int {
            self.order_detail_status = order_detail_status
        }
        if let fld_product_name = dictionary["fld_product_name"] as? String {
            self.fld_product_name = fld_product_name
        }
    }
}
