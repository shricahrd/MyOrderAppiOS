//
//  LedgerFilterViewModel.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit
typealias LedgerListSuccess = (_ model: [LedgerList]) -> Void
class LedgerFilterViewModel: NSObject {
    func getLedgerListServiceCall(aILedgerListSuccess:@escaping  LedgerListSuccess,
                                 aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kLedgerList, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["ledger_data"] as? [[String: Any]] ?? []
                var aLedgerList: [LedgerList] = []
                object.forEach { ledger in
                    aLedgerList.append(LedgerList(fromDictionary: ledger))
                }
                aILedgerListSuccess(aLedgerList)
            }else {
                aFailed(error)
            }
        }
    }
}
