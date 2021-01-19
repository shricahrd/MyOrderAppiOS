//
//  AddAddressModel.swift
//  MyOrder
//
//  Created by sourabh on 20/10/20.
//
import Foundation

class AddAddressModel: NSObject {
}
class StateList: NSObject {
    var id: Int = 0
    var name: String = ""
    var country_id: Int = 0
    override init() {
        super.init()
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        if let country_id = dictionary["country_id"] as? Int {
            self.country_id = country_id
        }
    }
}
class CityList: NSObject {
    var id: Int = 0
    var state_id: Int = 0
    var status: Int = 0
    var isdeleted: Bool = false
    var created_at: String = ""
    var updated_at: String = ""
    var name: String = ""
    override init() {
        super.init()
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let state_id = dictionary["state_id"] as? Int {
            self.state_id = state_id
        }
        if let status = dictionary["status"] as? Int {
            self.status = status
        }
        if let isdeleted = dictionary["isdeleted"] as? Bool {
            self.isdeleted = isdeleted
        }
        if let created_at = dictionary["created_at"] as? String {
            self.created_at = created_at
        }
        if let updated_at = dictionary["updated_at"] as? String {
            self.updated_at = updated_at
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
    }
}
class AreaList: NSObject {
    var id: Int = 0
    var state_id: Int = 0
    var city_id: Int = 0
    var status: Int = 0
    var isdeleted: Bool = false
    var created_at: String = ""
    var updated_at: String = ""
    var name: String = ""
    override init() {
        super.init()
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let state_id = dictionary["state_id"] as? Int {
            self.state_id = state_id
        }
        if let city_id = dictionary["city_id"] as? Int {
            self.city_id = city_id
        }
        if let status = dictionary["status"] as? Int {
            self.status = status
        }
        if let isdeleted = dictionary["isdeleted"] as? Bool {
            self.isdeleted = isdeleted
        }
        if let created_at = dictionary["created_at"] as? String {
            self.created_at = created_at
        }
        if let updated_at = dictionary["updated_at"] as? String {
            self.updated_at = updated_at
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
    }
}
