//
//  WalletModel.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit

class WalletModel: NSObject {
    var total_earned: Int = 0
    var total_reward_points: Int = 0
    var total_spend: Int = 0
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    var aWalletModelList: [WalletModelList] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aWalletModelList: [WalletModelList]) {
        self.aWalletModelList = aWalletModelList
        if let total_earned = dictionary["total_earned"] as? Int {
            self.total_earned = total_earned
        }
        if let total_reward_points = dictionary["total_reward_points"] as? Int {
            self.total_reward_points = total_reward_points
        }
        if let total_spend = dictionary["total_spend"] as? Int {
            self.total_spend = total_spend
        }
        if let nextPage = dictionary["nextPage"] as? Int {
            self.nextPage = nextPage
        }
        if let fld_total_page = dictionary["fld_total_page"] as? Int {
            self.fld_total_page = fld_total_page
        }
    }
}
class WalletModelList: NSObject {
    var fld_order_id: Int = 0
    var fld_reward_deduct_points: Int = 0
    var fld_reward_points: Int = 0
    var fld_wallet_date: String = ""
    var fld_reward_narration: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let fld_order_id = dictionary["fld_order_id"] as? Int {
            self.fld_order_id = fld_order_id
        }
        if let fld_reward_deduct_points = dictionary["fld_reward_deduct_points"] as? Int {
            self.fld_reward_deduct_points = fld_reward_deduct_points
        }
        if let fld_reward_points = dictionary["fld_reward_points"] as? Int {
            self.fld_reward_points = fld_reward_points
        }
        if let fld_wallet_date = dictionary["fld_wallet_date"] as? String {
            self.fld_wallet_date = fld_wallet_date
        }
        if let fld_reward_narration = dictionary["fld_reward_narration"] as? String {
            self.fld_reward_narration = fld_reward_narration
        }
    }
}
