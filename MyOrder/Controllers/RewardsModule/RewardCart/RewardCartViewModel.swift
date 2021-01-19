//
//  RewardCartViewModel.swift
//  MyOrder
//
//  Created by MAC-51 on 21/12/20.
//

import UIKit
typealias RewardCartModelSuccess = (_ model: RewardCartModel) -> Void
typealias RedeemUpdateSuccess = () -> Void

class RewardCartViewModel: NSObject {
    func aGetRewardCartListServiceCall(
                                   aRewardCartModelSuccess:@escaping  RewardCartModelSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kRewardCart, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["cart_data"] as? [[String: Any]] ?? []
                var aRewardCartList: [RewardCartList] = []
                object.forEach { order in
                    aRewardCartList.append(RewardCartList(fromDictionary: order))
                }
                let myorders = RewardCartModel(fromDictionary: result ?? [:], aRewardCartList: aRewardCartList)
                aRewardCartModelSuccess(myorders)
            }else {
                aFailed(error)
            }
        }
    }
    
    func aUpdateCartQtyServiceCall(fld_product_id: Int,
                                   fld_product_points: Int,
                                   fld_product_qty: String,
                                   aRedeemUpdateSuccess:@escaping  RedeemUpdateSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue,
                       "fld_action_type":2,
                       "fld_product_id":fld_product_id,
                       "fld_product_points":fld_product_points,
                       "fld_product_qty":fld_product_qty] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kRewardCartAddUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                aRedeemUpdateSuccess()
            }else {
                aFailed(error)
            }
        }
    }
    func aDeleteCartItemServiceCall(fld_product_id: Int,
                                   aRedeemUpdateSuccess:@escaping  RedeemUpdateSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue,
                       "fld_action_type":1,
                       "fld_product_id":fld_product_id,
                       ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kRewardCartAddUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                aRedeemUpdateSuccess()
            }else {
                aFailed(error)
            }
        }
    }
}
