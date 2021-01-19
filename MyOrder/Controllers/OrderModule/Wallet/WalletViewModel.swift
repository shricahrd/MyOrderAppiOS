//
//  WalletViewModel.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit
typealias WalletModelSuccess = (_ model: WalletModel) -> Void

class WalletViewModel: NSObject {
    func aGetWalletListServiceCall(afld_page_no: Int,
                                   aWalletModelSuccess:@escaping  WalletModelSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_wallet_type": 0,
                       "fld_page_no":afld_page_no,
                       "fld_panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kReward, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["wallet_data"] as? [[String: Any]] ?? []
                var aWalletModelList: [WalletModelList] = []
                object.forEach { order in
                    aWalletModelList.append(WalletModelList(fromDictionary: order))
                }
                let myorders = WalletModel(fromDictionary: result ?? [:], aWalletModelList: aWalletModelList)
                aWalletModelSuccess(myorders)
            }else {
                aFailed(error)
            }
        }
    }
}
