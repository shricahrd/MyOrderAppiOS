//
//  RewardDetailsViewModel.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit

typealias RedeemProductAddSuccess = (_ model: String) -> Void

class RewardDetailsViewModel: NSObject {
    func aAddProductServiceCall(fld_product_id: Int,
                                fld_product_qty: String,
                                fld_product_points: Int,
                                aRedeemProductAddSuccess:@escaping  RedeemProductAddSuccess,
                                aFailed:@escaping  Failed) {
        let jsonReq = ["data":[["fld_product_id":fld_product_id, "fld_product_qty":fld_product_qty, "fld_product_points":fld_product_points]],
                       "fld_user_id":UserModel.shared.fld_user_id,
                       "fld_action_type": 0,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kRewardCartAddUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                                let object = result?["message"] as? String ?? ""
                aRedeemProductAddSuccess(object)
                //                var aRewardCatagoryList: [RewardCatagoryList] = []
                //                object.forEach { order in
                //                    aRewardCatagoryList.append(RewardCatagoryList(fromDictionary: order))
                //                }
                //                let myorders = RewardCatagoryModel(fromDictionary: result ?? [:], aRewardCatagoryList: aRewardCatagoryList)
                //                aRewardCatagoryModelSuccess(myorders)
            }else {
                aFailed(error)
            }
        }
    }
}
