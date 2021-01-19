//
//  ProfileModel.swift
//  MyOrder
//
//  Created by sourabh on 20/10/20.
//

import UIKit

class ProfileModel: NSObject {
    var aCompanyInfo = CompanyInfo()
    var aDocumentInfo = DocumentInfo()
    var aPersonalInfo = PersonalInfo()
    var aShippingInfo = ShippingInfo()
    override init() {
        super.init()
    }
    init(aaCompanyInfo: CompanyInfo,
         aaDocumentInfo: DocumentInfo,
         aaPersonalInfo: PersonalInfo,
         aaShippingInfo: ShippingInfo) {
        self.aCompanyInfo = aaCompanyInfo
        self.aDocumentInfo = aaDocumentInfo
        self.aPersonalInfo = aaPersonalInfo
        self.aShippingInfo = aaShippingInfo
    }
}
class CompanyInfo: NSObject {
    var area_name: String = ""
    var city_name: String = ""
    var state_name: String = ""
    var address: String = ""
    var area: String = ""
    var city: String = ""
    var cot_no: String = ""
    var fld_company_name: String = ""
    var gst_no: String = ""
    var pincode: String = ""
    var state: String = ""
    var temp_gst_no: String = ""
    override init() {
        super.init()
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let address = dictionary["address"] as? String {
            self.address = address
        }
        if let area_name = dictionary["area_name"] as? String {
            self.area_name = area_name
        }
        if let city_name = dictionary["city_name"] as? String {
            self.city_name = city_name
        }
        if let state_name = dictionary["state_name"] as? String {
            self.state_name = state_name
        }
        if let area = dictionary["area"] as? String {
            self.area = area
        }
        if let city = dictionary["city"] as? String {
            self.city = city
        }
        if let cot_no = dictionary["cot_no"] as? String {
            self.cot_no = cot_no
        }
        if let fld_company_name = dictionary["fld_company_name"] as? String {
            self.fld_company_name = fld_company_name
        }
        if let gst_no = dictionary["gst_no"] as? String {
            self.gst_no = gst_no
        }
        if let pincode = dictionary["pincode"] as? String {
            self.pincode = pincode
        }
        if let state = dictionary["state"] as? String {
            self.state = state
        }
        if let temp_gst_no = dictionary["temp_gst_no"] as? String {
            self.temp_gst_no = temp_gst_no
        }
    }
}
class DocumentInfo: NSObject {
    var cancel_cheque_file: String = ""
    var cot_file: String = ""
    var fssai_file: String = ""
    var gst_certificate_file: String = ""
    var other_file: String = ""
    var owner_image: String = ""
    var shop_establish_file: String = ""
    var shop_image: String = ""
    var temp_gst_file: String = ""
    var trade_file: String = ""
    var udyam_file: String = ""
    override init() {
        super.init()
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let cancel_cheque_file = dictionary["cancel_cheque_file"] as? String {
            self.cancel_cheque_file = cancel_cheque_file
        }
        if let cot_file = dictionary["cot_file"] as? String {
            self.cot_file = cot_file
        }
        if let fssai_file = dictionary["fssai_file"] as? String {
            self.fssai_file = fssai_file
        }
        if let gst_certificate_file = dictionary["gst_certificate_file"] as? String {
            self.gst_certificate_file = gst_certificate_file
        }
        if let other_file = dictionary["other_file"] as? String {
            self.other_file = other_file
        }
        if let owner_image = dictionary["owner_image"] as? String {
            self.owner_image = owner_image
        }
        if let shop_establish_file = dictionary["shop_establish_file"] as? String {
            self.shop_establish_file = shop_establish_file
        }
        if let shop_image = dictionary["shop_image"] as? String {
            self.shop_image = shop_image
        }
        if let temp_gst_file = dictionary["temp_gst_file"] as? String {
            self.temp_gst_file = temp_gst_file
        }
        if let trade_file = dictionary["trade_file"] as? String {
            self.trade_file = trade_file
        }
        if let udyam_file = dictionary["udyam_file"] as? String {
            self.udyam_file = udyam_file
        }
    }
}
class PersonalInfo: NSObject {
    var fld_user_email: String = ""
    var fld_user_mobile: String = ""
    var fld_user_name: String = "--"
    var profile_pic: String = ""
    override init() {
        super.init()
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_user_email = dictionary["fld_user_email"] as? String {
            self.fld_user_email = fld_user_email
        }
        if let fld_user_mobile = dictionary["fld_user_mobile"] as? String {
            self.fld_user_mobile = fld_user_mobile
        }
        if let fld_user_name = dictionary["fld_user_name"] as? String {
            self.fld_user_name = fld_user_name
        }
        if let profile_pic = dictionary["profile_pic"] as? String {
            self.profile_pic = profile_pic
        }
    }
}

class ShippingInfo: NSObject {
    var address: String = ""
    var area: String = ""
    var city: String = ""
    var fld_shipping_name: String = "--"
    var pincode: String = ""
    var state: String = ""
    override init() {
        super.init()
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let address = dictionary["address"] as? String {
            self.address = address
        }
        if let area = dictionary["area"] as? String {
            self.area = area
        }
        if let city = dictionary["city"] as? String {
            self.city = city
        }
        if let fld_shipping_name = dictionary["fld_shipping_name"] as? String {
            self.fld_shipping_name = fld_shipping_name
        }
        if let pincode = dictionary["pincode"] as? String {
            self.pincode = pincode
        }
        if let state = dictionary["state"] as? String {
            self.state = state
        }
    }
}
