//
//  RewardCatagoryViewModel.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit
typealias RewardCatagoryModelSuccess = (_ model: RewardCatagoryModel) -> Void

class RewardCatagoryViewModel: NSObject {
    func aGetRewardCatagoryListServiceCall(afld_page_no: Int,
                                   aRewardCatagoryModelSuccess:@escaping  RewardCatagoryModelSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_page_no":afld_page_no,
                       "fld_panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kRewardRootCat, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["Reward_Category"] as? [[String: Any]] ?? []
                var aRewardCatagoryList: [RewardCatagoryList] = []
                object.forEach { order in
                    aRewardCatagoryList.append(RewardCatagoryList(fromDictionary: order))
                }
                let myorders = RewardCatagoryModel(fromDictionary: result ?? [:], aRewardCatagoryList: aRewardCatagoryList)
                aRewardCatagoryModelSuccess(myorders)
            }else {
                aFailed(error)
            }
        }
    }
}
