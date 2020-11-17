//
//  AddressListModel.swift
//  MyOrder
//
//  Created by gwl on 20/10/20.
//

import UIKit



class AddressListModel: NSObject {
    
   
    
    var fld_address_id: Int = 0
    var fld_profile_address: Int = 0
    var fld_user_name: String = ""
    var fld_user_phone: String = ""
    var fld_user_email: String = ""
    var fld_user_city: String = ""
    var fld_user_address: String = ""
    var fld_user_locality: String = ""
    var fld_user_state: String = ""
    var fld_user_pincode: String = ""
    var fld_user_country: String = ""
    var fld_address_type: Int = 0
    var fld_address_default: Bool = false
    
    var fld_user_area: String = ""
    var fld_user_area_name: String = ""
    var fld_user_city_name: String = ""
    var fld_user_state_name: String = ""
    
    
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_address_id = dictionary["fld_address_id"] as? Int {
            self.fld_address_id = fld_address_id
        }
        if let fld_profile_address = dictionary["fld_profile_address"] as? Int {
            self.fld_profile_address = fld_profile_address
        }
        if let fld_address_type = dictionary["fld_address_type"] as? Int {
            self.fld_address_type = fld_address_type
        }
        if let fld_address_default = dictionary["fld_address_default"] as? Bool {
            self.fld_address_default = fld_address_default
        }
        if let fld_user_name = dictionary["fld_user_name"] as? String {
            self.fld_user_name = fld_user_name
        }
        if let fld_user_phone = dictionary["fld_user_phone"] as? String {
            self.fld_user_phone = fld_user_phone
        }
        if let fld_user_email = dictionary["fld_user_email"] as? String {
            self.fld_user_email = fld_user_email
        }
        if let fld_user_city = dictionary["fld_user_city"] as? String {
            self.fld_user_city = fld_user_city
        }
        if let fld_user_address = dictionary["fld_user_address"] as? String {
            self.fld_user_address = fld_user_address
        }
        if let fld_user_locality = dictionary["fld_user_locality"] as? String {
            self.fld_user_locality = fld_user_locality
        }
        if let fld_user_state = dictionary["fld_user_state"] as? String {
            self.fld_user_state = fld_user_state
        }
        if let fld_user_pincode = dictionary["fld_user_pincode"] as? String {
            self.fld_user_pincode = fld_user_pincode
        }
        if let fld_user_country = dictionary["fld_user_country"] as? String {
            self.fld_user_country = fld_user_country
        }
        if let fld_user_area = dictionary["fld_user_area"] as? String {
            self.fld_user_area = fld_user_area
        }
        if let fld_user_area_name = dictionary["fld_user_area_name"] as? String {
            self.fld_user_area_name = fld_user_area_name
        }
        if let fld_user_city_name = dictionary["fld_user_city_name"] as? String {
            self.fld_user_city_name = fld_user_city_name
        }
        if let fld_user_state_name = dictionary["fld_user_state_name"] as? String {
            self.fld_user_state_name = fld_user_state_name
        }
    }
    init(aCompanyInfo: CompanyInfo) {
        self.fld_address_id = 0
        self.fld_user_name = aCompanyInfo.fld_company_name
        self.fld_user_address = aCompanyInfo.address
        self.fld_user_state = aCompanyInfo.state
        self.fld_user_state_name = aCompanyInfo.state_name
        self.fld_user_city = aCompanyInfo.city
        self.fld_user_city_name = aCompanyInfo.city_name
        self.fld_user_area = aCompanyInfo.area
        self.fld_user_area_name = aCompanyInfo.area_name
        self.fld_user_pincode = aCompanyInfo.pincode
    }
    
}
