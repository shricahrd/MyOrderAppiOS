//
//  RewardCartModel.swift
//  MyOrder
//
//  Created by MAC-51 on 21/12/20.
//

import UIKit

class RewardCartModel: NSObject{
    var shipping_total: Int = 0
    var total_qty: Int = 0
    var cart_total: Int = 0
    var aRewardCartList: [RewardCartList] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aRewardCartList: [RewardCartList]) {
        self.aRewardCartList = aRewardCartList
        if let shipping_total = dictionary["shipping_total"] as? Int {
            self.shipping_total = shipping_total
        }
        if let total_qty = dictionary["total_qty"] as? Int {
            self.total_qty = total_qty
        }
        if let cart_total = dictionary["cart_total"] as? Int {
            self.cart_total = cart_total
        }
    }
}
class RewardCartList: NSObject {
    var fld_product_id: Int = 0
    var fld_product_points: Int = 0
    var fld_product_qty: Int = 0
    var default_image: String = ""
    var fld_product_name: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_product_id = dictionary["fld_product_id"] as? String {
            self.fld_product_id = Int(fld_product_id) ?? 0
        }
        if let fld_product_points = dictionary["fld_product_points"] as? Int {
            self.fld_product_points = fld_product_points
        }
        if let fld_product_qty = dictionary["fld_product_qty"] as? String {
            self.fld_product_qty = Int(fld_product_qty) ?? 0
        }
        if let default_image = dictionary["default_image"] as? String {
            self.default_image = default_image
        }
        if let fld_product_name = dictionary["fld_product_name"] as? String {
            self.fld_product_name = fld_product_name
        }
    }
}
