//
//  RewardCatagoryModel.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit
class RewardCatagoryModel: NSObject {
    var aRewardCatagoryList: [RewardCatagoryList] = []
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aRewardCatagoryList: [RewardCatagoryList]) {
        self.aRewardCatagoryList = aRewardCatagoryList
        if let nextPage = dictionary["nextPage"] as? Int {
            self.nextPage = nextPage
        }
        if let fld_total_page = dictionary["fld_total_page"] as? Int {
            self.fld_total_page = fld_total_page
        }
    }
}
class RewardCatagoryList: NSObject {
    var id: Int = 0
    var name: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
    }
}
