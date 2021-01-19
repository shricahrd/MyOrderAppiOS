//
//  CartModel.swift
//  MyOrder
//
//  Created by sourabh on 19/10/20.
//

import UIKit

class CouponModel: NSObject {
    var discount_amount: Int = 0
    var discount_percent: Int = 0
    var coupon_code: String = ""
    var codeApply = false
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let coupon_code = dictionary["coupon_code"] as? String {
            self.coupon_code = coupon_code
        }
        if let discount_amount = dictionary["discount_amount"] as? Int {
            self.discount_amount = discount_amount
        }
        if let discount_percent = dictionary["discount_percent"] as? Int {
            self.discount_percent = discount_percent
        }
        self.codeApply = true
    }
 
}
class CartModel: NSObject {
    var aCartList: [CartList] = []
    var total_qty: Int = 0
    var save_total: Int = 0
    var shipping_total: Int = 0
    var cart_total: Int = 0
    var aCouponModel = CouponModel()
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aCartList: [CartList]) {
        self.aCartList = aCartList
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
class CartList: NSObject {
    var default_image: String = ""
    var fld_brand_name: String = ""
    var fld_delivery_days: String = ""
    var fld_product_name: String = ""
    var fld_product_sku: String = ""
    var fld_supplier_name: String = ""
    var fld_shipping_charges: Int = 0
    var fld_spcl_price: Int = 0
    var fld_product_price: Int = 0
    var fld_product_qty: String = ""
    var fld_product_size: Int = 0
    var fld_product_color: Int = 0
    var fld_product_id: String = ""
    var colorsizelist: [Colorsizelist] = []
    var aAdditionalColor: [AdditionalColor] = []
    var aAdditionalSize: [AdditionalSize] = []

    
    override init(){
    }
    init(fromDictionary dictionary: [String: Any],
         aColorsizelist: [Colorsizelist],
         aAdditionalColor: [AdditionalColor],
         aAdditionalSize: [AdditionalSize]) {
        if let default_image = dictionary["default_image"] as? String {
            self.default_image = default_image
        }
        if let fld_brand_name = dictionary["fld_brand_name"] as? String {
            self.fld_brand_name = fld_brand_name
        }
        if let fld_delivery_days = dictionary["fld_delivery_days"] as? String {
            self.fld_delivery_days = fld_delivery_days
        }
        if let fld_product_name = dictionary["fld_product_name"] as? String {
            self.fld_product_name = fld_product_name
        }
        if let fld_product_sku = dictionary["fld_product_sku"] as? String {
            self.fld_product_sku = fld_product_sku
        }
        if let fld_supplier_name = dictionary["fld_supplier_name"] as? String {
            self.fld_supplier_name = fld_supplier_name
        }
        if let fld_spcl_price = dictionary["fld_spcl_price"] as? Int {
            self.fld_spcl_price = fld_spcl_price
        }
        if let fld_shipping_charges = dictionary["fld_shipping_charges"] as? Int {
            self.fld_shipping_charges = fld_shipping_charges
        }
        if let fld_product_price = dictionary["fld_product_price"] as? Int {
            self.fld_product_price = fld_product_price
        }
        if let fld_product_qty = dictionary["fld_product_qty"] as? String {
            self.fld_product_qty = fld_product_qty
        }
        if let fld_product_size = dictionary["fld_product_size"] as? Int {
            self.fld_product_size = fld_product_size
        }
        if let fld_product_color = dictionary["fld_product_color"] as? Int {
            self.fld_product_color = fld_product_color
        }
        if let fld_product_id = dictionary["fld_product_id"] as? String {
            self.fld_product_id = fld_product_id
        }
        colorsizelist = aColorsizelist
        self.aAdditionalColor = aAdditionalColor
        self.aAdditionalSize = aAdditionalSize
    }
}
class Colorsizelist: NSObject {
    var color_id: Int = 0
    var color_size_qty: Int = 0
    var color_name: String = ""
    var isSizeVisible: Bool = false
    var size_list: [Sizelist] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], sizes: [Sizelist]) {
        if let color_id = dictionary["color_id"] as? Int {
            self.color_id = color_id
        }
        if let color_name = dictionary["color_name"] as? String {
            self.color_name = color_name
        }
        if let color_size_qty = dictionary["color_size_qty"] as? Int {
            self.color_size_qty = color_size_qty
        }
        if let color_size_qty = dictionary["color_size_qty"] as? String {
            self.color_size_qty = Int(color_size_qty)!
        }
        self.size_list = sizes
    }
}
class AdditionalColor: NSObject {
    var color_code: String = ""
    var color_name: String = ""
    var color_id: Int = 0
    var price: Int = 0
    var qty: Int = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let color_code = dictionary["color_code"] as? String {
            self.color_code = color_code
        }
        if let color_name = dictionary["color_name"] as? String {
            self.color_name = color_name
        }
        if let color_id = dictionary["color_id"] as? Int {
            self.color_id = color_id
        }
        if let price = dictionary["price"] as? Int {
            self.price = price
        }
        if let qty = dictionary["qty"] as? String {
            self.qty = Int(qty) ?? 0
        }
    }
}
class AdditionalSize: NSObject {
    var size_name: String = ""
    var price: Int = 0
    var qty: Int = 0
    var size_id: Int = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let size_name = dictionary["size_name"] as? String {
            self.size_name = size_name
        }
        if let size_id = dictionary["size_id"] as? Int {
            self.size_id = size_id
        }
        if let price = dictionary["price"] as? Int {
            self.price = price
        }
        if let qty = dictionary["qty"] as? String {
            self.qty = Int(qty) ?? 0
        }
    }
}
    
class Sizelist: NSObject {
    var color_id: Int = 0
    var price: Int = 0
    var product_id: Int = 0
    var qty: String = ""
    var size_id: Int = 0
    var size_name: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let color_id = dictionary["color_id"] as? Int {
            self.color_id = color_id
        }
        if let price = dictionary["price"] as? Int {
            self.price = price
        }
        if let product_id = dictionary["product_id"] as? Int {
            self.product_id = product_id
        }
        if let qty = dictionary["qty"] as? String {
            self.qty = qty
        }
        if let qty = dictionary["qty"] as? Int {
            self.qty = qty.description
        }
        if let size_id = dictionary["size_id"] as? Int {
            self.size_id = size_id
        }
        if let size_name = dictionary["size_name"] as? String {
            self.size_name = size_name
        }
    }
}
class AddCart : NSObject {
    var fld_product_id: Int?
    var fld_manufacture_id: Int?
    var fld_size_id: Int?
    var fld_color_id: Int?
    var fld_product_qty: Int?
    override init() {
        super.init()
    }
    init(aProductId: Int, aManufactureId: Int?, aSizeId: Int?, aColorId: Int?, aProductQty: Int?) {
        self.fld_product_id = aProductId
        self.fld_manufacture_id = aManufactureId
        self.fld_size_id = aSizeId
        self.fld_color_id = aColorId
        self.fld_product_qty = aProductQty
    }
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if fld_product_id != nil {
            dictionary["fld_product_id"] = fld_product_id
        }
        if fld_manufacture_id != nil {
            dictionary["fld_manufacture_id"] = fld_manufacture_id
        }
        if fld_size_id != nil {
            dictionary["fld_size_id"] = fld_size_id
        }
        if fld_color_id != nil {
            dictionary["fld_color_id"] = fld_color_id
        }
        if fld_product_qty != nil {
            dictionary["fld_product_qty"] = fld_product_qty
        }
        return dictionary
    }
}
